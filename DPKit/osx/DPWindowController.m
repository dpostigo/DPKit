//
// Created by Dani Postigo on 2/3/14.
//

#import "DPWindowController.h"

@implementation DPWindowController

- (id) init {
    NSString *windowNibName = [NSStringFromClass([self class]) stringByReplacingOccurrencesOfString: @"Controller" withString: @""];
    return [self initWithWindowNibName: windowNibName];
}

@end