//
// Created by Dani Postigo on 2/20/14.
//

#import "SNRHUDWindowButtonCell.h"
#import "NSBezierPath+MCAdditions.h"
#import "SNRHUDConstants.h"

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