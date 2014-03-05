//
// Created by Dani Postigo on 3/3/14.
//

#import <Foundation/Foundation.h>

@interface DPNavigationController : NSViewController {

    NSViewController *rootViewController;

}

@property(nonatomic, strong) NSViewController *rootViewController;
- (instancetype) initWithRootViewController: (NSViewController *) aRootViewController;

@end