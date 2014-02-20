//
// Created by Dani Postigo on 2/17/14.
//

#import <Foundation/Foundation.h>

@protocol DPBasicOutlineViewDelegate;

@interface DPBasicOutlineView : NSOutlineView {

    __unsafe_unretained id <DPBasicOutlineViewDelegate> outlineDelegate;
    BOOL autoexpands;
    IBOutlet NSTreeController *controller;
}

@property(nonatomic) BOOL autoexpands;
@property(nonatomic, strong) NSTreeController *controller;
@property(nonatomic, assign) id <DPBasicOutlineViewDelegate> outlineDelegate;
@end