//
// Created by Dani Postigo on 3/3/14.
//

#import <Foundation/Foundation.h>

@interface NSControl (DPKit)

- (id) contentObservedObject;
- (id) contentValuesObservedObject;
- (NSDictionary *) contentBindingInfo;
- (NSDictionary *) contentValuesBindingInfo;
@end