//
//  DDNavigationController.m
//  DDKit
//
//  Created by Song on 16/8/31.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import "DDNavigationController.h"
#import "UIViewController+DDViewController.h"


@interface DDNavigationController()<UIGestureRecognizerDelegate>

@end

@implementation DDNavigationController

#pragma mark -
#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.interactivePopGestureRecognizer.delegate = self;
    self.delegate = (id<UINavigationControllerDelegate>)self;
}

#pragma mark -
#pragma mark - Override Method

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return [self.topViewController preferredStatusBarStyle];;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    [super pushViewController:viewController animated:animated];
}



#pragma mark -
#pragma mark - UINavigationController Delegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        if (navigationController.viewControllers.count == 1) {
            self.interactivePopGestureRecognizer.enabled = NO;
        } else {
            self.interactivePopGestureRecognizer.enabled = viewController.dd_goBackByGestureSupported;
        }
    }
}

@end
