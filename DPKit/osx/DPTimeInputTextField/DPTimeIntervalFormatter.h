//
// Created by Dani Postigo on 3/2/14.
//

#import <Foundation/Foundation.h>

@interface DPTimeIntervalFormatter : NSFormatter {

    BOOL showsHours;
    BOOL showsMinutes;
    BOOL showsSeconds;
    BOOL showsMilliseconds;
}

@property(nonatomic) BOOL showsHours;
@property(nonatomic) BOOL showsMinutes;
@property(nonatomic) BOOL showsSeconds;
@property(nonatomic) BOOL showsMilliseconds;
@end