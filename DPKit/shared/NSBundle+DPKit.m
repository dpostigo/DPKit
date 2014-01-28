//
// Created by Dani Postigo on 1/26/14.
//

#import "NSBundle+DPKit.h"

@implementation NSBundle (DPKit)

+ (NSString *) bundleDisplayName {
    NSString *ret = [[[NSBundle mainBundle] infoDictionary] objectForKey: @"CFBundleDisplayName"];
    if (ret == nil) {
        ret = [[[NSBundle mainBundle] infoDictionary] objectForKey: @"CFBundleName"];
    }
    return ret;
}


@end