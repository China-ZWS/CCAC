//
//  DDTextField.h
//  DDKit
//
//  Created by Song on 16/9/6.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BorderType)
{
    kNone = 0,  /// 没有边框.
    kLine,
    kFoldLine,
};

@interface DDTextField : UITextField

@property (nonatomic) BorderType borderType;
@property (nonatomic) UIColor *borderColor;
@property (nonatomic) CGFloat borderWidth;

@end
