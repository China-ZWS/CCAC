//
//  UIView+CCACView.h
//  CCAC
//
//  Created by 周文松 on 2017/3/29.
//  Copyright © 2017年 周文松. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CCACView)

@end

@interface UIView (RCProgressView)

/// 移除 progress
- (void)dismissProgress;

/// 加载视图，with text
- (void)progressWithText:(NSString *)text;

/// 成功提醒
- (void)successWithText:(NSString *)text;

/// 失败提醒
- (void)errorWithText:(NSString *)text;


@end

@interface UITableView (NotifyView)

- (void)notifyFooterViewWithText:(NSString *)notify;

@end
