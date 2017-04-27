//
//  DDAvatarView.m
//  RetailClient
//
//  Created by Song on 16/9/3.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import "DDAvatarView.h"

@interface DDAvatarView ()

@property (nonatomic, strong) CALayer *avatarBorder;    //!< 圆形头像边框
@property (nonatomic, strong) UIImageView *avatarIcon;

@end

@implementation DDAvatarView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {

        _avatarIcon = [UIImageView new];
        _avatarIcon.userInteractionEnabled = YES;
        _avatarIcon.contentMode = UIViewContentModeScaleAspectFill;
        _avatarIcon.clipsToBounds = YES;
        _avatarIcon.backgroundColor = DDClearColor;
        [self addSubview:_avatarIcon];

        _avatarBorder = [CALayer layer];
        _avatarBorder.borderWidth = DD_ScreenScale;
        _avatarBorder.borderColor = DDWhiteColor(1).CGColor;
//        _avatarBorder.shouldRasterize = YES;
//        _avatarBorder.rasterizationScale = DD_ScreenScale;
        [_avatarIcon.layer addSublayer:_avatarBorder];

        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        [_avatarIcon addGestureRecognizer:singleTap];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _avatarIcon.frame = UIEdgeInsetsInsetRect(self.bounds, _avatarInsets);
    _avatarBorder.frame = self.bounds;
    _avatarBorder.cornerRadius = _avatarIcon.dd_width / 2;
}

- (void)handleSingleTap:(UITapGestureRecognizer *)tap
{
    if ([_delegate respondsToSelector:@selector(clickEvent)] && [_delegate conformsToProtocol:@protocol(DDAvatarViewDelegate)]) {
        [_delegate clickEvent];
    }
}

- (void)setAvatarUrl:(NSString *)avatarUrl
{
    [_avatarIcon dd_setAvatarImageWithUrl:avatarUrl];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
