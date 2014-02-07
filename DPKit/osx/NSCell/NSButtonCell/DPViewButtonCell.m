//
// Created by Dani Postigo on 2/7/14.
//


#import "DPViewButtonCell.h"
//#import "CALayer+ConstraintUtils.h"
#import "NSCell+DPKit.h"
#import "NSView+DPFrameUtils.h"

@implementation DPViewButtonCell

- (void) drawInteriorWithFrame: (NSRect) cellFrame inView: (NSView *) controlView {
    [super drawInteriorWithFrame: cellFrame inView: controlView];
    NSLog(@"%s, cellFrame = %@", __PRETTY_FUNCTION__, NSStringFromRect(cellFrame));
}

- (void) drawWithFrame: (NSRect) cellFrame inView: (NSView *) controlView {
    [super drawWithFrame: cellFrame inView: controlView];
    NSLog(@"%s, cellFrame = %@", __PRETTY_FUNCTION__, NSStringFromRect(cellFrame));

    NSRect drawingRect = [self drawingRectForBounds: cellFrame];
    NSLog(@"drawingRect = %@", NSStringFromRect(drawingRect));
    NSLog(@"self.controlView.frame = %@", NSStringFromRect(self.controlView.frame));

    //    drawingRect.origin = NSMakePoint(0, 0);

    drawingRect = NSInsetRect(self.controlBounds, 6, 5);
    drawingRect.origin.y -= 1;

    self.overlayLayer.frame = drawingRect;
    NSLog(@"self.overlayLayer.frame = %@", NSStringFromRect(self.overlayLayer.frame));

    if (self.overlayLayer) {

        [self.controlView.layer addSublayer: self.overlayLayer];
        self.overlayLayer.opacity = 1;
        [self.controlView setNeedsDisplay: YES];
        self.overlayLayer.opacity = self.isHighlighted ? 1 : 0;
    }
}


- (CALayer *) overlayLayer {
    if (overlayLayer == nil) {
        overlayLayer = [CALayer layer];
        self.controlView.wantsLayer = YES;
        //[self.controlView.layer makeSuperlayer];
        [self.controlView.layer addSublayer: overlayLayer];
        //        [overlayLayer superConstrainEdges: 0];
        overlayLayer.backgroundColor = [NSColor colorWithDeviceWhite: 0.0 alpha: 0.5].CGColor;
    }
    return overlayLayer;
}
@end