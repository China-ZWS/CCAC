//
//  DDStretchableTableHeaderView.h
//  DDKit
//
//  Created by Song on 16/8/30.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

/*
 *使用时要实现以下两个代理方法
 *- (void)scrollViewDidScroll:(UIScrollView *)scrollView
 *- (void)viewDidLayoutSubviews
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DDStretchableTableHeaderView : NSObject

@property (nonatomic,retain) UITableView* tableView;
@property (nonatomic,retain) UIView* view;


/**
 * subview:内容部分
 * view   :拉伸的背景图片
 */
- (void)stretchHeaderForTableView:(UITableView*)tableView
                         withView:(UIView*)view
                         subViews:(UIView*)subview;

- (void)scrollViewDidScroll:(UIScrollView*)scrollView;

- (void)resizeView;

@end
