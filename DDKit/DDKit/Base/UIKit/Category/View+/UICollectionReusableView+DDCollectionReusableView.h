//
//  UICollectionReusableView+DDCollectionReusableView.h
//  DDKit
//
//  Created by Song on 16/9/1.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionReusableView (DDCollectionReusableView)

@property (nonatomic, strong) id dd_contentModel;   ///< ReusableView 数据通用模型

/**
 *  @brief  指定ItemModel布局显示内容 重载后必须调用Super
 *
 *  @param itemModel 显示ItemModel
 */
- (void)dd_configWithItemModel:(id)itemModel;

/**
 *  @brief  重用Identifier
 *
 *  @return Identifier
 */
+ (NSString *)dd_reusableIdentifier;

@end

@interface UICollectionReusableView (DDReusableViewEvent)

/// reusableView 点击调用该方法，将会回调给 tableView 的 delegate 里面，执行：tableView:clickCell:atView: 方法
- (void)dd_reusableViewClickAtView:(UIView *)view;

/// 获取 reusableView 所在 tableView
- (UICollectionView *)dd_collectionView;

@end
