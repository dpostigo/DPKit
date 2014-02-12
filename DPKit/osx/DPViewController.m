//
// Created by Dani Postigo on 2/3/14.
//

#import "DPViewController.h"

@implementation DPViewController

- (id) init {
    NSString *nibName = NSStringFromClass([self class]);
    return [self initWithNibName: nibName bundle: nil];
}

//- (id) init {
//    NSString *nibName = NSStringFromClass([self class]);
//    NSString *nibPath = [[NSBundle mainBundle] pathForResource: nibName ofType: @"nib"];
//    if (nibPath != nil) {
//        return [self initWithNibName: nibName bundle: nil];
//    } else {
//        self = [super init];
//        if (self) {
//
//        }
//        return self;
//    }
//}


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