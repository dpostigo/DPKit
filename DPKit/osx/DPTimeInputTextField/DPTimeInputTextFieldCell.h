//
// Created by Dani Postigo on 2/28/14.
//

#import <Foundation/Foundation.h>
#import "DPKitDrawing.h"
#import "DPKitTextFieldCell.h"

@class DPTimeInputTextView;

@interface DPTimeInputTextFieldCell : DPKitTextFieldCell {
    DPTimeInputTextView *customFieldEditor;

}

@property(nonatomic, strong) DPTimeInputTextView *customFieldEditor;
@end