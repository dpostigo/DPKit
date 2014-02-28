//
//  SNRHUDWindow.h
//  SNRHUDKit
//
//  Created by Indragie Karunaratne on 12-01-22.
//  Copyright (c) 2012 indragie.com. All rights reserved.
//

#import <AppKit/AppKit.h>

// TODO: Add close button

@interface SNRHUDWindow : NSWindow {
    NSButton *closeButton;

    CGFloat titleBarHeight;
}

@property(nonatomic) CGFloat titleBarHeight;

+ (CGFloat) titleBarHeight;
@end