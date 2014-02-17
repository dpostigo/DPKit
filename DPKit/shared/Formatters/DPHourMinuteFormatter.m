//
// Created by Dani Postigo on 2/12/14.
//

#import "DPHourMinuteFormatter.h"

@implementation DPHourMinuteFormatter

- (NSString *) stringForObjectValue: (id) anObject {
    // We require a number


    NSString *ret = nil;
    if (anObject == nil) {
        ret = @"00:00";

    } else if (![anObject isKindOfClass: [NSNumber class]]) {
        NSLog(@"%@ was of class %@, not NSNumber", anObject, [anObject class]);

    } else {

        NSNumber *intervalNumber = anObject;
        NSTimeInterval interval = [intervalNumber doubleValue];

        if (interval > 0) {

            // For brevity, floor it
            NSInteger intervalInt = (NSInteger) interval;

            // Calculate the components
            NSInteger hours = intervalInt / (60 * 60);
            NSInteger minutes = (intervalInt / 60) - (hours * 60);
            NSInteger seconds = intervalInt - (minutes * 60) - (hours * 60 * 60);

            // Construct the string
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            [formatter setMinimumIntegerDigits: 2];
            [formatter setNumberStyle: NSNumberFormatterNoStyle];

            //    NSString *hoursString = [[formatter stringFromNumber: @(hours)] substringToIndex: 2];
            //    NSString *minutesString = [[formatter stringFromNumber: @(minutes)] substringToIndex: 2];
            NSString *hoursString = [formatter stringFromNumber: @(hours)];
            NSString *minutesString = [formatter stringFromNumber: @(minutes)];
            NSString *secondsString = [formatter stringFromNumber: @(seconds)];

            ret = [NSString stringWithFormat: @"%@:%@", hoursString, minutesString];
        }
    }

    return ret;
}

- (BOOL) getObjectValue: (id *) anObject forString: (NSString *) string errorDescription: (NSString **) error {
    NSTimeInterval interval;
    if (string == nil || [string length] == 0) {
        interval = 0;
    } else {
        // Initilize scanner
        NSScanner *scanner = [NSScanner localizedScannerWithString: string];
        [scanner setCharactersToBeSkipped: [NSCharacterSet characterSetWithCharactersInString: @":."]];

        // Gather our data
        NSInteger hour, minute;
        BOOL hourFound = [scanner scanInteger: &hour];
        BOOL minuteFound = [scanner scanInteger: &minute];



        // Validity checking
        if (!hourFound || hour < 0) {
            if (error) {
                if (!hourFound) {
                    *error = [NSString stringWithFormat: @"No hour value found"];
                }
                else {
                    *error = [NSString stringWithFormat: @"Hour evaluates to an incorrect value of %d", (int) hour];
                }
            }
            //        return NO;
        }
        else if (!minuteFound || minute < 0) {
            if (error) {
                if (!minuteFound) {
                    *error = [NSString stringWithFormat: @"No minute value found"];
                } else {
                    *error = [NSString stringWithFormat: @"Minute evaluates to an incorrect value of %d", (int) minute];
                }
            }
            //        return NO;
        }

        minute = [self truncateInteger: minute];
        hour = [self truncateInteger: hour];
        interval = (hour * 60 * 60) + (minute * 60);

    }

    *anObject = @(interval);

    //    NSLog(@"%s, string = %@, interval = %f", __PRETTY_FUNCTION__, string, interval);
    return YES;
}

- (NSInteger) truncateInteger: (NSInteger) integer {
    NSString *string = [NSString stringWithFormat: @"%li", integer];
    if (string.length > 2) {
        string = [string substringToIndex: 2];
    }
    integer = [string integerValue];
    return integer;
}

- (NSInteger) minuteValueForString: (NSString *) string {
    NSScanner *scanner = [NSScanner localizedScannerWithString: string];
    [scanner setCharactersToBeSkipped: [NSCharacterSet characterSetWithCharactersInString: @":."]];

    // Gather our data
    NSInteger hour, minute;
    BOOL hourFound = [scanner scanInteger: &hour];
    BOOL minuteFound = [scanner scanInteger: &minute];
    return minute;
}

- (NSInteger) hourValueForString: (NSString *) string {
    NSScanner *scanner = [NSScanner localizedScannerWithString: string];
    [scanner setCharactersToBeSkipped: [NSCharacterSet characterSetWithCharactersInString: @":."]];

    // Gather our data
    NSInteger hour, minute;
    BOOL hourFound = [scanner scanInteger: &hour];
    BOOL minuteFound = [scanner scanInteger: &minute];
    return hour;
}
@end