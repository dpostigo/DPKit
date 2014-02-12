//
// Created by Dani Postigo on 2/10/14.
//

#import "NSView+DPKit.h"

@implementation NSView (DPKit)

- (void) recursiveWantsLayer {

    NSView *superview = self.superview;
    while (superview) {
        superview.wantsLayer = YES;
        superview.layer.masksToBounds = NO;
        superview = superview.superview;
    }
}
@end