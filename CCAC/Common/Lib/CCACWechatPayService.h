//
//  CCACWechatPayService.h
//  CCAC
//
//  Created by 周文松 on 2017/4/5.
//  Copyright © 2017年 周文松. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

#import "CCACWechatPayModel.h"

static NSString *kSourceApplicationWechatPay = @"pay/?";

/// 支付结果枚举
typedef NS_ENUM(NSInteger, CCACPayResult) {
    CCACPayResultSuccess          = 0,            ///<支付成功
    CCACPayResultFail                ,            ///<支付失败
    CCACPayResultCancel              ,            ///<取消支付
    CCACPayResultProcessing          ,            ///<确认中
};

@interface CCACWechatPayService : NSObject <WXApiDelegate>

+ (instancetype)service;

+ (BOOL)handleOpenURL:(NSURL *)url;

- (void)payOrderWithModel:(CCACWechatPayModel *)model complete:(void (^)(CCACPayResult result, NSString *resultMessage))completeBlock;

@end
