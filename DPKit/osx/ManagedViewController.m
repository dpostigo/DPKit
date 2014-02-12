//
// Created by Dani Postigo on 2/7/14.
// Copyright (c) 2014 First Person, Inc. All rights reserved.
//

#import <NSView-NewConstraints/NSView+NewConstraint.h>
#import "ManagedViewController.h"

@implementation ManagedViewController

@synthesize managedView;
@synthesize managedViewContainer;

@synthesize currentController;

- (void) setCurrentController: (NSViewController *) currentController1 {
    currentController = currentController1;
    self.managedView = currentController == nil ? nil : currentController.view;
}

- (void) setManagedView: (NSView *) managedView1 {
    if (managedView && [managedView superview]) {
        [managedView removeFromSuperview];
    }

    managedView = managedView1;

    if (managedView) {
        managedView.frame = managedViewContainer.bounds;
        managedView.translatesAutoresizingMaskIntoConstraints = NO;
        [managedViewContainer addSubview: managedView];

        [managedView superConstrainEdges];
        //        [managedView superConstrainWidth];
        //        [managedView superConstrainHeight];
        //        [managedView superConstrainCenterX];
        //        [managedView superConstrainCenterY];
    }
}


@end