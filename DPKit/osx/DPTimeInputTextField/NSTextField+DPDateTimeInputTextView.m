//
// Created by Dani Postigo on 3/2/14.
//

#import "NSTextField+DPDateTimeInputTextView.h"
#import "DPDateTimeInputTextView.h"
#import "NSTextField+DPTimeInputTextFieldCell.h"
#import "DPTimeInputTextFieldCell.h"

@implementation NSTextField (DPDateTimeInputTextView)

- (DPDateTimeInputTextView *) dateInputFieldEditor {
    return (DPDateTimeInputTextView *) ((self.timeInputCell && [self.timeInputCell.customFieldEditor isKindOfClass: [DPDateTimeInputTextView class]]) ? self.timeInputCell.customFieldEditor : nil);
}

- (NSDate *) dateInputValue {
    return self.dateInputFieldEditor ? self.dateInputFieldEditor.dateValue : nil;
}

- (void) setDateInputValue: (NSDate *) dateInputValue {
    if (self.dateInputFieldEditor) {
        self.dateInputFieldEditor.dateValue = dateInputValue;
        self.stringValue = [self.dateInputFieldEditor.dateFormatter stringFromDate: self.dateInputFieldEditor.dateValue];

    }
}

@end