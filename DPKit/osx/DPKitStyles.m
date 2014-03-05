//
// Created by Dani Postigo on 3/3/14.
//

#import <NSColor-Crayola/NSColor+Crayola.h>
#import "DPKitStyles.h"
#import "NSColor+BlendingUtils.h"

@implementation DPKitStyles


+ (NSColor *) onyxHighlightColor {
    return [[NSColor whiteColor] mix: [NSColor crayolaOnyxColor] fraction: 0.8];
}

@end