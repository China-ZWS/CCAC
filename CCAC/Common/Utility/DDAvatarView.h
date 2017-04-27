//
//  DDAvatarView.h
//  RetailClient
//
//  Created by Song on 16/9/3.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DDAvatarViewDelegate <NSObject>

- (void)clickEvent;

@end

@interface DDAvatarView : UIView

@property (nonatomic, strong) NSString *avatarUrl;          //!<头像 URL
@property (nonatomic, assign) UIEdgeInsets avatarInsets;    //!<头像边距
@property (nonatomic, assign) id<DDAvatarViewDelegate>delegate;

@end
