//
// Created by Dani Postigo on 3/1/14.
//

#import <Foundation/Foundation.h>
#import "DPTimeInputTextView.h"

@class WDCountdownFormatter;

@interface DPDateTimeInputTextView : DPTimeInputTextView {

    NSDate *dateValue;
    NSDate *earliestDate;
    NSDate *latestDate;
    NSDateFormatter *dateFormatter;
}

@property(nonatomic, strong) NSDate *dateValue;
@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@property(nonatomic, strong) NSDate *earliestDate;
@property(nonatomic, strong) NSDate *latestDate;
@end