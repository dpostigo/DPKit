//
// Created by Dani Postigo on 2/12/14.
// Copyright (c) 2014 Dani Postigo. All rights reserved.
//

#import "DPTimeInputTextField.h"
#import "DPHourMinuteFormatter.h"

@implementation DPTimeInputTextField

- (void) awakeFromNib {
    [super awakeFromNib];
    self.doubleValue = 0;
    super.delegate = self;
}


- (void) moveUp: (id) sender {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [super moveUp: sender];
}


- (BOOL) control: (NSControl *) control textView: (NSTextView *) textView doCommandBySelector: (SEL) commandSelector {
    BOOL ret = NO;
    if (commandSelector == @selector(moveUp:)) {
        self.doubleValue += self.currentIncrementValue;
        ret = YES;

    } else if (commandSelector == @selector(moveDown:)) {
        self.doubleValue -= self.currentIncrementValue;
        ret = YES;

    } else if (commandSelector == @selector(moveLeft:)) {
        self.currentEditor.selectedRange = self.hourRange;
        ret = YES;

    } else if (commandSelector == @selector(moveRight:)) {
        self.currentEditor.selectedRange = self.minuteRange;
        ret = YES;

    } else if (commandSelector == @selector(insertTab:)) {
        NSString *string = self.currentEditor.string;
        if (self.caretLocation <= self.dividerLocation) {
            self.currentEditor.selectedRange = self.minuteRange;
            ret = YES;

        }
    } else if (commandSelector == @selector(selectAll:)) {
        NSLog(@"%s", __PRETTY_FUNCTION__);
    }
    return ret;
}

//- (BOOL) control: (NSControl *) control didFailToFormatString: (NSString *) string errorDescription: (NSString *) error {
//    NSLog(@"%s", __PRETTY_FUNCTION__);
//    NSLog(@"string = %@", string);
//    if (self.hourMinuteFormatter) {
//
//        NSString *correctedHour = [[NSString stringWithFormat: @"%li", [self.hourMinuteFormatter hourValueForString: string]] substringToIndex: 2];
//        NSString *correctedMinute = [[NSString stringWithFormat: @"%li", [self.hourMinuteFormatter minuteValueForString: string]] substringToIndex: 2];
//
//    }
//
//    return YES;
//}


- (void) selectText: (id) sender {
    [super selectText: sender];
    self.currentEditor.selectedRange = self.hourRange;
}



//
//
//- (BOOL) control: (NSControl *) control textShouldBeginEditing: (NSText *) fieldEditor {
//    NSLog(@"%s", __PRETTY_FUNCTION__);
//    return NO;
//}
//
//- (void) textDidEndEditing: (NSNotification *) notification {
//    [super textDidEndEditing: notification];
//}
//
//- (void) textDidChange: (NSNotification *) notification {
//    [super textDidChange: notification];
//    NSLog(@"%s", __PRETTY_FUNCTION__);
//}
//
//
//- (BOOL) textShouldBeginEditing: (NSText *) textObject {
//    NSLog(@"%s", __PRETTY_FUNCTION__);
//    return [super textShouldBeginEditing: textObject];
//}
//
//
//- (void) textDidBeginEditing: (NSNotification *) notification {
//    [super textDidBeginEditing: notification];
//    NSLog(@"%s", __PRETTY_FUNCTION__);
//    self.currentEditor.selectedRange = self.hourRange;
//
//}


- (void) setDelegate: (id <NSTextFieldDelegate>) anObject {
    __delegate = anObject;
}

- (NSTimeInterval) currentIncrementValue {
    NSTimeInterval ret = 0;
    NSRange range = self.currentEditor.selectedRange;
    if (range.length == 2) {
        if (range.location == 0) {
            ret = self.hour;
        } else if (range.location == 3) {
            ret = self.minute;
        }
    }
    return ret;

}

- (NSRange) hourRange {
    return NSMakeRange(0, 2);
}

- (NSRange) minuteRange {
    return NSMakeRange(self.dividerLocation + 1, 2);
}

- (NSTimeInterval) minute {
    return 60;
}

- (NSTimeInterval) hour {
    return 60 * 60;
}


- (NSUInteger) caretLocation {
    return self.currentEditor.selectedRange.location;
}

- (NSUInteger) dividerLocation {
    return [self dividerLocationForString: self.currentEditor.string];
}

- (NSUInteger) dividerLocationForString: (NSString *) string {
    return [string rangeOfString: @":"].location;
}


- (DPHourMinuteFormatter *) hourMinuteFormatter {
    return [self.formatter isKindOfClass: [DPHourMinuteFormatter class]] ? self.formatter : nil;
}

@end