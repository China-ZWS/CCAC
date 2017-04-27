//
//  ScreenAdaptation.m
//  DDKit
//
//  Created by Song on 16/9/1.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import "DDScreen.h"

CGFloat DDScreenScale() {
    static CGFloat scale;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        scale = [UIScreen mainScreen].scale;
    });
    return scale;
}

CGFloat DDScaleLineHeight() {
    static CGFloat height;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        height = 1 / DDScreenScale();
    });
    return height;
}

/// 获取屏幕宽度
CGFloat DDScreenWidth() {
    static CGFloat screen_width;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        screen_width = [UIScreen mainScreen].bounds.size.width;
    });
    return screen_width;
}

/// 后去屏幕高度
CGFloat DDScreenHeight() {
    static CGFloat screen_height;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        screen_height = [UIScreen mainScreen].bounds.size.height;
    });
    return screen_height;
}

/// 指定最大屏幕比例（以防iPad屏幕太宽，导致适配过大，影响 UI）
CGFloat DDSpecialScreenWidth() {
    static CGFloat max_width;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGFloat maxWidth = DDScreenWidth();
        if (maxWidth > DDScreenType_iPhone6P) {
            maxWidth = DDScreenType_iPhone6P;
        }
        max_width = maxWidth;
    });
    return max_width;
}

/// 根据屏幕、原始尺寸获取相应尺寸
CGFloat DDLayoutPixels(DDScreenType screenType, CGFloat originPixels) {
    CGFloat pixels = DDSpecialScreenWidth() / screenType * originPixels;
    return DDFloatPixelRound(pixels);
}

/// 根据iPhone5 设计稿获取适配屏幕高宽
CGFloat DDLayoutIphone6Pixels(CGFloat originPixels) {
    return DDLayoutPixels(DDScreenType_iPhone6, originPixels);
}

/// 根据屏幕适配 iPhone5 设计稿，全尺寸，不会限制
CGFloat DDLayoutFullIphone5Pixels(CGFloat originPixels) {
    CGFloat pixels = DDScreenWidth() / DDScreenType_iPhone5 * originPixels;
    return DDFloatPixelRound(pixels);
}
