//
//  UINavigationBar+DDNavigationBar.m
//  DDKit
//
//  Created by Song on 16/8/27.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import "UINavigationBar+DDNavigationBar.h"

#import "NSDictionary+DDTextAttributes.h"

static NSDictionary *dd_UIViewController_GeneralNavigationBarTitleTextAttributes;
static UIColor *dd_UIViewController_GeneralNavigationBarTintColor;

@implementation UINavigationBar (DDNavigationBar)

#pragma mark -
#pragma mark - Property

- (NSDictionary *)dd_navigationBarTitleTextAttributes
{
    
    return dd_UIViewController_GeneralNavigationBarTitleTextAttributes;
}

- (UIColor *)dd_navigationBarTintColor
{
    return dd_UIViewController_GeneralNavigationBarTintColor;
}

+ (void)dd_setNavigationBarTintColor:(UIColor *)navigationBarTintColor
{
    dd_UIViewController_GeneralNavigationBarTintColor = navigationBarTintColor;
}

+ (void)dd_setNavigationBarTitleTextAttributes:(NSDictionary *)navigationBarTitleTextAttributes
{
    dd_UIViewController_GeneralNavigationBarTitleTextAttributes = navigationBarTitleTextAttributes;
}

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dd_UIViewController_GeneralNavigationBarTitleTextAttributes = [NSDictionary dd_textAttributesWithFont:[UIFont boldSystemFontOfSize:18] color:[UIColor blackColor]shadow:nil];
    });
}

@end
