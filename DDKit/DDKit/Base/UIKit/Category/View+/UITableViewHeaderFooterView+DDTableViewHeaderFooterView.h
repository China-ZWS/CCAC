//
//  UITableViewHeaderFooterView+DDTableViewHeaderFooterView.h
//  DDKit
//
//  Created by Song on 16/12/13.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewHeaderFooterView (DDTableViewHeaderFooterView)

@property (nonatomic, strong) id dd_contentModel;   ///< HeaderFooterView 数据通用模型

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

@interface UITableViewHeaderFooterView (DDTableViewHeaderFooterViewEvent)

/// cell 点击调用该方法，将会回调给 tableView 的 delegate 里面，执行：tableView:clickCell:atView: 方法
- (void)dd_headerFooterClickAtView:(UIView *)view;

/// 获取 cell 所在 tableView
- (UITableView *)dd_tableView;

@end


@interface NSObject(DDTableViewHeaderFooterViewEvent)

/// cell 点击如果调用了 dd_cellClickAtView: 方法，tableView 的delegate 里面，会调用该方法
- (void)tableView:(UITableView *)tableView clickHeaderFooter:(UITableViewCell *)clickHeaderFooter indexPath:(NSIndexPath *)indexPath atView:(UIView *)view;

@end
