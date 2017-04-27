//
//  DDStretchableTableHeaderView.m
//  DDKit
//
//  Created by Song on 16/8/30.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import "DDStretchableTableHeaderView.h"

@interface DDStretchableTableHeaderView (){
    CGRect _initialFrame;
    CGFloat _defaultViewHeight;
}

@end


@implementation DDStretchableTableHeaderView


- (void)stretchHeaderForTableView:(UITableView*)tableView withView:(UIView*)view subViews:(UIView*)subview
{
    _tableView = tableView;
    _view      = view;

    _initialFrame       = _view.frame;
    _defaultViewHeight  = _initialFrame.size.height;

    UIView *emptyTableHeaderView = [[UIView alloc] initWithFrame:_initialFrame];

    _tableView.tableHeaderView = emptyTableHeaderView;

    [_tableView addSubview:_view];
    [_tableView addSubview:subview];

}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    CGRect f     = _view.frame;
    f.size.width = _tableView.frame.size.width;
    _view.frame  = f;

    if(scrollView.contentOffset.y < 0)
    {
        CGFloat offsetY = (scrollView.contentOffset.y + scrollView.contentInset.top) * -1;

        _initialFrame.origin.y = - offsetY * 1;
        _initialFrame.size.height = _defaultViewHeight + offsetY;

        _view.frame = _initialFrame;

    }
}

- (void)resizeView
{
    _initialFrame.size.width = _tableView.frame.size.width;
    _view.frame = _initialFrame;
}

@end
