//
//  CCACWechatPayService.m
//  CCAC
//
//  Created by 周文松 on 2017/4/5.
//  Copyright © 2017年 周文松. All rights reserved.
//

#import "CCACWechatPayService.h"

@interface CCACWechatPayService ()

@property (nonatomic, copy) void (^payResultBlock)(CCACPayResult result, NSString *resultMessage);

@end

@implementation CCACWechatPayService

+ (instancetype)service {
    static CCACWechatPayService *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

+ (BOOL)handleOpenURL:(NSURL *)url {
    return [WXApi handleOpenURL:url delegate:[CCACWechatPayService service]];
}


- (void)payOrderWithParameterString:(PayReq *)PayReq
                           complete:(void (^)(CCACPayResult result, NSString *resultMessage))completeBlock
{
    _payResultBlock = completeBlock;
    
    if (PayReq) {
        BOOL pay = [WXApi sendReq:PayReq];
        if (!pay) {
            DDLog(@"调用微信失败");
        }
    } else {
        DDLog(@"参数出错");
    }
}

- (void)payOrderWithModel:(CCACWechatPayModel *)model complete:(void (^)(CCACPayResult result, NSString *resultMessage))completeBlock {
    if (model) {
        PayReq *req = [CCACWechatPayService dictionaryWithAppId:model.appid partnerId:model.partnerid prepayId:model.prepayid package:model.package noncestr:model.noncestr timestamp:model.timestamp sign:model.sign];
        [self payOrderWithParameterString:req complete:completeBlock];
    }
}

- (void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[PayResp class]]) {
        
        if (resp.errCode == 0) {    // 0 支付成功
            if (_payResultBlock) {
                _payResultBlock(CCACPayResultSuccess, @"支付成功");
            }
        } else if (resp.errCode == -2) {
            if (_payResultBlock) {   // -2 取消支付， -1 其他原因
                _payResultBlock(CCACPayResultCancel, @"您取消了订单支付~");
            }
        } else {
            _payResultBlock(CCACPayResultFail, @"支付失败~");
        }
    }
}

+ (PayReq *)dictionaryWithAppId:(NSString *)appId partnerId:(NSString *)partnerId prepayId:(NSString *)prepayId package:(NSString *)package noncestr:(NSString *)noncestr timestamp:(NSTimeInterval)timestamp sign:(NSString *)sign {
    PayReq *request = nil;
    if (partnerId.length > 0 && prepayId.length > 0) {
        request = [[PayReq alloc] init];
        request.partnerId = partnerId;
        request.prepayId  = prepayId;
        request.package = package;
        request.nonceStr = noncestr;
        request.timeStamp = timestamp;
        request.sign = sign;
    }
    
    return request;
}

@end
