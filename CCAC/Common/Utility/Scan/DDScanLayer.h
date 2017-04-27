//
//  DDScanLayer.h
//  RetailClient
//
//  Created by Song on 16/12/30.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import <AVFoundation/AVFoundation.h>

@interface DDScanLayer : CALayer

+ (CGFloat)topGap;
+ (CGFloat)lineWidth;
+ (CGFloat)titleHeight;

/**
 *  @brief  开始动画
 */
- (void)startAnimation;

/**
 *  @brief  结束动画
 */
- (void)stopAnimation;

/**
 *  @brief  清空图层
 */
- (void)clearCorners;

/**
 *  @brief  绘制图形
 */
- (void)drawCorners:(AVMetadataMachineReadableCodeObject *)codeObject;

@end
