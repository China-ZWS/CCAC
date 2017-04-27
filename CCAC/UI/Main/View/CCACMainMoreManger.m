//
//  CCACMainMoreView.m
//  CCAC
//
//  Created by 周文松 on 2017/3/29.
//  Copyright © 2017年 周文松. All rights reserved.
//

#import "CCACMainMoreManger.h"

@interface CCACMainMoreManger ()

@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UIView *subView;

@end

@implementation CCACMainMoreManger

- (UIView *)coverView {
    return _coverView = ({
        UIView *view = nil;
        if (_coverView) {
            view = _coverView;
        } else {
            view = UIView.new;
            view.alpha = 0;
            view.backgroundColor = DDColorRGB(20, 20, 20);
            [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap)]];
        }
        view;
    });
}

- (void)hide {
    [UIView animateWithDuration:.3f animations:^{
        _coverView.alpha = 0;
        self.dd_left = _subView.dd_left = -DDLayoutIphone6Pixels(250.f);
     }completion:^(BOOL finished){
         self.dd_width = _subView.dd_width = 0;
         [_coverView removeFromSuperview];
         [_subView removeFromSuperview];
         [self removeFromSuperview];
     }];
}

- (void)show {
    self.dd_left = _subView.dd_left = -DDLayoutIphone6Pixels(250.f);
    self.dd_width = _subView.dd_width = DDLayoutIphone6Pixels(250.f);;
    [UIView animateWithDuration:0.3f animations:^{
        _coverView.alpha = 0.5;
        self.dd_left = _subView.dd_left = 0;
    } completion:^(BOOL finished){
    }];
}

+ (id)showCoverView:(UIView *)view {
    CCACMainMoreManger *menu = [CCACMainMoreManger new];
    menu.frame = CGRectMake(0, 0, 0, view.dd_height);
    [view addSubview:menu.coverView];
    [view addSubview:menu];
    return menu;
}

+ (id)showMenuAddSubView:(UIView *)subView toView:(UIView *)toView {
    if ([CCACMainMoreManger hideMenuFromView:toView])  return nil;
    CCACMainMoreManger *menu = [CCACMainMoreManger showCoverView:toView];
    [menu addSubview:subView];
    menu.coverView.frame = toView.bounds;
    menu.subView = subView;
    [menu show];
    return menu;
}

+ (BOOL)hideMenuFromView:(UIView *)fromView {
    CCACMainMoreManger *menu = [self menuForView:fromView];
    if (menu != nil) {
        [menu hide];
        return YES;
    }
    return NO;
}

+ (CCACMainMoreManger *)menuForView:(UIView *)toView {
    NSEnumerator *subviewsEnum = [toView.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            return (CCACMainMoreManger *)subview;
        }
    }
    return nil;
}

#pragma mark - cover  事件

- (void)singleTap {
    [self hide];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
