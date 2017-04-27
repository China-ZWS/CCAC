//
//  UIView+Quartz.h
//  DDKit
//
//  Created by Song on 16/9/6.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Quartz)

- (void)drawRectWithLine:(CGRect)rect start:(CGPoint)start end:(CGPoint)end lineColor:(UIColor *)lineColor lineWidth:(CGFloat)lineWidth;

- (void)drawTextWithText:(NSString *)text rect:(CGRect)frame color:(UIColor *)color font:(UIFont *)font;

@end
