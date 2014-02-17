//
// Created by Dani Postigo on 2/12/14.
// Copyright (c) 2014 Dani Postigo. All rights reserved.
//

#import <DPKit/NSString+DPKitUtils.h>
#import "DPTimeInputTextField.h"
#import "DPHourMinuteFormatter.h"

@implementation DPTimeInputTextField {
    NSTrackingArea *trackingArea;
}

- (void) awakeFromNib {
    [super awakeFromNib];

    NSLog(@"%s, self.doubleValue = %f", __PRETTY_FUNCTION__, self.doubleValue);
    super.delegate = self;

}

- (void) setStringValue: (NSString *) aString {
    [super setStringValue: aString];
}

- (void) setDoubleValue: (double) aDouble {
    [super setDoubleValue: aDouble];
    //    NSLog(@"%s, self.doubleValue = %f", __PRETTY_FUNCTION__, self.doubleValue);
    //    NSLog(@"%s", __PRETTY_FUNCTION__);
    //    self.objectValue = [NSNumber numberWithDouble: self.doubleValue];
}


- (void) updateTrackingAreas {
    [super updateTrackingAreas];
    trackingArea = [[NSTrackingArea alloc] initWithRect: self.frame options: (NSTrackingActiveInKeyWindow | NSTrackingMouseEnteredAndExited | NSTrackingCursorUpdate) owner: self userInfo: nil];
    [self addTrackingArea: trackingArea];

}


- (void) cursorUpdate: (NSEvent *) event {

    [[NSCursor crosshairCursor] set];

}


- (void) mouseDown: (NSEvent *) theEvent {
    [super mouseDown: theEvent];
    //    [self setEnabled: YES];
    self.currentEditor.selectedRange = self.hourRange;
}

- (void) mouseMoved: (NSEvent *) theEvent {
    //    NSLog(@"%s", __PRETTY_FUNCTION__);
    [super mouseMoved: theEvent];
}

- (void) mouseExited: (NSEvent *) theEvent {
    //    NSLog(@"%s", __PRETTY_FUNCTION__);
    [super mouseExited: theEvent];
}


- (void) mouseEntered: (NSEvent *) theEvent {
    //    NSLog(@"%s", __PRETTY_FUNCTION__);
    [super mouseEntered: theEvent];
}



#pragma mark Keys

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
        NSLog(@"commandSelector = %@", NSStringFromSelector(commandSelector));
    }
    return ret;
}


- (BOOL) becomeFirstResponder {
    NSLog(@"%s", __PRETTY_FUNCTION__);

    return [super becomeFirstResponder];
}

- (void) cancelOperation: (id) sender {
    NSUInteger dividerLocation = self.dividerLocation;

    if ([self.currentEditor.string containsString: @":"] && self.currentEditor.selectedRange.length > 0) {
        if (NSEqualRanges(self.currentEditor.selectedRange, self.hourRange)) {
            self.currentEditor.selectedRange = NSMakeRange(self.dividerLocation, 0);
        } else {
            self.currentEditor.selectedRange = NSMakeRange([self.currentEditor.string length], 0);
        }
    }
}

- (void) selectAll: (id) sender {
    //    [super selectAll: sender];
    NSLog(@"%s", __PRETTY_FUNCTION__);
}


- (void) selectText: (id) sender {
    [super selectText: sender];
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.currentEditor.selectedRange = self.hourRange;
}


- (void) setDelegate: (id <NSTextFieldDelegate>) anObject {
    __delegate = anObject;
}

- (NSTimeInterval) currentIncrementValue {
    NSTimeInterval ret = self.minute;
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