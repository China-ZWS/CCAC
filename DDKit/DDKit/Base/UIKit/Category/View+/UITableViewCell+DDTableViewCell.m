//
//  UITableViewCell+DDTableViewCell.m
//  DDKit
//
//  Created by Song on 16/8/27.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import "UITableViewCell+DDTableViewCell.h"

#import <objc/runtime.h>

CGFloat const kDDTabelViewCellDefaultHeight = 44.0f;
const NSString *kDDTableViewCellItemModelKey = @"kDDTableViewCellItemModelKey";

@implementation UITableViewCell (DDTableViewCell)

- (void)setDd_contentModel:(id)dd_contentModel
{
    objc_setAssociatedObject(self, &kDDTableViewCellItemModelKey, dd_contentModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)dd_contentModel
{
    return objc_getAssociatedObject(self, &kDDTableViewCellItemModelKey);
}

+ (CGFloat)dd_heightForCellWithItem:(id)item contentWidth:(CGFloat)contentWith
{
    return kDDTabelViewCellDefaultHeight;
}

- (void)dd_configWithItemModel:(id)itemModel
{
    self.dd_contentModel = itemModel;
}

+ (NSString *)dd_reusableIdentifier
{
    return NSStringFromClass([self class]);
}

@end

@implementation UITableViewCell(DDCellEvent)

- (void)dd_cellClickAtView:(UIView *)view
{
    UITableView *tableView = self.dd_tableView;
    if (tableView) {
        UIResponder *responder = tableView.delegate;
        if (responder) {
            NSIndexPath *indexPath = [tableView indexPathForCell:self];
            [responder tableView:tableView clickCell:self indexPath:indexPath atView:view];
        }
    }
}

- (UITableView *)dd_tableView
{
    UIResponder *responder = self.nextResponder;
    do {
        if ([responder isKindOfClass:[UITableView class]]) {
            return (UITableView *)responder;
        }
        responder = responder.nextResponder;
    } while (responder);
    return nil;
}

@end


@implementation NSObject(DDCellEvent)

- (void)tableView:(UITableView *)tableView clickCell:(UITableViewCell *)clickCell indexPath:(NSIndexPath *)indexPath atView:(UIView *)view
{

}

@end
