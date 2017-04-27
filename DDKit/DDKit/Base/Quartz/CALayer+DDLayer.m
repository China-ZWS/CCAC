//
//  CALayer+DDLayer.m
//  DDKit
//
//  Created by 周文松 on 2017/3/31.
//  Copyright © 2017年 https://github.com/China-ZWS. All rights reserved.
//

#import "CALayer+DDLayer.h"

@implementation CALayer (DDLayer)

- (CGFloat)dd_left {
    return self.frame.origin.x;
}

- (void)setDd_left:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)dd_top {
    return self.frame.origin.y;
}

- (void)setDd_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)dd_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setDd_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)dd_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setDd_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)dd_width {
    return self.frame.size.width;
}

- (void)setDd_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)dd_height {
    return self.frame.size.height;
}

- (void)setDd_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)dd_centerX {
    return self.frame.origin.x + self.frame.size.width * 0.5;
}

- (void)setDd_centerX:(CGFloat)centerX {
    CGRect frame = self.frame;
    frame.origin.x = centerX - frame.size.width * 0.5;
    self.frame = frame;
}

- (CGFloat)dd_centerY {
    return self.frame.origin.y + self.frame.size.height * 0.5;
}

- (void)setDd_centerY:(CGFloat)centerY {
    CGRect frame = self.frame;
    frame.origin.y = centerY - frame.size.height * 0.5;
    self.frame = frame;
}

- (CGPoint)dd_origin {
    return self.frame.origin;
}

- (void)setDd_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)dd_size {
    return self.frame.size;
}

- (void)setDd_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

@end
