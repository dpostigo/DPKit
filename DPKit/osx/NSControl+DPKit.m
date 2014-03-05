//
// Created by Dani Postigo on 3/3/14.
//

#import "NSControl+DPKit.h"

@implementation NSControl (DPKit)

- (id) contentObservedObject {
    return [self.contentBindingInfo objectForKey: @"NSObservedObject"];
}

- (id) contentValuesObservedObject {
    return [self.contentValuesBindingInfo objectForKey: @"NSObservedObject"];
}

- (NSDictionary *) contentBindingInfo {
    NSDictionary *contentBindingInfo = [self infoForBinding: @"content"];
    return contentBindingInfo;
}

- (NSDictionary *) contentValuesBindingInfo {
    NSDictionary *contentBindingInfo = [self infoForBinding: @"contentValues"];
    return contentBindingInfo;
}


@end