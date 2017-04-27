//
//  UITableViewHeaderFooterView+DDTableViewHeaderFooterView.m
//  DDKit
//
//  Created by Song on 16/12/13.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import "UITableViewHeaderFooterView+DDTableViewHeaderFooterView.h"
#import <objc/runtime.h>

CGFloat const kDDTabelViewHeaderFooterViewDefaultHeight = 44.0f;
NSString *const kDDTabelViewHeaderFooterViewItemModelKey = @"kDDTabelViewHeaderFooterViewItemModelKey";

@implementation UITableViewHeaderFooterView (DDTableViewHeaderFooterView)

- (void)setDd_contentModel:(id)dd_contentModel
{
    objc_setAssociatedObject(self, &kDDTabelViewHeaderFooterViewItemModelKey, dd_contentModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)dd_contentModel
{
    return objc_getAssociatedObject(self, &kDDTabelViewHeaderFooterViewItemModelKey);
}

+ (CGFloat)dd_heightForCellWithItem:(id)item contentWidth:(CGFloat)contentWith
{
    return kDDTabelViewHeaderFooterViewDefaultHeight;
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

@implementation UITableViewHeaderFooterView(DDTableViewHeaderFooterViewEvent)

- (void)dd_headerFooterClickAtView:(UIView *)view
{
    UITableView *tableView = self.dd_tableView;
    if (tableView) {
        UIResponder *responder = tableView.delegate;
        if (responder) {

            CGRect rect = self.frame;
            NSIndexPath *indexPath = [tableView indexPathForRowAtPoint:rect.origin];
            [responder tableView:tableView clickHeaderFooter:self indexPath:indexPath atView:view];
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


@implementation NSObject(DDTableViewHeaderFooterViewEvent)

- (void)tableView:(UITableView *)tableView clickHeaderFooter:(UITableViewCell *)clickHeaderFooter indexPath:(NSIndexPath *)indexPath atView:(UIView *)view
{

}

@end

