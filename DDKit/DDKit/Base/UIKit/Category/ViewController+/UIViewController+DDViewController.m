//
//  UIViewController+DDViewController.m
//  DDKit
//
//  Created by Song on 16/8/27.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import "UIViewController+DDViewController.h"

#import "UINavigationItem+DDNavigationItem.h"

@implementation UIViewController (DDViewController)

- (BOOL)dd_goBackByGestureSupported
{
    return YES;
}

- (BOOL)dd_needLogin
{
    return NO;
}

- (BOOL)dd_isVisible
{
    return [self isViewLoaded] && self.view.window;
}

- (void)dd_goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark - barButton

- (UIButton *)dd_addBackButton
{
    return [self.navigationItem dd_addBarButtonWithType:DDNavigationBarItemType_Left
                                                                      target:self
                                                                      action:@selector(dd_goBack)
                                                                 normalImage:self.navigationController.navigationItem.dd_backNormalIcon
                                                            highlightedImage:self.navigationController.navigationItem.dd_backHighlightIcon
                                                                  needsClear:YES];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
