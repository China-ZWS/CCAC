//
//  UIViewController+DDIntercepter.m
//  DDKit
//
//  Created by Song on 16/8/26.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import "UIViewController+DDIntercepter.h"

static UIColor *dd_UIViewController_Background_Color;

@implementation UIViewController (DDIntercepter)

#pragma mark -
#pragma mark - Method

- (BOOL)dd_isNaviBarHidden
{
    return NO;
}

- (BOOL)dd_isNaviBackItemHidden;
{
    return NO;
}

- (void)dd_viewWillAppearForTheFirstTime
{

}

- (void)dd_viewDidAppearForTheFirstTime
{

}

#pragma mark - Color

+ (void)setDD_viewControllerBackgroundColor:(UIColor *)color
{
    dd_UIViewController_Background_Color = color;
}

+ (UIColor *)dd_viewControllerBackgroundColor
{
    UIColor *color = dd_UIViewController_Background_Color;

    if (!color) {
        color = [UIColor whiteColor];
    }
    return color;
}

@end
