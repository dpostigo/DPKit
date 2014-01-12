//
// Created by Dani Postigo on 1/10/14.
//

#import "NSArray+DPKit.h"

@implementation NSArray (DPKit)

- (NSArray *) objectsOfType: (Class) class {
    NSMutableArray *ret = [[NSMutableArray alloc] init];

    for (id object in self) {
        if ([object isKindOfClass: class]) {
            [ret addObject: object];
        }
    }
    return ret;
}
@end