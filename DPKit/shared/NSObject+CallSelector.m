//
// Created by Dani Postigo on 1/16/14.
//

#import "NSObject+CallSelector.h"

@implementation NSObject (CallSelector)


#pragma mark Return values

- (CGFloat) returnFloat: (SEL) selector delegate: (id) delegate object: (id) object {
    return [self returnFloat: selector delegate: delegate object: object object: nil object: nil];
}

- (CGFloat) returnFloat: (SEL) selector delegate: (id) delegate object: (id) object object: (id) object2 {
    return [self returnFloat: selector delegate: delegate object: object object: object2 object: nil];
}

- (CGFloat) returnFloat: (SEL) selector delegate: (id) delegate object: (id) object object: (id) object2 object: (id) object3 {
    CGFloat ret = 0;
    if (delegate && [delegate respondsToSelector: selector]) {
        id theDelegate = delegate;
        IMP imp = [theDelegate methodForSelector: selector];
        CGFloat (*func)(id, SEL, id, id, id) = (void *) imp;
        ret = func(theDelegate, selector, object, object2, object3);
    }
    return ret;
}


#pragma mark Forward to single delegate
- (void) forwardSelector: (SEL) selector delegate: (id) delegate object: (id) object {
    [self forwardSelector: selector delegate: delegate object: object object: nil object: nil];
}

- (void) forwardSelector: (SEL) selector delegate: (id) delegate object: (id) object object: (id) object2 {
    [self forwardSelector: selector delegate: delegate object: object object: object2 object: nil];
}

- (void) forwardSelector: (SEL) selector delegate: (id) delegate object: (id) object object: (id) object2 object: (id) object3 {
    if (delegate && [delegate respondsToSelector: selector]) {
        id theDelegate = delegate;
        IMP imp = [theDelegate methodForSelector: selector];
        void (*func)(id, SEL, id, id, id) = (void *) imp;
        func(theDelegate, selector, object, object2, object3);
    }
}


#pragma mark Multiple


- (void) forwardSelector: (SEL) selector delegates: (NSArray *) delegates object: (id) object {
    [self forwardSelector: selector delegates: delegates object: object object: nil object: nil];
}


- (void) forwardSelector: (SEL) selector delegates: (NSArray *) delegates object: (id) object object: (id) object2 {
    [self forwardSelector: selector delegates: delegates object: object object: object2 object: nil];
}


- (void) forwardSelector: (SEL) selector delegates: (NSArray *) delegates object: (id) object object: (id) object2 object: (id) object3 {
    for (id delegate in delegates) {
        [self forwardSelector: selector delegate: delegate object: object object: object2 object: object3];
    }
}


@end