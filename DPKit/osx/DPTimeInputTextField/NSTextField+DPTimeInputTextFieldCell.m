//
// Created by Dani Postigo on 3/1/14.
//

#import "NSTextField+DPTimeInputTextFieldCell.h"
#import "DPTimeInputTextFieldCell.h"

@implementation NSTextField (DPTimeInputTextFieldCell)

- (DPTimeInputTextFieldCell *) timeInputCell {
    return [[self cell] isKindOfClass: [DPTimeInputTextFieldCell class]] ? [self cell] : nil;
}
@end