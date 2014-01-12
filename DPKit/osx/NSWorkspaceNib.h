//
// Created by Dani Postigo on 1/9/14.
//

#import <Foundation/Foundation.h>

@interface NSWorkspaceNib : NSNib {
    NSMutableArray *objects;
    NSArray *controllers;
}

@property(nonatomic, strong) NSMutableArray *objects;
@property(nonatomic, strong) NSArray *controllers;

- (void) load;
- (id) objectForClass: (Class) class;
- (id) objectWithIdentifier: (NSString *) identifier;
- (id) viewForClass: (id) object;
@end