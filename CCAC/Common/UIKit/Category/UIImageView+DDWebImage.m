//
//  UIImageView+DDWebImage.m
//  RetailClient
//
//  Created by Song on 16/9/2.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import "UIImageView+DDWebImage.h"
#import <YYWebImage/YYWebImage.h>

@implementation UIImageView (DDWebImage)

#pragma mark - helper

+ (YYWebImageManager *)avatarImageManager {
    static YYWebImageManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"weibo.avatar"];
        YYImageCache *cache = [[YYImageCache alloc] initWithPath:path];
        manager = [[YYWebImageManager alloc] initWithCache:cache queue:[YYWebImageManager sharedManager].queue];
        manager.sharedTransformBlock = ^(UIImage *image, NSURL *url) {
            CGFloat width = image.size.width < image.size.height ? image.size.width : image.size.height;
            image = [image getSubImage:image mCGRect:CGRectMake(0, 0, width, width) centerBool:YES];
            return [image imageByRoundCornerRadius:image.size.height / 2];
        };
    });
    return manager;
}

+ (UIImage *)placeholderImage
{
    static UIImage *placeholderImage;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        placeholderImage = DDImageName(@"main_more_placeholder");
    });
    return placeholderImage;
}

- (void)dd_setImageWithUrl:(NSString *)url
{
    [self dd_setImageWithUrl:url placeholder:[UIImageView placeholderImage]];
//    [self yy_setImageWithURL:[NSURL URLWithString:url]
//                 placeholder:[UIImageView placeholderImage]
//                     options:kNilOptions
//                     manager:[UIImageView avatarImageManager]
//                    progress:nil
//                   transform:nil
//                  completion:nil];

}

- (void)dd_setAvatarImageWithUrl:(NSString *)url
{
    UIImage *placeholderImage =  [UIImageView placeholderImage];

    [self yy_setImageWithURL:[NSURL URLWithString:url]
                 placeholder:[placeholderImage imageByRoundCornerRadius:placeholderImage.size.width / 2]
                     options:kNilOptions
                     manager:[UIImageView avatarImageManager]
                    progress:nil
                   transform:nil
                  completion:nil];
}

- (void)dd_setImageWithUrl:(NSString *)url placeholder:(UIImage *)image
{

    [self yy_setImageWithURL:[NSURL URLWithString:url]
                 placeholder:image
                     options:YYWebImageOptionSetImageWithFadeAnimation
                  completion:NULL];
}

- (void)dd_setImageWithUrl:(NSString *)url placeholder:(UIImage *)image complateBlock:(void (^) (UIImage *image))block
{

}

+ (void)dd_calculateDiskCachesSizeWithCompletionBlock:(void(^)(NSUInteger totalSize))completionBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        NSInteger totalCost = 0;

        YYImageCache *cache = [YYWebImageManager sharedManager].cache;
        YYImageCache *avatarCache = [UIImageView avatarImageManager].cache;

        totalCost += cache.diskCache.totalCost;
        //        totalCost += cache.memoryCache.totalCost;

        totalCost += avatarCache.diskCache.totalCost;
        //        totalCost += avatarCache.memoryCache.totalCost;

        if (completionBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(totalCost / 1024);
            });
        }
    });
}

+ (void)dd_clearDiskCachesWithCompletionBlock:(void(^)(BOOL error))completionBlock
{
    YYImageCache *cache = [YYWebImageManager sharedManager].cache;
    [cache.diskCache removeAllObjectsWithProgressBlock:^(int removedCount, int totalCount) {
        // progress
    } endBlock:completionBlock];
    [cache.memoryCache removeAllObjects];

    YYImageCache *avatarCache = [UIImageView avatarImageManager].cache;
    [avatarCache.diskCache removeAllObjectsWithProgressBlock:NULL endBlock:NULL];
    [avatarCache.memoryCache removeAllObjects];
}

+ (UIImage *)dd_imageWithUrl:(NSString *)url
{
    YYImageCache *cache = [YYWebImageManager sharedManager].cache;
    return [cache getImageForKey:url];
}

@end
