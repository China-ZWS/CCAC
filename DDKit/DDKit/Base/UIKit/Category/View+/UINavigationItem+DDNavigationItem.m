//
//  UINavigationItem+DDNavigationItem.m
//  DDKit
//
//  Created by Song on 16/8/27.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import "UINavigationItem+DDNavigationItem.h"

#import "NSDictionary+DDTextAttributes.h"

static NSDictionary *dd_UIViewController_GeneralNavigationBarItemTextAttributesForNormal;
static NSDictionary *dd_UIViewController_GeneralNavigationBarItemTextAttributesForHighlight;
static UIImage *dd_UIViewController_BackNormalIcon;
static UIImage *dd_UIViewController_BackHighlightIcon;
static NSString *dd_Login_Controller_Name;

@implementation UINavigationItem (DDNavigationItem)

#pragma mark -
#pragma mark - Property

- (NSDictionary *)dd_navigationBarItemTextAttributes_normal
{
    return dd_UIViewController_GeneralNavigationBarItemTextAttributesForNormal;
}

- (NSDictionary *)dd_navigationBarItemTextAttributes_highlight
{
    return dd_UIViewController_GeneralNavigationBarItemTextAttributesForHighlight;
}

- (UIImage *)dd_backNormalIcon
{
    return dd_UIViewController_BackNormalIcon;
}

- (UIImage *)dd_backHighlightIcon
{
    return dd_UIViewController_BackHighlightIcon;
}

#pragma mark -
#pragma mark - Public

+ (void)dd_setNavigationBarItemTextAttributesForNormal:(NSDictionary *)navigationBarItemTextAttributes
{
    dd_UIViewController_GeneralNavigationBarItemTextAttributesForNormal = navigationBarItemTextAttributes;
}


+ (void)dd_setGeneralBackNormalIcon:(UIImage *)backNormalIcon
{
    dd_UIViewController_BackNormalIcon = backNormalIcon;
}

+ (void)dd_setGeneralBackHighlightIcon:(UIImage *)backHighlightIcon
{
    dd_UIViewController_BackHighlightIcon = backHighlightIcon;
}


- (void)dd_clearBarButtonItemWithType:(DDNavigationBarItemType)type
{
    if (type == DDNavigationBarItemType_Left) {
        self.leftBarButtonItems = @[];
    } else {
        self.rightBarButtonItems = @[];
    }
}

- (UIButton *)dd_addBarButtonWithType:(DDNavigationBarItemType)type
                               target:(id)target
                               action:(SEL)action
                                title:(NSString *)title
                           needsClear:(BOOL)needsClear
{
    UIFont *titleFont = self.dd_navigationBarItemTextAttributes_normal.dd_fontAttribute;
    UIColor *normalTitleColor = self.dd_navigationBarItemTextAttributes_normal.dd_colorAttribute;
    UIColor *highlightTitleColor = self.dd_navigationBarItemTextAttributes_highlight.dd_colorAttribute;

    CGSize size = [title boundingRectWithSize:CGSizeMake(120, 44)
                                      options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                   attributes:[NSDictionary dd_textAttributesWithFont:titleFont color:nil shadow:nil]
                                      context:nil].size;

    UIButton *button= [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, size.width, 44);
    button.titleLabel.font = titleFont;
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:normalTitleColor forState:UIControlStateNormal];
    [button setTitleColor:highlightTitleColor forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];

    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self dd_addBarButtonItem:barButtonItem type:type needsClear:needsClear];

    return button;
}

- (UIButton *)dd_addBarButtonWithType:(DDNavigationBarItemType)type
                               target:(id)target
                               action:(SEL)action
                          normalImage:(UIImage *)normalImage
                     highlightedImage:(UIImage *)highlightedImage
                           needsClear:(BOOL)needsClear
{
    UIButton *button= [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, normalImage.size.width, 44);
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setImage:normalImage forState:UIControlStateNormal];
    [button setImage:highlightedImage forState:UIControlStateHighlighted];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self dd_addBarButtonItem:barButtonItem type:type needsClear:needsClear];

    return button;
}

- (void)dd_addBarButtonItem:(UIBarButtonItem *)barButtonItem type:(DDNavigationBarItemType)type needsClear:(BOOL)needsClear
{
    if (needsClear) {
        [self dd_clearBarButtonItemWithType:type];
    }

    if (type == DDNavigationBarItemType_Left) {

        NSMutableArray *leftBarButtonItems = [NSMutableArray arrayWithArray:self.leftBarButtonItems];

        if (leftBarButtonItems.count == 0) {
            UIBarButtonItem *negativeSpacer = [[ UIBarButtonItem alloc ] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                              target:nil
                                                                                             action :nil];
            negativeSpacer.width = - 8 ;
            [leftBarButtonItems addObject:negativeSpacer];
        }

        [leftBarButtonItems addObject:barButtonItem];

        self.leftBarButtonItems = leftBarButtonItems;

    } else if (type == DDNavigationBarItemType_Right) {

        NSMutableArray *rightBarButtonItems = [NSMutableArray arrayWithArray:self.rightBarButtonItems];
        if (rightBarButtonItems.count == 0) {
            UIBarButtonItem *negativeSpacer = [[ UIBarButtonItem alloc ] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                              target:nil
                                                                                              action:nil];
            negativeSpacer.width = - 8;
            [rightBarButtonItems addObject:negativeSpacer];
        }

        [rightBarButtonItems addObject:barButtonItem];
        
        self.rightBarButtonItems = rightBarButtonItems;
    }
}

#pragma mark Override Methods

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        dd_UIViewController_GeneralNavigationBarItemTextAttributesForNormal = [NSDictionary dd_textAttributesWithFont:[UIFont systemFontOfSize:16]
                                                                                                                color:[UIColor blackColor]
                                                                                                               shadow:nil];
        dd_UIViewController_GeneralNavigationBarItemTextAttributesForHighlight = [NSDictionary dd_textAttributesWithFont:[UIFont systemFontOfSize:16]
                                                                                                                   color:[UIColor grayColor]
                                                                                                                  shadow:nil];
    });
}

@end
