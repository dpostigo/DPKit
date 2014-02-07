//
// Created by Dani Postigo on 2/5/14.
//

#import "NSCell+DPKit.h"

@implementation NSCell (DPKit)

- (NSRect) controlBounds {
    return self.controlView.bounds;
}


- (void) eraseControlBounds {
    [self eraseDrawingInRect: self.controlBounds];

}

- (void) eraseDrawingInRect: (NSRect) rect {
    [[NSColor clearColor] set];
    NSFrameRectWithWidthUsingOperation(rect, 1, NSCompositeSourceOut);
}
@end