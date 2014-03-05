//
// Created by Dani Postigo on 3/3/14.
//

#import "DPNavigationController.h"

@implementation DPNavigationController

@synthesize rootViewController;

- (instancetype) initWithRootViewController: (NSViewController *) aRootViewController {
    self = [super init];
    if (self) {
        rootViewController = aRootViewController;
        NSLog(@"self.view = %@", self.view);

        rootViewController.view.frame = self.view.bounds;
        [self.view addSubview: rootViewController.view];

    }

    return self;
}

- (void) pushViewController: (NSViewController *) viewController animated: (BOOL) flag {

}
@end