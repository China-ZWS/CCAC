//
//  UIViewController+DDIntercepter.h
//  DDKit
//
//  Created by Song on 16/8/26.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (DDIntercepter)

/// 隐藏导航条
- (BOOL)dd_isNaviBarHidden;

// 隐藏返回按钮
- (BOOL)dd_isNaviBackItemHidden;

/// 视图将要第一次显示
- (void)dd_viewWillAppearForTheFirstTime;

/// 视图第一次显示
- (void)dd_viewDidAppearForTheFirstTime;

/// 设置全局 viewController 的背景颜色，viewControoler 在 viewDidLoad 后设置
+ (UIColor *)dd_viewControllerBackgroundColor;

/// 设置背景颜色，默认是白色
+ (void)setDD_viewControllerBackgroundColor:(UIColor *)color;

+ (void)zhou;
@end
