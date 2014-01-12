//
// Created by Dani Postigo on 1/8/14.
//

#import "NSNib+WorkspaceNib.h"

@implementation NSNib (WorkspaceNib)

- (NSArray *) controllersForNib {

    NSMutableArray *ret = [[NSMutableArray alloc] init];

    NSArray *objects = nil;
    [self instantiateNibWithOwner: self topLevelObjects: &objects];

    for (id object in objects) {
        if ([object isKindOfClass: [NSViewController class]]) {
            [ret addObject: object];
        }
    }
    return ret;
}


- (id) nibControllerForClass: (id) object {
    id ret = nil;
    if ([object isKindOfClass: [NSString class]]) {
        ret = [self nibControllerForClassString: object];
    } else {
        ret = [self nibControllerForClassReference: object];
    }
    return ret;

}


- (id) nibControllerForClassReference: (Class) class {
    NSViewController *ret = nil;
    NSArray *controllers = self.controllersForNib;

    for (NSViewController *controller in controllers) {
        if ([controller isKindOfClass: class]) {
            ret = controller;
            break;
        }
    }
    return ret;
}


- (id) nibControllerForClassString: (NSString *) classString {
    id ret = nil;
    Class class = NSClassFromString(classString);
    if (class) {
        ret = [self nibControllerForClassReference: class];

    }
    return ret;
}


- (id) nibViewForClass: (id) object {
    id ret = nil;
    if ([object isKindOfClass: [NSString class]]) {
        ret = [self nibViewForClassString: object];
    } else {
        ret = [self nibViewForClassReference: object];
    }
    return ret;

}


- (NSView *) nibViewForClassString: (NSString *) classString {
    NSView *ret = nil;
    Class class = NSClassFromString(classString);
    if (class) {
        ret = [self nibViewForClassReference: class];
    }
    return ret;

}

- (NSView *) nibViewForClassReference: (Class) class {
    NSView *ret = nil;
    NSViewController *controller = [self nibControllerForClassReference: class];
    if (controller) {
        ret = controller.view;
    }
    return ret;
}


@end