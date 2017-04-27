//
//  UINavigationItem+DDNavigationItem.h
//  DDKit
//
//  Created by Song on 16/8/27.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  导航栏Item类型
 */
typedef NS_ENUM(NSUInteger, DDNavigationBarItemType) {
    /**
     *  左
     */
    DDNavigationBarItemType_Left = 0,
    /**
     *  标题
     */
    DDNavigationBarItemType_Title,
    /**
     *  右
     */
    DDNavigationBarItemType_Right
};

@interface UINavigationItem (DDNavigationItem)


/**
 *  返回按钮Icon图片 Normal
 */
@property (nonatomic, readonly) UIImage *dd_backNormalIcon;

/**
 *  返回按钮Icon图片 Highlight
 */
@property (nonatomic, readonly) UIImage *dd_backHighlightIcon;


/**
 *  导航栏Item文字属性（Normal）
 *  NSFontAttributeName             with an UIFont instance as the value, default Helvetica(Neue) 12
 *  NSForegroundColorAttributeName  with an UIColor instance as the value, default blackColor
 *  NSShadowAttributeName           with an NSShadow instance as the value
 */
@property (nonatomic, readonly) NSDictionary *dd_navigationBarItemTextAttributes_normal;

/**
 *  导航栏Item文字属性（Highlight）
 *  NSFontAttributeName             with an UIFont instance as the value, default Helvetica(Neue) 12
 *  NSForegroundColorAttributeName  with an UIColor instance as the value, default blackColor
 *  NSShadowAttributeName           with an NSShadow instance as the value
 */
@property (nonatomic, readonly) NSDictionary *dd_navigationBarItemTextAttributes_highlight;


/**
 *  设置通用导航栏Item文字属性（Normal）
 *  @param navigationBarItemTextAttributes 导航栏Item文字属性（Normal）
 */
+ (void)dd_setNavigationBarItemTextAttributesForNormal:(NSDictionary *)navigationBarItemTextAttributes;

/**
 *  设置通用返回按钮Icon图片 Normal
 *
 *  @param backNormalIcon 返回按钮Icon图片 Normal
 */
+ (void)dd_setGeneralBackNormalIcon:(UIImage *)backNormalIcon;

/**
 *  设置通用返回按钮Icon图片 Highlight
 *
 *  @param backHighlightIcon 返回按钮Icon图片 Highlight
 */
+ (void)dd_setGeneralBackHighlightIcon:(UIImage *)backHighlightIcon;

#pragma mark -
#pragma mark - barButton

/**
 *  @brief  清除已存在的Item按钮
 *
 *  @param type 类型
 */
- (void)dd_clearBarButtonItemWithType:(DDNavigationBarItemType)type;

- (UIButton *)dd_addBarButtonWithType:(DDNavigationBarItemType)type
                               target:(id)target
                               action:(SEL)action
                                title:(NSString *)title
                           needsClear:(BOOL)needsClear;


/**
 *  @brief  添加导航栏按钮
 *
 *  @param type             按钮类型
 *  @param target           事件目标
 *  @param action           事件
 *  @param normalImage      正常状态Icon图片
 *  @param highlightedImage 高亮状态Icon图片
 *  @param needsClear       是否需要清除已存在的BarButton
 *
 *  @return 返回按钮
 */
- (UIButton *)dd_addBarButtonWithType:(DDNavigationBarItemType)type target:(id)target action:(SEL)action normalImage:(UIImage *)normalImage highlightedImage:(UIImage *)highlightedImage needsClear:(BOOL)needsClear;

@end
