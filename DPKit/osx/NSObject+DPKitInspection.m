//
// Created by Dani Postigo on 3/5/14.
//

#import "NSObject+DPKitInspection.h"

@implementation NSObject (DPKitInspection)

- (IMP) impForSelector: (SEL) selector {
    IMP ret = nil;
    if (self && [self respondsToSelector: selector]) {
        ret = [self methodForSelector: selector];
    }
    return ret;
}

@end