//
//  SNRHUDWindow.m
//  SNRHUDKit
//
//  Created by Indragie Karunaratne on 12-01-22.
//  Copyright (c) 2012 indragie.com. All rights reserved.
//

#import "SNRHUDWindow.h"
#import "NSBezierPath+MCAdditions.h"
#include "SNRHUDWindowFrameView.h"

#define SNRWindowTitlebarHeight         22.f
#define SNRWindowBorderColor            [NSColor blackColor]
#define SNRWindowTopColor               [NSColor colorWithDeviceWhite:0.240 alpha:0.960]
#define SNRWindowBottomColor            [NSColor colorWithDeviceWhite:0.150 alpha:0.960]
#define SNRWindowHighlightColor         [NSColor colorWithDeviceWhite:1.000 alpha:0.200]
#define SNRWindowCornerRadius           5.f

#define SNRWindowTitleFont              [NSFont systemFontOfSize:11.f]
#define SNRWindowTitleColor             [NSColor colorWithDeviceWhite:0.700 alpha:1.000]
#define SNRWindowTitleShadowOffset      NSMakeSize(0.f, 1.f)
#define SNRWindowTitleShadowBlurRadius  1.f
#define SNRWindowTitleShadowColor       [NSColor blackColor]

#define SNRWindowButtonSize             NSMakeSize(18.f, 18.f)
#define SNRWindowButtonEdgeMargin       5.f
#define SNRWindowButtonBorderColor      [NSColor colorWithDeviceWhite:0.040 alpha:1.000]
#define SNRWindowButtonGradientBottomColor  [NSColor colorWithDeviceWhite:0.070 alpha:1.000]
#define SNRWindowButtonGradientTopColor     [NSColor colorWithDeviceWhite:0.220 alpha:1.000]
#define SNRWindowButtonDropShadowColor  [NSColor colorWithDeviceWhite:1.000 alpha:0.100]
#define SNRWindowButtonCrossColor       [NSColor colorWithDeviceWhite:0.450 alpha:1.000]
#define SNRWindowButtonCrossInset       1.f
#define SNRWindowButtonHighlightOverlayColor [NSColor colorWithDeviceWhite:0.000 alpha:0.300]
#define SNRWindowButtonInnerShadowColor [NSColor colorWithDeviceWhite:1.000 alpha:0.100]
#define SNRWindowButtonInnerShadowOffset NSMakeSize(0.f, 0.f)
#define SNRWindowButtonInnerShadowBlurRadius    1.f


@implementation SNRHUDWindow {
    NSView *__customContentView;
}

- (id) initWithContentRect: (NSRect) contentRect styleMask: (NSUInteger) windowStyle backing: (NSBackingStoreType) bufferingType defer: (BOOL) deferCreation {
    if ((self = [super initWithContentRect: contentRect styleMask: NSBorderlessWindowMask backing: bufferingType defer: deferCreation])) {
        [self setOpaque: NO];
        [self setBackgroundColor: [NSColor clearColor]];
        [self setMovableByWindowBackground: YES];
        [self setLevel: NSFloatingWindowLevel];
    }
    return self;
}

- (NSRect) contentRectForFrameRect: (NSRect) windowFrame {
    windowFrame.origin = NSZeroPoint;
    windowFrame.size.height -= SNRWindowTitlebarHeight;
    return windowFrame;
}

+ (NSRect) frameRectForContentRect: (NSRect) windowContentRect
        styleMask: (NSUInteger) windowStyle {
    windowContentRect.size.height += SNRWindowTitlebarHeight;
    return windowContentRect;
}

- (NSRect) frameRectForContentRect: (NSRect) windowContent {
    windowContent.size.height += SNRWindowTitlebarHeight;
    return windowContent;
}

