//
//  DDScanLayer.m
//  RetailClient
//
//  Created by Song on 16/12/30.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import "DDScanLayer.h"

#define kCenterWidth     DDLayoutIphone6Pixels(230.f)
#define kTitleHeight     DDLayoutIphone6Pixels(60.f)
#define kTitleFongSize   DDLayoutIphone6Pixels(11.f)

#define kCornerLength    DDLayoutIphone6Pixels(30)
#define kCornerWidth     DDLayoutIphone6Pixels(3)


@interface DDScanLayer ()

@property (nonatomic, strong) UILabel *titleLb;
@property (strong, nonatomic) CADisplayLink *link;                      //!< 计时器
@property (nonatomic, strong) UIImageView *scrollLine;                  //!< 移动线条

@end

@implementation DDScanLayer

- (void)dealloc
{

}


- (void)drawInContext:(CGContextRef)ctx
{

    CGFloat widthGap = (CGRectGetWidth(self.frame) - kCenterWidth) / 2;
    CGFloat heightTopGap = (CGRectGetHeight(self.frame) - kCenterWidth) / 2 - kTitleHeight;

    CGContextSetFillColorWithColor(ctx, DDColorAlpha(DDTextColor,.5).CGColor);
    CGContextAddRect(ctx, CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)));
    CGContextDrawPath(ctx, kCGPathFill);

    //指定矩形
    CGRect rectangle = CGRectMake(widthGap - DD_ScreenScale * 2, heightTopGap - DD_ScreenScale * 2, kCenterWidth +  DD_ScreenScale * 4, kCenterWidth + DD_ScreenScale * 4);
    CGContextClearRect(ctx, rectangle);

    CGMutablePathRef path = CGPathCreateMutable();
    //将矩形添加到路径中
    CGPathAddRect(path,NULL,rectangle);
    CGContextSetStrokeColorWithColor(ctx,DDWhiteColor(1).CGColor);
    CGContextSetLineWidth(ctx,DD_ScreenScale);
    CGContextAddPath(ctx, path);
    CGContextDrawPath(ctx, kCGPathStroke);
    CGPathRelease(path);

    CGContextSetLineWidth(ctx,kCornerWidth);
//    CGContextSetStrokeColorWithColor(ctx,DDColorHex(0x6da82f).CGColor);
    CGContextSetStrokeColorWithColor(ctx,DDWhiteColor(1).CGColor);

    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx,widthGap, heightTopGap );
    CGContextAddLineToPoint(ctx,widthGap + kCornerLength, heightTopGap);
    CGContextMoveToPoint(ctx,CGRectGetWidth(self.frame) - kCornerLength - widthGap, heightTopGap);
    CGContextAddLineToPoint(ctx,CGRectGetWidth(self.frame) - widthGap, heightTopGap);
    CGContextMoveToPoint(ctx,widthGap, heightTopGap + kCenterWidth);
    CGContextAddLineToPoint(ctx,widthGap + kCornerLength, heightTopGap + kCenterWidth);
    CGContextMoveToPoint(ctx,CGRectGetWidth(self.frame) - kCornerLength - widthGap, heightTopGap + kCenterWidth);
    CGContextAddLineToPoint(ctx,CGRectGetWidth(self.frame) - widthGap, heightTopGap + kCenterWidth);

    CGContextMoveToPoint(ctx,widthGap, heightTopGap );
    CGContextAddLineToPoint(ctx,widthGap, heightTopGap + kCornerLength);
    CGContextMoveToPoint(ctx,CGRectGetWidth(self.frame) -  widthGap, heightTopGap);
    CGContextAddLineToPoint(ctx,CGRectGetWidth(self.frame) - widthGap, heightTopGap + kCornerLength);

    CGContextMoveToPoint(ctx,widthGap, heightTopGap + kCenterWidth);
    CGContextAddLineToPoint(ctx,widthGap, heightTopGap + kCenterWidth - kCornerLength);
    CGContextMoveToPoint(ctx,CGRectGetWidth(self.frame) -  widthGap, heightTopGap + kCenterWidth);
    CGContextAddLineToPoint(ctx,CGRectGetWidth(self.frame) - widthGap, heightTopGap + kCenterWidth - kCornerLength);

    CGContextDrawPath(ctx,kCGPathFillStroke);

//
//    //中间镂空的矩形框
//    CGRect centerRect = CGRectMake(widthGap, heightTopGap, kCenterWidth, kCenterWidth);
//    //背景
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:0];
//    //镂空
//    UIBezierPath *circlePath = [UIBezierPath bezierPathWithRect:centerRect];
//    [path appendPath:circlePath];
//    [path setUsesEvenOddFillRule:YES];
//
//    CAShapeLayer *fillLayer = [CAShapeLayer layer];
//    fillLayer.path = path.CGPath;
//    fillLayer.fillRule = kCAFillRuleEvenOdd;
//    fillLayer.fillColor = [UIColor whiteColor].CGColor;
//    fillLayer.opacity = 0.5;
//    [self addSublayer:fillLayer];
}

