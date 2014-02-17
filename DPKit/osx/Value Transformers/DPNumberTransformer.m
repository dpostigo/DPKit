//
// Created by Dani Postigo on 2/13/14.
//

#import "DPNumberTransformer.h"

@implementation DPNumberTransformer

+ (Class) transformedValueClass {
    return [NSString class];
}

+ (BOOL) allowsReverseTransformation {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return YES;
}


- (id) reverseTransformedValue: (id) value {

    id ret = nil;

    NSLog(@"%s, value = %@, value class = %@", __PRETTY_FUNCTION__, value, [value class]);

    return ret;
}

- (id) transformedValue: (id) value {
    //    return (value == nil) ? nil : NSStringFromClass([value class]);
    NSNumber *ret = nil;

    NSLog(@"%s, value = %@, value class = %@", __PRETTY_FUNCTION__, value, [value class]);
    if ([value isKindOfClass: [NSNumber class]]) {
        NSNumber *number = value;

        return [NSString stringWithFormat: @"%@", number];
        //        ret = [NSString stringWithFormat: @"%f", [number doubleValue]];

    }
    return nil;

}

- (NSString *) stringForValue: (id) value {
    return nil;
}

@end