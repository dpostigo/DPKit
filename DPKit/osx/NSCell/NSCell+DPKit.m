//
// Created by Dani Postigo on 2/5/14.
//

#import "NSCell+DPKit.h"

@implementation NSCell (DPKit)

- (NSRect) controlBounds {
    return self.controlView.bounds;
}
@end