- (instancetype)init
{
    if ((self = [super init])) {
        //设置 背景为clear
        self.backgroundColor = DDClearColor.CGColor;
        self.opaque = NO;
        [self setUpView];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self setNeedsDisplay];

    CGFloat heightTopGap = (CGRectGetHeight(self.frame) - kCenterWidth) / 2 - kTitleHeight + kCenterWidth;
    _titleLb.frame = CGRectMake(0, heightTopGap, CGRectGetWidth(self.frame), kTitleHeight);
    _scrollLine.frame =  CGRectMake((CGRectGetWidth(self.frame) - kCenterWidth) / 2, (CGRectGetHeight(self.frame) - kCenterWidth) / 2 - kTitleHeight, kCenterWidth, 20);
}

- (void)setUpView
{
    _titleLb = UILabel.new;
    _titleLb.text = @"将二维码放入框内，即可自动扫描";
    _titleLb.font = DDFont(kTitleFongSize);
    _titleLb.textColor = DDWhiteColor(1);
    _titleLb.textAlignment = NSTextAlignmentCenter;
    [self addSublayer:_titleLb.layer];

    _scrollLine = UIImageView.new;
    _scrollLine.image = [DDImageName(@"DDScan.bundle/line") imageWithTintColor:CCACRedColor];
    _scrollLine.contentMode = UIViewContentModeScaleAspectFit;
    [self addSublayer:_scrollLine.layer];
}

#pragma mark - 定时器

- (CADisplayLink *)link
{
    return _link = ({
        CADisplayLink *l = nil;
        if (_link) {
            l = _link;
        } else {
            l = [CADisplayLink displayLinkWithTarget:self selector:@selector(lineAnimation)];
        }
        l;
    });
}

//- (void)layoutSublayers
//{
//    [super layoutSublayers];
//
//    CGFloat heightTopGap = (CGRectGetHeight(self.frame) - kCenterWidth) / 2 - kTitleHeight + kCenterWidth;
//    _titleLb.frame = CGRectMake(0, heightTopGap, CGRectGetWidth(self.frame), kTitleHeight);
//    _scrollLine.frame =  CGRectMake((CGRectGetWidth(self.frame) - kCenterWidth) / 2, (CGRectGetHeight(self.frame) - kCenterWidth) / 2 - kTitleHeight, kCenterWidth, 20);
//}

- (void)startAnimation
{
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)stopAnimation
{
    [_link invalidate];
    self.link = nil;
}

- (void)lineAnimation
{
    CGFloat y = self.scrollLine.frame.origin.y;
    y++;
    _scrollLine.dd_top = y;
    if (_scrollLine.dd_bottom > (CGRectGetHeight(self.frame) - kCenterWidth) / 2 - kTitleHeight + kCenterWidth) {
        _scrollLine.dd_top = (CGRectGetHeight(self.frame) - kCenterWidth) / 2 - kTitleHeight;
    }
}

/**
 *  画出二维码的边框
 *
 *  @param codeObject 保存了坐标的对象
 */
- (void)drawCorners:(AVMetadataMachineReadableCodeObject *)codeObject
{
    if (codeObject.corners.count == 0) {
        return;
    }

    // 1.创建一个图层
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.lineWidth = 2;
    layer.strokeColor = DDRedColor.CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;

    // 2.创建路径
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGPoint point = CGPointZero;
    NSInteger index = 0;

    // 2.1移动到第一个点
    // 从corners数组中取出第0个元素, 将这个字典中的x/y赋值给p oint
    CGPointMakeWithDictionaryRepresentation((CFDictionaryRef)codeObject.corners[index++], &point);
    [path moveToPoint:point];

    // 2.2移动到其它的点
    while (index < codeObject.corners.count) {
        CGPointMakeWithDictionaryRepresentation((CFDictionaryRef)codeObject.corners[index++], &point);
        [path addLineToPoint:point];
    }
    // 2.3关闭路径
    [path closePath];

    // 2.4绘制路径
    layer.path = path.CGPath;

    // 3.将绘制好的图层添加到drawLayer上
    [self addSublayer:layer];
}

- (void)clearCorners
{
    if (self.sublayers == nil || self.sublayers.count == 0) {
        return;
    }

    for (int i = 0; i < self.sublayers.count; i ++) {

        CALayer *subLayer = self.sublayers[i];
        if ([subLayer isMemberOfClass:[CAShapeLayer class]]) {
            [subLayer removeFromSuperlayer];
            i --;
        }
    }
}

+ (CGFloat)topGap;
{
    return (DD_ScreenHeight - kCenterWidth) / 2 - kTitleHeight;
}

+ (CGFloat)lineWidth;
{
    return kCenterWidth;
}

+ (CGFloat)titleHeight
{
    return kTitleHeight;
}

@end
