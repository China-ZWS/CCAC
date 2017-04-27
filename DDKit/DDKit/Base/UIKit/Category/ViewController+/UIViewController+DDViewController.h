//
//  UIViewController+DDViewController.h
//  DDKit
//
//  Created by Song on 16/8/27.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (DDViewController)


/**
 *  是否支持手势返回 默认返回YES
 */
- (BOOL)dd_goBackByGestureSupported;

/**
 *  是否需要登录才能进入到当前页面 默认返回 NO
 */
- (BOOL)dd_needLogin;

/**
 *  是否可见
 */
- (BOOL)dd_isVisible;

/**
 *  返回
 */
- (void)dd_goBack;


/**
 *  添加返回按钮
 *
 *  @return 返回按钮
 */
- (UIButton *)dd_addBackButton;

@end
