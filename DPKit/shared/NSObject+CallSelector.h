//
// Created by Dani Postigo on 1/16/14.
//

#import <Foundation/Foundation.h>

@interface NSObject (CallSelector)

- (void) forwardSelector: (SEL) selector delegate: (id) delegate object: (id) object;
- (void) forwardSelector: (SEL) selector delegate: (id) delegate object: (id) object object: (id) object2;
- (void) forwardSelector: (SEL) selector delegate: (id) delegate object: (id) object object: (id) object2 object: (id) object3;

@end