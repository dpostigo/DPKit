//
// Created by Dani Postigo on 2/5/14.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface NSCell (DPKit)

- (NSRect) controlBounds;
- (void) eraseControlBounds;
- (void) eraseDrawingInRect: (NSRect) rect;
@end