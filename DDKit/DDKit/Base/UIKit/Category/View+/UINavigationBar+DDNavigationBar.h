//
//  UINavigationBar+DDNavigationBar.h
//  DDKit
//
//  Created by Song on 16/8/27.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (DDNavigationBar)

/**
 *  导航栏标题文字属性
 *  NSFontAttributeName             with an UIFont instance as the value, default Helvetica(Neue) 12
 *  NSForegroundColorAttributeName  with an UIColor instance as the value, default blackColor
 *  NSShadowAttributeName           with an NSShadow instance as the value
 */
@property (nonatomic, readonly) NSDictionary *dd_navigationBarTitleTextAttributes;

/**
 *  获取 navigationBarTintColor 颜色
 */
@property (nonatomic, readonly) UIColor *dd_navigationBarTintColor;

/**
 *  设置通用导航栏标题文字属性
 *  @param navigationBarTitleTextAttributes 导航栏标题文字属性
 */
+ (void)dd_setNavigationBarTitleTextAttributes:(NSDictionary *)navigationBarTitleTextAttributes;

/**
 *  设置通用导航栏颜色
 *  @param navigationBarTintColor 导航栏颜色
 */
+ (void)dd_setNavigationBarTintColor:(UIColor *)navigationBarTintColor;


@end
