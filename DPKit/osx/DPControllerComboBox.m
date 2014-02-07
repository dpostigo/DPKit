//
// Created by Dani Postigo on 2/6/14.
//

#import "DPControllerComboBox.h"

@implementation DPControllerComboBox {
    id _target;
    SEL _action;
}

@synthesize controller;

- (void) awakeFromNib {
    [super awakeFromNib];

    if ([controller.selectedObjects count] > 0) {
        [self selectItemAtIndex: controller.selectionIndex];
    }

    super.target = self;
    super.action = @selector(handleSection:);
}


- (void) handleSection: (id) sender {
    NSInteger selectedIndex = self.indexOfSelectedItem;
    if (selectedIndex != -1 && controller.selectionIndex != self.indexOfSelectedItem) {
        controller.selectionIndex = (NSUInteger) self.indexOfSelectedItem;
        [self sendAction: _action to: _target];
    }
}


- (void) selectItemAtIndex: (NSInteger) index {
    if (index > -1) {
        [super selectItemAtIndex: index];
    }
}

- (void) deselect {
    if (self.indexOfSelectedItem) {
        [self deselectItemAtIndex: self.indexOfSelectedItem];
    }
}

- (void) setTarget: (id) anObject {
    _target = anObject;
    //    [super setTarget: anObject];
}

- (void) setAction: (SEL) aSelector {
    _action = aSelector;
    //    [super setAction: aSelector];
}


@end