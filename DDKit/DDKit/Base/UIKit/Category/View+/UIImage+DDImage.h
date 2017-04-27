//
//  UIImage+DDImage.h
//  DDKit
//
//  Created by Song on 16/8/30.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DDImage)

- (UIImage*)getSubImage:(UIImage *)image
                mCGRect:(CGRect)mCGRect
             centerBool:(BOOL)centerBool;

/**
 *  @brief  模糊效果
 *
 */
- (UIImage *)blurredImageWithRadius:(CGFloat)radius iterations:(NSUInteger)iterations tintColor:(UIColor *)tintColor;

/**
 *  @brief  修改图片尺寸
 *
 */
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;

/**
 *  @brief  图片倒角
 *
 */
- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius;

- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor;
/**
 *  @brief  绘制图片
 *
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;


- (UIImage *)resizableImageWithTop:(CGFloat)top bottom:(CGFloat)bottom left:(CGFloat)left right:(CGFloat)right;

- (UIImage *) imageWithTintColor:(UIColor *)tintColor;



@end
