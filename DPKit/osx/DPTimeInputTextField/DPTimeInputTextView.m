//
// Created by Dani Postigo on 2/28/14.
//

#import "DPTimeInputTextView.h"
#import "DPTimeIntervalFormatter.h"

@implementation DPTimeInputTextView

@synthesize characterSet;
@synthesize numberFormatter;
@synthesize dividerCharacterSet;

@synthesize timeInputDelegate;

@synthesize intervalValue;

@synthesize intervalFormatter;

@synthesize minimumIntervalValue;

- (id) initWithFrame: (NSRect) frameRect {
    self = [super initWithFrame: frameRect];
    if (self) {
        [self setup];
    }

    return self;
}

- (void) setup {

    intervalFormatter = [[DPTimeIntervalFormatter alloc] init];
    numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setMinimumIntegerDigits: 2];
    [numberFormatter setNumberStyle: NSNumberFormatterNoStyle];

    characterSet = [NSCharacterSet characterSetWithCharactersInString: @":0123456789"];
    dividerCharacterSet = [NSCharacterSet characterSetWithCharactersInString: @": "];
}

//
//- (void) moveDown: (id) sender {
//    NSRange range = [self rangeForProposedRange: self.selectedRange];
//
//    currentValue = fmax(0, currentValue - 1);
//    [self replaceCharactersInRange: range withString: [numberFormatter stringFromNumber: [NSNumber numberWithDouble: currentValue]]];
//    self.selectedRange = range;
//}
//

- (void) moveDown: (id) sender {

    NSRange range = [self rangeForProposedRange: self.selectedRange];
    NSRange lastRange = [self lastRangeForString: self.string];

    if (NSEqualRanges(range, self.hourRange)) {
        self.intervalValue -= 60 * 60;
    } else if (NSEqualRanges(range, self.minuteRange)) {
        self.intervalValue -= 60;
    } else if (NSEqualRanges(range, self.secondRange)) {
        self.intervalValue -= 1;
    }

    self.string = [intervalFormatter stringForObjectValue: [NSNumber numberWithDouble: self.intervalValue]];
    self.selectedRange = range;
}


- (void) moveUp: (id) sender {
    NSRange range = [self rangeForProposedRange: self.selectedRange];
    NSRange lastRange = [self lastRangeForString: self.string];

    NSLog(@"self.minuteRange = %@", NSStringFromRange(self.minuteRange));

    if (NSEqualRanges(range, self.hourRange)) {
        self.intervalValue += 60 * 60;
    } else if (NSEqualRanges(range, self.minuteRange)) {
        self.intervalValue += 60;
    } else if (NSEqualRanges(range, self.secondRange)) {
        self.intervalValue += 1;
    }

    self.string = [intervalFormatter stringForObjectValue: [NSNumber numberWithDouble: self.intervalValue]];
    self.selectedRange = range;
}


- (void) moveLeft: (id) sender {
    self.selectedRange = [self previousRangeForRange: self.selectedRange];
}

- (void) moveRight: (id) sender {
    NSRange selectedRange = self.selectedRange;

    if (selectedRange.location + selectedRange.length < [self.string length]) {
        self.selectedRange = [self nextRangeForRange: self.selectedRange];
    } else {
        [super moveRight: sender];
    }
}

- (void) insertTab: (id) sender {
    NSRange selectedRange = self.selectedRange;
    if (selectedRange.location + selectedRange.length < [self.string length]) {
        self.selectedRange = [self nextRangeForRange: self.selectedRange];
    } else {
        [super insertTab: sender];
    }

}




#pragma mark Other

- (void) setIntervalValue: (NSTimeInterval) intervalValue1 {
    if (intervalValue != intervalValue1) {
        if (intervalValue1 < minimumIntervalValue) {
            return;
        }

        if (maximumIntervalValue > 0 && intervalValue1 > maximumIntervalValue) return;
        intervalValue = intervalValue1;
    }
}


- (double) doubleValueForRange: (NSRange) range {
    NSString *string = [self.string substringWithRange: range];
    return [string doubleValue];
}







#pragma mark Restrict

- (BOOL) shouldChangeTextInRange: (NSRange) affectedCharRange replacementString: (NSString *) replacementString {
    BOOL ret = [super shouldChangeTextInRange: affectedCharRange replacementString: replacementString];
    if (![replacementString isEqualToString: @""] && [replacementString rangeOfCharacterFromSet: characterSet].location == NSNotFound) {
        ret = NO;
    }
    return ret;
}


#pragma mark Ranges

- (NSRange) hourRange {
    return [self firstRangeForString: self.string];
}

- (NSRange) minuteRange {
    return [self nextRangeForRange: self.hourRange];
}

- (NSRange) secondRange {
    return [self nextRangeForRange: self.minuteRange];
}

