//
// Created by Dani Postigo on 2/10/14.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface NSView (DPKit)

- (void) recursiveWantsLayer;
- (instancetype) loadFromNib;
- (instancetype) loadFromNib: (NSString *) nibName;
- (NSView *) viewWithIdentifier: (NSString *) identifier;
@end