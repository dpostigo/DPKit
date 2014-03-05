//
// Created by Dani Postigo on 3/2/14.
//

#import <Foundation/Foundation.h>

@class DPTimeInputTextView;

@protocol DPTimeInputTextViewDelegate <NSObject>

@optional
- (void) timeInputTextView: (DPTimeInputTextView *) textView didChangeValue: (id) value;
@end