//
// Created by Dani Postigo on 3/2/14.
//

#import <DPKit/DPTimeInputTextView.h>
#import <DPKit/NSTextField+DPTimeInputTextFieldCell.h>
#import <DPKit/DPTimeInputTextFieldCell.h>
#import "NSTextField+DPTimeInputTextView.h"
#import "DPTimeIntervalFormatter.h"

@implementation NSTextField (DPTimeInputTextView)

- (DPTimeInputTextView *) intervalInputFieldEditor {
    return (DPTimeInputTextView *) ((self.timeInputCell && [self.timeInputCell.customFieldEditor isKindOfClass: [DPTimeInputTextView class]]) ? self.timeInputCell.customFieldEditor : nil);
}

- (NSTimeInterval) intervalValue {
    return self.intervalInputFieldEditor ? self.intervalInputFieldEditor.intervalValue : 0;
}

- (void) setIntervalValue: (NSTimeInterval) intervalValue {
    if (self.intervalInputFieldEditor) {
        self.intervalInputFieldEditor.intervalValue = intervalValue;
        self.stringValue = [self.intervalInputFieldEditor.intervalFormatter stringForObjectValue: [NSNumber numberWithDouble: intervalValue]];
    }
}


- (NSTimeInterval) minimumIntervalValue {
    return self.intervalInputFieldEditor ? self.intervalInputFieldEditor.minimumIntervalValue : 0;
}

- (void) setMinimumIntervalValue: (NSTimeInterval) minimumIntervalValue {
    if (self.intervalInputFieldEditor) {
        self.intervalInputFieldEditor.minimumIntervalValue = minimumIntervalValue;
        if (self.intervalInputFieldEditor.intervalValue < minimumIntervalValue) {
            self.stringValue = [self.intervalInputFieldEditor.intervalFormatter stringForObjectValue: [NSNumber numberWithDouble: minimumIntervalValue]];
        }
    }
}



//- (NSDate *) dateInputValue {
//    return self.intervalInputFieldEditor ? self.intervalInputFieldEditor.intervalValue : nil;
//}
//
//- (void) setDateInputValue: (NSDate *) dateInputValue {
//    if (self.intervalInputFieldEditor) {
//        self.intervalInputFieldEditor.dateValue = dateInputValue;
//        self.stringValue = [self.intervalInputFieldEditor.dateFormatter stringFromDate: self.dateInputFieldEditor.dateValue];
//    }
//}

@end