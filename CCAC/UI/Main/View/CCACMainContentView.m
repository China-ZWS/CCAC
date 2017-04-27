//
//  CCACMainContentView.m
//  CCAC
//
//  Created by 周文松 on 2017/3/31.
//  Copyright © 2017年 周文松. All rights reserved.
//

#import "CCACMainContentView.h"


#define kLineHeight DDLayoutIphone6Pixels(1.5f)
#define kContentGap DDLayoutIphone6Pixels(8.f)

@interface CCACMainItem : UIControl

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation CCACMainItem

- (instancetype) init {
    if ((self = [super init])) {
        _iconView = UIImageView.new;
        _iconView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_iconView];
        
        _textLabel = UILabel.new;
        _textLabel.font = DDBoldFont(DDLayoutIphone6Pixels(18.f));
        _textLabel.textColor = DDDetailColor;
        _textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_textLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize iconSize = CGSizeMake(DDLayoutIphone6Pixels(_iconView.image.size.width), DDLayoutIphone6Pixels(_iconView.image.size.height));
    CGFloat totalHeight = _textLabel.font.lineHeight + iconSize.height + kContentGap;
    
    _iconView.frame = CGRectMake((self.dd_width - iconSize.width) / 2, (self.dd_height - totalHeight) / 2 , iconSize.width, iconSize.height);
    _textLabel.frame = CGRectMake(0, _iconView.dd_bottom + kContentGap, self.dd_width, _textLabel.font.lineHeight);
}

@end

@interface CCACMainContentView ()

@property (nonatomic, strong) CALayer *lineTop;
@property (nonatomic, strong) CALayer *lineH;
@property (nonatomic, strong) CALayer *lineV;

@property (nonatomic, strong) CCACMainItem *leftTopV;
@property (nonatomic, strong) CCACMainItem *rightTopV;
@property (nonatomic, strong) CCACMainItem *leftBottomV;
@property (nonatomic, strong) CCACMainItem *rightBottomV;

@end

@implementation CCACMainContentView

- (instancetype) init {
    if ((self = [super init])) {
        _lineTop = CALayer.new;
        _lineTop.backgroundColor = DDDetailColor.CGColor;
        [self.layer addSublayer:_lineTop];

        _lineH = CALayer.new;
        _lineH.backgroundColor = DDDetailColor.CGColor;
        [self.layer addSublayer:_lineH];
        
        _lineV = CALayer.new;
        _lineV.backgroundColor = DDDetailColor.CGColor;
        [self.layer addSublayer:_lineV];
        
        _leftTopV = CCACMainItem.new;
        _leftTopV.backgroundColor = DDWhiteColor(1);
        _leftTopV.iconView.image = DDImageName(@"main_renzheng_icon");
        _leftTopV.textLabel.text = NSLocalizedString(@"CCACMainContent.top_leftText",nil);
        [_leftTopV addTarget:self action:@selector(onclickedWithTop_left) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_leftTopV];
        
        _rightTopV = CCACMainItem.new;
        _rightTopV.backgroundColor = CCACRedColor;
        _rightTopV.iconView.image = DDImageName(@"main_shopping_icon");
        _rightTopV.textLabel.text = NSLocalizedString(@"CCACMainContent.top_rightText",nil);
        _rightTopV.textLabel.textColor = DDWhiteColor(1);
        [_rightTopV addTarget:self action:@selector(onclickedWithTop_right) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_rightTopV];
        
        _leftBottomV = CCACMainItem.new;
        _leftBottomV.backgroundColor = CCACRedColor;
        _leftBottomV.iconView.image = DDImageName(@"main_culture_icon");
        _leftBottomV.textLabel.text = NSLocalizedString(@"CCACMainContent.bottom_leftText",nil);
        _leftBottomV.textLabel.textColor = DDWhiteColor(1);
        [_leftBottomV addTarget:self action:@selector(onclickedWithBottom_left) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_leftBottomV];
       
        _rightBottomV = CCACMainItem.new;
        _rightBottomV.backgroundColor = DDWhiteColor(1);
        _rightBottomV.iconView.image = DDImageName(@"main_ccac_logo_icon");
        _rightBottomV.textLabel.text = NSLocalizedString(@"CCACMainContent.bottom_rightText",nil);
        [_rightBottomV addTarget:self action:@selector(onclickedWithBottom_right) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_rightBottomV];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _lineTop.frame = CGRectMake(0, 0, self.dd_width, kLineHeight);
    _lineH.frame = CGRectMake(0, self.dd_height / 2 - kLineHeight / 2, self.dd_width, kLineHeight);
    _lineV.frame = CGRectMake(self.dd_width / 2 - kLineHeight / 2, 0, kLineHeight, self.dd_height);
    
    _leftTopV.frame = CGRectMake(0, _lineTop.dd_bottom, _lineV.dd_left, self.dd_height / 2 - kLineHeight * 3 / 2);
    _rightTopV.frame = CGRectMake(_leftTopV.dd_right + kLineHeight, _leftTopV.dd_top, _leftTopV.dd_width, _leftTopV.dd_height);
    _leftBottomV.frame = CGRectMake(0, _leftTopV.dd_bottom + kLineHeight, _leftTopV.dd_width, self.dd_height / 2 - kLineHeight / 2);
    _rightBottomV.frame = CGRectMake(_leftBottomV.dd_right + kLineHeight, _leftBottomV.dd_top, _leftTopV.dd_width, _leftBottomV.dd_height);
}

- (void)onclickedWithTop_left {
    _selected(0);
}

- (void)onclickedWithTop_right {
    _selected(1);
}

- (void)onclickedWithBottom_left {
    _selected(2);
}

- (void)onclickedWithBottom_right {
    _selected(3);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
