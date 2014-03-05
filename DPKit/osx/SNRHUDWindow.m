//
//  SNRHUDWindow.m
//  SNRHUDKit
//
//  Created by Indragie Karunaratne on 12-01-22.
//  Copyright (c) 2012 indragie.com. All rights reserved.
//

#import "SNRHUDWindow.h"
#import "SNRHUDConstants.h"
#import "DPWindowFrameView.h"
#import "SNRHUDWindowButtonCell.h"
#import "SNRHUDWindowButton.h"

@implementation SNRHUDWindow {
    NSView *__customContentView;
}

@synthesize titleBarHeight;
@synthesize showsCloseButton;
@synthesize closeButton;

- (id) initWithContentRect: (NSRect) contentRect styleMask: (NSUInteger) aStyle backing: (NSBackingStoreType) bufferingType defer: (BOOL) flag {
    self = [super initWithContentRect: contentRect styleMask: NSResizableWindowMask backing: bufferingType defer: flag];
    if (self) {
        [self setOpaque: NO];
        [self setBackgroundColor: [NSColor clearColor]];
        [self setMovableByWindowBackground: YES];
    }

    return self;
}


- (NSRect) contentRectForFrameRect: (NSRect) windowFrame {
    windowFrame.origin = NSZeroPoint;
    windowFrame.size.height -= self.titleBarHeight;
    return windowFrame;
}

+ (NSRect) frameRectForContentRect: (NSRect) windowContentRect styleMask: (NSUInteger) windowStyle {
    windowContentRect.size.height += [[self class] titleBarHeight];
    return windowContentRect;
}

- (NSRect) frameRectForContentRect: (NSRect) windowContent {
    windowContent.size.height += self.titleBarHeight;
    return windowContent;
}

- (void) setContentView: (NSView *) aView {
    if ([__customContentView isEqualTo: aView]) {
        return;
    }
    NSRect bounds = [self frame];
    bounds.origin = NSZeroPoint;
    DPWindowFrameView *frameView = [super contentView];

    if (frameView == nil) {
        frameView = [[DPWindowFrameView alloc] initWithFrame: bounds];
        NSSize buttonSize = SNRWindowButtonSize;
        NSRect buttonRect = NSMakeRect(SNRWindowButtonEdgeMargin, NSMaxY(frameView.bounds) - (SNRWindowButtonEdgeMargin + buttonSize.height), buttonSize.width, buttonSize.height);

        closeButton = [[SNRHUDWindowButton alloc] initWithFrame: buttonRect];
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
    //    frameView.nextKeyView = __customContentView;
}


- (void) setTitle: (NSString *) aString {
    [super setTitle: aString];
    [[super contentView] setNeedsDisplay: YES];
}

- (BOOL) canBecomeKeyWindow {
    return YES;
}


#pragma mark Styling


+ (CGFloat) titleBarHeight {
    return 22.0;
}

- (CGFloat) titleBarHeight {
    return [[self class] titleBarHeight];
}


#pragma mark Necessary overrides

- (BOOL) hasTitleBar {
    return NO;
}


@end

