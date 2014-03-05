//
// Created by Dani Postigo on 3/2/14.
//

#import <Foundation/Foundation.h>

@class DPDateTimeInputTextView;

@interface NSTextField (DPDateTimeInputTextView)

@property(nonatomic, strong) NSDate *dateInputValue;

- (DPDateTimeInputTextView *) dateInputFieldEditor;
@end