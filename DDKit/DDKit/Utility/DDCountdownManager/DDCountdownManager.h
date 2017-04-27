//
//  DDCountdownManager.h
//  DDKit
//
//  Created by Song on 16/10/17.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DDSingletonDefine.h"


/// 使用单例
#define kCountDownManager [DDCountdownManager sharedDDCountdownManager]
/// 倒计时的通知
#define kCountDownNotification @"CountDownNotification"

@interface DDCountdownManager : NSObject
DEFINE_SINGLETON_FOR_H(DDCountdownManager)

/// 时间差(单位:秒)
@property (nonatomic, assign) NSInteger timeInterval;

/// 开始倒计时
- (void)start;
/// 刷新倒计时
- (void)reload;

@end
