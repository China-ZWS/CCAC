//
//  ScreenAdaptation.h
//  DDKit
//
//  Created by Song on 16/9/1.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef CGFloat DDScreenType;

static DDScreenType DDScreenType_iPhone5 = 320.0f;
static DDScreenType DDScreenType_iPhone6 = 375.0f;
static DDScreenType DDScreenType_iPhone6P = 414.0f;


/// 获取屏幕比例
CGFloat DDScreenScale();

/// 0.5 划线
CGFloat DDScaleLineHeight();

/// 获取屏幕宽度
CGFloat DDScreenWidth();

/// 后去屏幕高度
CGFloat DDScreenHeight();

/// 根据屏幕、原始尺寸获取相应尺寸（指定最大iPhone6 plus 尺寸）
CGFloat DDLayoutPixels(DDScreenType screenType, CGFloat originPixels);

/// 根据iPhone5 设计稿获取适配屏幕高宽（指定最大iPhone6 plus 尺寸）
CGFloat DDLayoutIphone6Pixels(CGFloat originPixels);

/// 根据屏幕适配 iPhone5 设计稿，全尺寸，不会限制
CGFloat DDLayoutFullIphone5Pixels(CGFloat originPixels);

/// floor point value for pixel-aligned
static inline CGFloat DDFloatPixelFloor(CGFloat value) {
    CGFloat scale = DDScreenScale();
    return floor(value * scale) / scale;
}

/// round point value for pixel-aligned
static inline CGFloat DDFloatPixelRound(CGFloat value) {
    CGFloat scale = DDScreenScale();
    return round(value * scale) / scale;
}

/// ceil point value for pixel-aligned
static inline CGFloat DDFloatPixelCeil(CGFloat value) {
    CGFloat scale = DDScreenScale();
    return ceil(value * scale) / scale;
}
