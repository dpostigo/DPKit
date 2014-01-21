//
// Created by Dani Postigo on 1/16/14.
//

#import "NSObject+CallSelector.h"

@implementation NSObject (CallSelector)

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


@end