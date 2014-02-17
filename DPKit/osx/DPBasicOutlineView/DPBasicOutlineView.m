//
// Created by Dani Postigo on 2/17/14.
//

#import "DPBasicOutlineView.h"
#import "NSOutlineView+DPKit.h"

@implementation DPBasicOutlineView

@synthesize autoexpands;

- (void) reloadData {
    [super reloadData];

    if (autoexpands) {
        [self expandAllItems];
    }
}

@end