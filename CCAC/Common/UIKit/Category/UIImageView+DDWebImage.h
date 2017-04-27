//
//  UIImageView+DDWebImage.h
//  RetailClient
//
//  Created by Song on 16/9/2.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (DDWebImage)

/**
 *  加载网络图片，默认设置了 placeholder
 */
- (void)dd_setImageWithUrl:(NSString *)url;

/**
 *  加载头像、圆形图片，设置了圆形图片的 placeholder
 */
- (void)dd_setAvatarImageWithUrl:(NSString *)url;

/**
 *  加载网络图片
 *
 *  @param  image 占位图
 */
- (void)dd_setImageWithUrl:(NSString *)url placeholder:(UIImage *)image;

/**
 *  加载图片，成功回调
 */
- (void)dd_setImageWithUrl:(NSString *)url placeholder:(UIImage *)image complateBlock:(void (^) (UIImage *image))block;

/**
 *  计算缓存的网络图片 (Asynchronously)
 *
 *  @param completionBlock  完成回调block
 */
+ (void)dd_calculateDiskCachesSizeWithCompletionBlock:(void(^)(NSUInteger totalSize))completionBlock;

/**
 *  清除所有缓存的网络图片 (Asynchronously)
 *
 *  @param completionBlock 完成回调Block
 */
+ (void)dd_clearDiskCachesWithCompletionBlock:(void(^)(BOOL error))completionBlock;

/**
 *  根据 URL 获取图
 */
+ (UIImage *)dd_imageWithUrl:(NSString *)url;

@end
