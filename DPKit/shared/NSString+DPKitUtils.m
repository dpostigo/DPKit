//
// Created by Dani Postigo on 1/24/14.
//

#import "NSString+DPKitUtils.h"

@implementation NSString (DPKitUtils)

- (NSURL *) URL {
    return [NSURL URLWithString: self];
}

- (BOOL) containsString: (NSString *) substring {
    NSRange range = [self rangeOfString: substring];
    BOOL found = (range.location != NSNotFound);
    return found;
}


- (NSString *) filenameEscapedString {
    NSCharacterSet *illegalFileNameCharacters = [NSCharacterSet characterSetWithCharactersInString: @"/\\?%*|\"<>"];
    return [[self componentsSeparatedByCharactersInSet: illegalFileNameCharacters] componentsJoinedByString: @""];
}

@end