- (void) setContentView: (NSView *) aView {
    if ([__customContentView isEqualTo: aView]) {
        return;
    }
    NSRect bounds = [self frame];
    bounds.origin = NSZeroPoint;
    SNRHUDWindowFrameView *frameView = [super contentView];
    if (!frameView) {
        frameView = [[SNRHUDWindowFrameView alloc] initWithFrame: bounds];
        NSSize buttonSize = SNRWindowButtonSize;
        NSRect buttonRect = NSMakeRect(SNRWindowButtonEdgeMargin, NSMaxY(frameView.bounds) - (SNRWindowButtonEdgeMargin + buttonSize.height), buttonSize.width, buttonSize.height);
        NSButton *closeButton = [[NSButton alloc] initWithFrame: buttonRect];
        [closeButton setCell: [[SNRHUDWindowButtonCell alloc] init]];
        [closeButton setButtonType: NSMomentaryChangeButton];
        [closeButton setTarget: self];
        [closeButton setAction: @selector(close)];
        [closeButton setAutoresizingMask: NSViewMaxXMargin | NSViewMinYMargin];
        [frameView addSubview: closeButton];
        [super setContentView: frameView];
    }
    if (__customContentView) {
        [__customContentView removeFromSuperview];
    }
    __customContentView = aView;
    [__customContentView setFrame: [self contentRectForFrameRect: bounds]];
    [__customContentView setAutoresizingMask: NSViewWidthSizable | NSViewHeightSizable];
    [frameView addSubview: __customContentView];
}

- (NSView *) contentView {
    return __customContentView;
}

- (void) setTitle: (NSString *) aString {
    [super setTitle: aString];
    [[super contentView] setNeedsDisplay: YES];
}

- (BOOL) canBecomeKeyWindow {
    return YES;
}
@end

@implementation SNRHUDWindowButtonCell

- (void) drawWithFrame: (NSRect) cellFrame inView: (NSView *) controlView {
    NSRect drawingRect = NSInsetRect(cellFrame, 1.5f, 1.5f);
    drawingRect.origin.y = 0.5f;
    NSRect dropShadowRect = drawingRect;
    dropShadowRect.origin.y += 1.f;
    // Draw the drop shadow so that the bottom edge peeks through
    NSBezierPath *dropShadow = [NSBezierPath bezierPathWithOvalInRect: dropShadowRect];
    [SNRWindowButtonDropShadowColor set];
    [dropShadow stroke];
    // Draw the main circle w/ gradient & border on top of it
    NSBezierPath *circle = [NSBezierPath bezierPathWithOvalInRect: drawingRect];
    NSGradient *gradient = [[NSGradient alloc] initWithStartingColor: SNRWindowButtonGradientBottomColor endingColor: SNRWindowButtonGradientTopColor];
    [gradient drawInBezierPath: circle angle: 270.f];
    [SNRWindowButtonBorderColor set];
    [circle stroke];
    // Draw the cross
    NSBezierPath *cross = [NSBezierPath bezierPath];
    CGFloat boxDimension = floor(drawingRect.size.width * cos(45.f)) - SNRWindowButtonCrossInset;
    CGFloat origin = round((drawingRect.size.width - boxDimension) / 2.f);
    NSRect boxRect = NSMakeRect(1.f + origin, origin, boxDimension, boxDimension);
    NSPoint bottomLeft = NSMakePoint(boxRect.origin.x, NSMaxY(boxRect));
    NSPoint topRight = NSMakePoint(NSMaxX(boxRect), boxRect.origin.y);
    NSPoint bottomRight = NSMakePoint(topRight.x, bottomLeft.y);
    NSPoint topLeft = NSMakePoint(bottomLeft.x, topRight.y);
    [cross moveToPoint: bottomLeft];
    [cross lineToPoint: topRight];
    [cross moveToPoint: bottomRight];
    [cross lineToPoint: topLeft];
    [SNRWindowButtonCrossColor set];
    [cross setLineWidth: 2.f];
    [cross stroke];
    // Draw the inner shadow
    NSShadow *shadow = [[NSShadow alloc] init];
    [shadow setShadowColor: SNRWindowButtonInnerShadowColor];
    [shadow setShadowBlurRadius: SNRWindowButtonInnerShadowBlurRadius];
    [shadow setShadowOffset: SNRWindowButtonInnerShadowOffset];
    NSRect shadowRect = drawingRect;
    shadowRect.size.height = origin;
    [NSGraphicsContext saveGraphicsState];
    [NSBezierPath clipRect: shadowRect];
    [circle fillWithInnerShadow: shadow];
    [NSGraphicsContext restoreGraphicsState];
    if ([self isHighlighted]) {
        [SNRWindowButtonHighlightOverlayColor set];
        [circle fill];
    }
}

@end
