//
// Created by Dani Postigo on 2/13/14.
//

#import "DPDoubleTransformer.h"

@implementation DPDoubleTransformer

+ (Class) transformedValueClass {
    return [NSString class];
}

+ (BOOL) allowsReverseTransformation {
    return YES;
}

- (id) transformedValue: (id) value {
    NSLog(@"value = %@", value);

    return [super transformedValue: value];
}

@end