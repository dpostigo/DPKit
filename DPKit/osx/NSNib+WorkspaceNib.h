//
// Created by Dani Postigo on 1/8/14.
//

#import <Foundation/Foundation.h>

@interface NSNib (WorkspaceNib)

- (NSArray *) controllersForNib;
- (id) nibControllerForClassReference: (Class) class;
- (id) nibControllerForClassString: (NSString *) classString;
- (id) nibViewForClass: (id) object;
- (NSView *) nibViewForClassString: (NSString *) classString;
- (NSView *) nibViewForClassReference: (Class) class;
@end