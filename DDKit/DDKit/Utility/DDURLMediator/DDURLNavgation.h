//
//  DDURLNavgation.h
//  DDKit
//
//  Created by Song on 16/8/26.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DDSingletonDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDURLNavgation : NSObject

DEFINE_SINGLETON_FOR_H(DDURLNavgation)

/**
 *  返回当前控制器
 */
- (UIViewController*)currentViewController;

/**
 *  返回当前的导航控制器
 */
- (UINavigationController*)currentNavigationViewController;



+ (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated replace:(BOOL)replace;
+ (void)presentViewController:(UIViewController *)viewController animated: (BOOL)flag completion:(void (^ __nullable)(void))completion;

+ (void)popTwiceViewControllerAnimated:(BOOL)animated;
+ (void)popViewControllerWithTimes:(NSUInteger)times animated:(BOOL)animated;
+ (void)popToRootViewControllerAnimated:(BOOL)animated;


+ (void)dismissTwiceViewControllerAnimated: (BOOL)flag completion: (void (^ __nullable)(void))completion;
+ (void)dismissViewControllerWithTimes:(NSUInteger)times animated: (BOOL)flag completion: (void (^ __nullable)(void))completion;
+ (void)dismissToRootViewControllerAnimated: (BOOL)flag completion: (void (^ __nullable)(void))completion;

@end

NS_ASSUME_NONNULL_END
