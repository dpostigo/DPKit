//
// Created by Dani Postigo on 2/10/14.
//

#import "NSView+DPKit.h"

@implementation NSView (DPKit)

- (void) recursiveWantsLayer {

    NSView *superview = self.superview;
    while (superview) {
        superview.wantsLayer = YES;
        superview.layer.masksToBounds = NO;
        superview = superview.superview;
    }
}


- (instancetype) loadFromNib {
    return [self loadFromNib: [self className]];
}

- (instancetype) loadFromNib: (NSString *) nibName {
    id ret = nil;
    NSNib *nib = [[NSNib alloc] initWithNibNamed: nibName bundle: nil];
    NSArray *topLevelObjects;

    BOOL success = [nib instantiateWithOwner: nil topLevelObjects: &topLevelObjects];

    if (success) {
        for (id topLevelObject in topLevelObjects) {
            if ([topLevelObject isKindOfClass: [self class]]) {
                ret = topLevelObject;
                break;
            }
        }
    }

    return ret;
}

- (NSView *) viewWithIdentifier: (NSString *) identifier {
    NSArray *subviews = [NSArray arrayWithArray: self.subviews];

    for (NSView *view in subviews) {
        if ([view.identifier isEqualToString: identifier]) {
            return view;
        }
    }

    return nil;
}

@end