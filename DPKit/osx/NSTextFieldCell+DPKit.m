//
// Created by Dani Postigo on 2/1/14.
//

#import "NSTextFieldCell+DPKit.h"

@implementation NSTextFieldCell (DPKit)

- (NSRect) controlBounds {
    return self.controlView.bounds;
}

@end