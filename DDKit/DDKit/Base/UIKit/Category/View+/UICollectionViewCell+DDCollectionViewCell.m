//
//  UICollectionViewCell+DDCollectionViewCell.m
//  DDKit
//
//  Created by Song on 16/9/1.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import "UICollectionViewCell+DDCollectionViewCell.h"

#import <objc/runtime.h>

const NSString *kDDCollectionViewCellItemModelKey = @"kDDCollectionViewCellItemModelKey";

@implementation UICollectionViewCell (DDCollectionViewCell)

- (void)setDd_contentModel:(id)dd_contentModel
{
    objc_setAssociatedObject(self, &kDDCollectionViewCellItemModelKey, dd_contentModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)dd_contentModel
{
    return objc_getAssociatedObject(self, &kDDCollectionViewCellItemModelKey);
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

@implementation UICollectionViewCell(DDCollectionViewCellEvent)

- (void)dd_cellClickAtView:(UIView *)view
{
    UICollectionView *collectionView = self.dd_collectionView;
    if (collectionView) {
        UIResponder *responder = collectionView.delegate;
        if (responder) {
            NSIndexPath *indexPath = [collectionView indexPathForCell:self];
            [responder collectionView:collectionView clickCell:self indexPath:indexPath atView:view];
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


@implementation NSObject(DDCollectionViewCellEvent)

- (void)collectionView:(UICollectionView *)collectionView clickCell:(UICollectionViewCell *)clickCell indexPath:(NSIndexPath *)indexPath atView:(UIView *)view;
{

}

@end

