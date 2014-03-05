//
// Created by Dani Postigo on 3/1/14.
//

#import <DPKit/NSObject+CallSelector.h>
#import "DPDateTimeInputTextView.h"
#import "NSDate+JMSimpleDate.h"
#import "DPDateTimeInputFormatter.h"
#import "DPTimeIntervalFormatter.h"

@implementation DPDateTimeInputTextView

@synthesize dateValue;
@synthesize dateFormatter;

@synthesize earliestDate;
@synthesize latestDate;

- (void) setup {
    [super setup];

    //    dateInputValue = [NSDate date];
    dateFormatter = [[DPDateTimeInputFormatter alloc] init];
    dateFormatter.dateFormat = @"hh:mm a";

    intervalFormatter = [[DPTimeIntervalFormatter alloc] init];
    self.string = [dateFormatter stringFromDate: dateValue];
}


#pragma mark Commands

- (void) moveDown: (id) sender {
    dateValue = dateValue == nil ? [NSDate date] : dateValue;

    NSRange range = [self rangeForProposedRange: self.selectedRange];
    NSRange lastRange = [self lastRangeForString: self.string];

    if (NSEqualRanges(range, [self firstRangeForString: self.string])) {
        self.dateValue = [dateValue dateBySubtractingHours: 1];
    } else if (NSEqualRanges(range, [self lastRangeForString: self.string])) {
        self.dateValue = [dateValue dateBySubtractingHours: 12];
    } else {
        self.dateValue = [dateValue dateBySubtractingMinutes: 1];
    }

    self.string = [dateFormatter stringForObjectValue: self.dateValue];
    self.selectedRange = range;

    [self didChangeText];
    [self setNeedsUpdateConstraints: YES];
}


- (void) moveUp: (id) sender {
    dateValue = dateValue == nil ? [NSDate date] : dateValue;

    NSRange range = [self rangeForProposedRange: self.selectedRange];
    if (NSEqualRanges(range, [self firstRangeForString: self.string])) {
        self.dateValue = [dateValue dateByAddingHours: 1];
    } else if (NSEqualRanges(range, [self lastRangeForString: self.string])) {
        self.dateValue = [dateValue dateByAddingHours: 12];
    } else {
        self.dateValue = [dateValue dateByAddingMinutes: 1];
    }

    self.string = [dateFormatter stringForObjectValue: self.dateValue];;
    self.selectedRange = range;
    [self didChangeText];
}

- (BOOL) isHourRange: (NSRange) range {
    NSRange firstRange = [self firstRangeForString: self.string];
    return NSEqualRanges(range, firstRange);
}



#pragma mark Date value

- (void) setDateValue: (NSDate *) dateValue1 {
    if (dateValue != dateValue1) {
        if (latestDate && [dateValue1 isLaterThanDate: latestDate]) {
            NSTimeInterval interval = [dateValue1 timeIntervalSinceDate: latestDate];
            if (interval > 60) {
                return;
            } else {
                dateValue1 = [dateValue1 dateByAddingTimeInterval: -interval];
            }
        }
        if (earliestDate && [dateValue1 isEarlierThanDate: earliestDate]) {
            NSTimeInterval interval = [dateValue1 timeIntervalSinceDate: latestDate];
            if (interval > 60) {
                return;
            } else {
                dateValue1 = [dateValue1 dateByAddingTimeInterval: interval];
            }
            return;
        }

        dateValue = dateValue1;
        [self forwardSelector: @selector(timeInputTextView:didChangeValue:) delegate: timeInputDelegate object: self object: dateValue];
    }
}

- (NSFormatter *) formatter {
    return dateFormatter;
}


@end