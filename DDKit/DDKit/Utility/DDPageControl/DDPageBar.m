//
//  DDPageBar.m
//  DDKit
//
//  Created by Song on 16/9/26.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import "DDPageBar.h"

#import "DDCommonDefine.h"

@implementation DDPageBarItem

- (UILabel *)titleLabel
{

    return _titleLabel = ({

        UILabel *lb = UILabel.new;
        if (_titleLabel) {
            lb = _titleLabel;
        } else {
            _titleLabel = [[UILabel alloc] initWithFrame:self.contentView.bounds];
            _titleLabel.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
            _titleLabel.font = DDFont(15);
            _titleLabel.textAlignment = NSTextAlignmentCenter;
            _titleLabel.textColor = [UIColor whiteColor];
        }
        lb;
    });
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end

@interface DDPageBar ()

@end

@implementation DDPageBar

- (instancetype) initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if ((self = [super initWithFrame:frame collectionViewLayout:layout])) {

    }
    return self;
}


@end
