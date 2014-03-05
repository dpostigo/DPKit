//
// Created by Dani Postigo on 2/28/14.
//

#import <Foundation/Foundation.h>

@protocol DPTimeInputTextViewDelegate;
@class DPTimerCountdownFormatter;
@class DPTimeIntervalFormatter;

@interface DPTimeInputTextView : NSTextView {
    NSTimeInterval minimumIntervalValue;
    NSTimeInterval maximumIntervalValue;
    NSTimeInterval intervalValue;

    __unsafe_unretained id <DPTimeInputTextViewDelegate> timeInputDelegate;
    NSCharacterSet *characterSet;
    NSNumberFormatter *numberFormatter;
    NSCharacterSet *dividerCharacterSet;
    DPTimeIntervalFormatter *intervalFormatter;
}

@property(nonatomic, strong) NSCharacterSet *characterSet;
@property(nonatomic, strong) NSNumberFormatter *numberFormatter;
@property(nonatomic, strong) NSCharacterSet *dividerCharacterSet;
@property(nonatomic, assign) id <DPTimeInputTextViewDelegate> timeInputDelegate;
@property(nonatomic) NSTimeInterval intervalValue;
@property(nonatomic, strong) DPTimeIntervalFormatter *intervalFormatter;
@property(nonatomic) NSTimeInterval minimumIntervalValue;
- (void) setup;


- (NSRange) nextRangeForRange: (NSRange) range;
- (NSRange) nextRangeForRange: (NSRange) range string: (NSString *) string;
- (NSRange) previousRangeForRange: (NSRange) range string: (NSString *) string;

- (NSRange) firstRangeForString: (NSString *) string;
- (NSRange) lastRangeForString: (NSString *) string;

- (double) doubleValueForRange: (NSRange) range;
- (NSRange) rangeForProposedRange: (NSRange) startingRange;

- (NSFormatter *) formatter;
@end