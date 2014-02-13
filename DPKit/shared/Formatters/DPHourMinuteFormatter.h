//
// Created by Dani Postigo on 2/12/14.
//

#import <Foundation/Foundation.h>

@interface DPHourMinuteFormatter : NSFormatter {

}

- (NSInteger) minuteValueForString: (NSString *) string;
- (NSInteger) hourValueForString: (NSString *) string;
@end