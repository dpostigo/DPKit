//
// Created by Dani Postigo on 1/9/14.
//

#import <QuartzCore/QuartzCore.h>
#import "NSWorkspaceNib.h"
#import "NSNib+WorkspaceNib.h"
#import "NSArray+DPKit.h"

@implementation NSWorkspaceNib

@synthesize controllers;

@synthesize objects;

- (void) load {
    objects = [[NSMutableArray alloc] init];
    NSArray *array = nil;
    [self instantiateNibWithOwner: self topLevelObjects: &array];
    [objects addObjectsFromArray: array];

    for (NSViewController *controller in self.controllers) {
        if ([controller respondsToSelector: @selector(viewDidLoad)]) {
            [controller performSelector: @selector(viewDidLoad) withObject: nil];
        }
    }

}

- (id) objectForClass: (Class) class {
    id ret = nil;
    for (id object in self.objects) {
        if ([object isKindOfClass: class]) {
            ret = object;
            break;
        }
    }
    return ret;
}

- (id) objectWithIdentifier: (NSString *) identifier {
    id ret = nil;
    for (id object in self.objects) {
        if ([object conformsToProtocol: @protocol(NSUserInterfaceItemIdentification)]) {
            id <NSUserInterfaceItemIdentification> interfaceObject = object;
            if (interfaceObject.identifier && [interfaceObject.identifier isEqualToString: identifier]) {
                ret = object;
                break;
            }
        }
    }

    return ret;

}

- (id) controllerForClass: (id) object {
    id ret = nil;
    if ([object isKindOfClass: [NSString class]]) {
        ret = [self nibControllerForClassString: object];
    } else {
        ret = [self nibControllerForClassReference: object];
    }
    return ret;

}


- (id) controllerForClassReference: (Class) class {
    NSViewController *ret = nil;
    NSArray *viewControllers = self.controllers;

    for (NSViewController *controller in viewControllers) {
        if ([controller isKindOfClass: class]) {
            ret = controller;
            break;
        }
    }
    return ret;
}


- (id) controllerForClassString: (NSString *) classString {
    id ret = nil;
    Class class = NSClassFromString(classString);
    if (class) {
        ret = [self controllerForClassReference: class];

    }
    return ret;
}


- (id) viewForClass: (id) object {
    id ret = nil;
    if ([object isKindOfClass: [NSString class]]) {
        ret = [self viewForClassString: object];
    } else {
        ret = [self viewForClassReference: object];
    }
    return ret;

}


- (NSView *) viewForClassString: (NSString *) classString {
    NSView *ret = nil;
    Class class = NSClassFromString(classString);
    if (class) {
        ret = [self viewForClassReference: class];
    }
    return ret;

}

- (NSView *) viewForClassReference: (Class) class {
    NSView *ret = nil;
    NSViewController *controller = [self controllerForClassReference: class];
    if (controller) {
        ret = controller.view;
    } else {

    }
    return ret;
}


- (NSArray *) controllers {
    if (controllers == nil) {
        controllers = [self controllersForObjects: self.objects];
    }
    return controllers;
}

- (NSArray *) controllerNames {
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    for (NSViewController *controller in self.controllers) {
        [ret addObject: [[controller class] name]];
    }
    return ret;
}


- (NSArray *) controllersForObjects: (NSArray *) objectArray {
    return [objectArray objectsOfType: [NSViewController class]];
}


- (NSMutableArray *) objects {
    if (objects == nil) {
        objects = [[NSMutableArray alloc] init];
        NSArray *array = nil;
        [self instantiateNibWithOwner: self topLevelObjects: &array];
        [objects addObjectsFromArray: array];

    }
    return objects;
}

//
//- (NSArray *) controllersForNib {
//
//    NSMutableArray *ret = [[NSMutableArray alloc] init];
//
//    NSArray *objects = nil;
//    [self instantiateNibWithOwner: self topLevelObjects: &objects];
//
//    for (id object in objects) {
//        if ([object isKindOfClass: [NSViewController class]]) {
//            [ret addObject: object];
//        }
//    }
//    return ret;
//}


@end