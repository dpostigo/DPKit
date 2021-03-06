//
// Created by Dani Postigo on 1/24/14.
//

#import "NSWindow+DPKit.h"

@implementation NSWindow (DPKit)

- (NSView *) windowThemeFrame {
    return [[self contentView] superview];
}

- (NSView *) contentAsView {
    return [self contentView];
}


- (NSRect) bounds {
    NSRect ret = self.frame;
    ret.origin = NSMakePoint(0, 0);
    return ret;
}
@end