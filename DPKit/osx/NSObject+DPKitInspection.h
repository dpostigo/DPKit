//
// Created by Dani Postigo on 3/5/14.
//

#import <Foundation/Foundation.h>

@interface NSObject (DPKitInspection)

- (IMP) impForSelector: (SEL) selector;
@end