#pragma mark Selecting the digits

- (NSRange) selectionRangeForProposedRange: (NSRange) proposedCharRange granularity: (NSSelectionGranularity) granularity {
    NSRange ret = [super selectionRangeForProposedRange: proposedCharRange granularity: granularity];
    if (proposedCharRange.length == 0 && [self.string length] > 0) {
        ret = [self rangeForProposedRange: proposedCharRange];
    }
    return ret;
}


- (NSRange) rangeForProposedRange: (NSRange) startingRange {
    NSRange ret = startingRange;

    NSUInteger location = 0;
    NSUInteger length = 0;
    NSString *string = self.string;

    NSRange backwardsRange = [string rangeOfCharacterFromSet: dividerCharacterSet options: NSBackwardsSearch range: NSMakeRange(0, startingRange.location)];
    location = backwardsRange.location == NSNotFound ? 0 : backwardsRange.location + backwardsRange.length;

    NSRange forwardRange = [string rangeOfCharacterFromSet: dividerCharacterSet options: NSLiteralSearch range: NSMakeRange(location, [string length] - location)];
    length = (forwardRange.location == NSNotFound ? [string length] : forwardRange.location) - location;

    //    NSString *selectedText = [string substringWithRange: NSMakeRange(location, length)];
    //    NSLog(@"startingRange = %@, newRange = {%lu, %lu}, text = %@", NSStringFromRange(startingRange), location, length, selectedText);

    ret = NSMakeRange(location, length);
    return ret;

}

- (NSRange) nextRangeForRange: (NSRange) range {
    return [self nextRangeForRange: range string: self.string];

}

- (NSRange) nextRangeForRange: (NSRange) range string: (NSString *) string {
    NSRange ret = range;

    NSUInteger location = 0;
    NSUInteger length = 0;

    location = range.location + range.length;

    NSRange forwardRange = [string rangeOfCharacterFromSet: dividerCharacterSet options: NSLiteralSearch range: NSMakeRange(location, [string length] - location)];

    if (forwardRange.location != NSNotFound) {
        location = forwardRange.location + forwardRange.length;

        forwardRange = [string rangeOfCharacterFromSet: dividerCharacterSet options: NSLiteralSearch range: NSMakeRange(location, [string length] - location)];
        length = (forwardRange.location == NSNotFound ? [string length] : forwardRange.location) - location;
        ret = NSMakeRange(location, length);
    }

    return ret;

}

- (NSRange) previousRangeForRange: (NSRange) range {
    return [self previousRangeForRange: range string: self.string];
}

- (NSRange) previousRangeForRange: (NSRange) range string: (NSString *) string {
    NSRange ret = range;

    NSUInteger location = 0;
    NSUInteger length = 0;

    NSRange backwardsRange = [string rangeOfCharacterFromSet: dividerCharacterSet options: NSBackwardsSearch range: NSMakeRange(0, range.location)];

    if (backwardsRange.location != NSNotFound) {
        NSUInteger endLocation = backwardsRange.location;
        backwardsRange = [string rangeOfCharacterFromSet: dividerCharacterSet options: NSBackwardsSearch range: NSMakeRange(0, backwardsRange.location)];
        location = backwardsRange.location == NSNotFound ? 0 : (backwardsRange.location + backwardsRange.length);
        length = endLocation - location;
        ret = NSMakeRange(location, length);
    } else {
    }
    return ret;

}

- (NSRange) firstRangeForString: (NSString *) string {
    NSRange ret;
    NSUInteger location = 0;
    NSUInteger length = 0;

    NSRange forwardRange = [string rangeOfCharacterFromSet: dividerCharacterSet options: NSLiteralSearch range: NSMakeRange(location, [string length] - location)];
    if (forwardRange.location != NSNotFound) {
        length = forwardRange.location;
    }

    ret = NSMakeRange(location, length);
    return ret;
}

- (NSRange) lastRangeForString: (NSString *) string {
    NSRange ret;
    NSUInteger location = 0;
    NSUInteger length = 0;

    NSRange backwardsRange = [string rangeOfCharacterFromSet: dividerCharacterSet options: NSBackwardsSearch range: NSMakeRange(location, [string length] - location)];

    if (backwardsRange.location != NSNotFound) {
        location = backwardsRange.location == NSNotFound ? 0 : backwardsRange.location + backwardsRange.length;
        NSRange forwardRange = [string rangeOfCharacterFromSet: dividerCharacterSet options: NSLiteralSearch range: NSMakeRange(location, [string length] - location)];
        length = (forwardRange.location == NSNotFound ? [string length] : forwardRange.location) - location;

    }

    ret = NSMakeRange(location, length);
    return ret;
}


- (NSFormatter *) formatter {
    return numberFormatter;
}

@end