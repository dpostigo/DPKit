//
// Created by Dani Postigo on 2/6/14.
//

#import "NSCell+DPKitUnderline.h"
#import "NSCell+DPKit.h"

@implementation NSCell (DPKitUnderline)

- (NSRect) underlineRect {
    NSRect lineRect = [self titleRectForBounds: self.controlBounds];
    if ([self isKindOfClass: [NSComboBoxCell class]]) {
        lineRect = [self drawingRectForBounds: self.controlBounds];
    }
    lineRect.size.height = 1;
    lineRect.origin.y = self.controlBounds.size.height - 1;
    lineRect.origin.x += 1.5;
    return lineRect;
}
@end