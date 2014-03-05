//
// Created by Dani Postigo on 3/2/14.
//

#import "DPTimeIntervalFormatter.h"

@implementation DPTimeIntervalFormatter {

}

@synthesize showsHours;
@synthesize showsMinutes;
@synthesize showsSeconds;
@synthesize showsMilliseconds;

- (id) init {
    self = [super init];
    if (self) {
        [self setup];
    }

    return self;
}

- (id) initWithCoder: (NSCoder *) coder {
    self = [super initWithCoder: coder];
    if (self) {
        NSLog(@"%s", __PRETTY_FUNCTION__);

    }

    return self;
}

- (void) setup {
    showsHours = YES;
    showsMinutes = YES;
}


- (NSString *) stringForObjectValue: (id) anObject {

    NSString *ret = nil;

    if ([anObject isKindOfClass: [NSNumber class]]) {

        NSNumber *numberValue = anObject;
        NSTimeInterval interval = [numberValue doubleValue];




        // Calculate the components
        NSInteger hours = interval / (60 * 60);
        NSInteger minutes = (interval / 60) - (hours * 60);
        NSInteger seconds = interval - (minutes * 60) - (hours * 60 * 60);
        NSInteger milliseconds = 10 * (interval - (seconds) - (minutes * 60) - (hours * 60 * 60));


        // Construct the string
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setMinimumIntegerDigits: 2];
        [formatter setNumberStyle: NSNumberFormatterNoStyle];

        NSString *hoursString = [formatter stringFromNumber: @(hours)];
        NSString *minutesString = [formatter stringFromNumber: @(minutes)];
        NSString *secondsString = [formatter stringFromNumber: @(seconds)];
        NSString *millisecondsString = [formatter stringFromNumber: @(milliseconds)];


        NSMutableString *string = [[NSMutableString alloc] initWithFormat: @"%@:%@:%@", hoursString, minutesString, secondsString];

        string = [[NSMutableString alloc] initWithString: @""];
        if (showsHours) [string appendFormat: @"%@:", hoursString];
        if (showsMinutes) [string appendFormat: @"%@:", minutesString];
        if (showsSeconds) [string appendFormat: @"%@:", secondsString];
        if (showsMilliseconds) [string appendFormat: @"%@:", showsMilliseconds];

        NSUInteger lastIndex = [string length] - 1;
        NSString *lastCharacter = [string substringFromIndex: lastIndex];

        if ([lastCharacter isEqualToString: @":"]) [string deleteCharactersInRange: NSMakeRange(lastIndex, 1)];
        ret = string;
    }

    return ret;
}
@end