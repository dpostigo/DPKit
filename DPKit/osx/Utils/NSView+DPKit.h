//
// Created by Dani Postigo on 2/10/14.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface NSView (DPKit)

+ (instancetype) loadFromNib;
+ (instancetype) loadFromNib: (NSString *) nibName;
- (void) recursiveWantsLayer;
- (instancetype) loadFromNib;
- (instancetype) loadFromNib: (NSString *) nibName;
- (instancetype) loadFromNib: (NSString *) nibName owner: (id) owner;
- (NSView *) viewWithIdentifier: (NSString *) identifier;
- (void) recursivelyExecuteBlock: (void (^)(NSView *)) viewBlock;
@end