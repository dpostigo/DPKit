//
// Created by Dani Postigo on 1/24/14.
//

#import "NSWindow+DPKit.h"

@implementation NSWindow (DPKit)

- (NSView *) windowThemeFrame {
    return [[self contentView] superview];
}
@end