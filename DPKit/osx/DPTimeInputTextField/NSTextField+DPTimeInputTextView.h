//
// Created by Dani Postigo on 3/2/14.
//

#import <Foundation/Foundation.h>

@interface NSTextField (DPTimeInputTextView)


@property(nonatomic) NSTimeInterval intervalValue;
@property(nonatomic) NSTimeInterval minimumIntervalValue;
- (DPTimeInputTextView *) intervalInputFieldEditor;
@end