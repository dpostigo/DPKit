//
// Created by Dani Postigo on 2/3/14.
//

#import "DPViewController.h"

@implementation DPViewController

- (id) init {
    NSString *nibName = NSStringFromClass([self class]);
    return [self initWithNibName: nibName bundle: nil];
}


- (id) initWithNibName: (NSString *) nibNameOrNil bundle: (NSBundle *) nibBundleOrNil {
    self = [super initWithNibName: nibNameOrNil bundle: nibBundleOrNil];
    if (self) {
        [self setup];

    }

    return self;
}

- (void) setup {

}
@end