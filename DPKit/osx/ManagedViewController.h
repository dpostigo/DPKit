//
// Created by Dani Postigo on 2/7/14.
// Copyright (c) 2014 First Person, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DPKit/DPViewController.h>

@interface ManagedViewController : DPViewController {

    NSViewController *currentController ;
    NSView *managedView;
    IBOutlet NSView *managedViewContainer;
}

@property(nonatomic, strong) NSView *managedView;
@property(nonatomic, strong) NSView *managedViewContainer;
@property(nonatomic, strong) NSViewController *currentController;
@end