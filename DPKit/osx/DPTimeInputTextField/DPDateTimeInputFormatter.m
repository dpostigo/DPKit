//
// Created by Dani Postigo on 3/1/14.
//

#import "DPDateTimeInputFormatter.h"

@implementation DPDateTimeInputFormatter

- (NSString *) stringFromDate: (NSDate *) date {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSString *ret = date == nil ? @"--:-- --" : [super stringFromDate: date];
    return ret;
}



@end