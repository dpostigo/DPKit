//
// Created by Dani Postigo on 2/6/14.
//

#import <Foundation/Foundation.h>

@interface DPComboBoxCell : NSComboBoxCell {

    NSColor *borderColor;
    BOOL debugMode;
    NSEdgeInsets insets;
}
@property(nonatomic) NSEdgeInsets insets;
@property(nonatomic) BOOL debugMode;
@property(nonatomic, strong) NSColor *borderColor;

- (void) setup;

@end