//
// Created by Dani Postigo on 2/2/14.
//

#import "DPInnerShadowView.h"

@implementation DPInnerShadowView

- (void) drawRect: (NSRect) dirtyRect {

    NSRect bounds = self.bounds;
    NSShadow *shadow = [[NSShadow alloc] init];

    [shadow setShadowBlurRadius: 3.0];
    [shadow setShadowOffset: NSMakeSize(0, -1)];
    [shadow setShadowColor: [NSColor blackColor]];

    [NSGraphicsContext saveGraphicsState];
    [[NSGraphicsContext currentContext] setCompositingOperation: NSCompositeSourceOver];

    //    [shadow set];
    //    [[NSColor clearColor] set];
    //    [path fill];

    [shadow set];
    [[NSColor grayColor] setFill];
    [[NSColor grayColor] setStroke];
    NSRectFillUsingOperation(bounds, NSCompositeSourceOver);

    [[NSColor darkGrayColor] set];
    NSFrameRectWithWidthUsingOperation(bounds, 1, NSCompositeSourceOver);

    [NSGraphicsContext restoreGraphicsState];

}

@end