//
//  UICollectionReusableView+DDCollectionReusableView.m
//  DDKit
//
//  Created by Song on 16/9/1.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import "UICollectionReusableView+DDCollectionReusableView.h"

#import <objc/runtime.h>

const NSString *kDDReusableViewItemModelKey = @"kDDReusableViewItemModelKey";

@implementation UICollectionReusableView (DDCollectionReusableView)

- (void)setDd_contentModel:(id)dd_contentModel
{
    objc_setAssociatedObject(self, &kDDReusableViewItemModelKey, dd_contentModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)dd_contentModel
{
    return objc_getAssociatedObject(self, &kDDReusableViewItemModelKey);
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

@implementation UICollectionReusableView(DDReusableViewEvent)

- (void)dd_cellClickAtView:(UIView *)view
{
    UICollectionView *collectionView = self.dd_collectionView;
    if (collectionView) {
        UIResponder *responder = collectionView.delegate;
        if (responder) {
//            collectionView
//            NSIndexPath *indexPath = [tableView indexPathForCell:self];
//            [responder tableView:tableView clickCell:self indexPath:indexPath atView:view];
        }
    }
}

- (UITableView *)dd_collectionView
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


@implementation NSObject(DDReusableViewEvent)


@end


