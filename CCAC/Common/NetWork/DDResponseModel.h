//
//  DDResponseModel.h
//  ZZKit
//
//  Created by Song on 16/8/11.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

/// response 错误码定义
typedef NS_ENUM(NSInteger, DDResponseErrorCode) {
    /// 请求失败
    DDResponseErrorCodeFaild                    = -404,
    /// 网络出错
    DDResponseErrorCodeNetwork                        ,
    /// 返回数据不是 json
    DDResponseErrorCodeNotJson                        ,
    /// 未知错误
    DDResponseErrorCodeUnknown                        ,
    /// 没有错误
    DDResponseErrorCodeNull                     = 0,
};

#import "DDObject.h"

@interface DDResponseModel : DDObject

/// 错误码
@property (nonatomic, assign) DDResponseErrorCode errcode;

/// 响应说明
@property (nonatomic, copy) NSString *msg;

/// 检验 response 是否有效
BOOL DDValidResponse(DDResponseModel *responseModel);

@end
