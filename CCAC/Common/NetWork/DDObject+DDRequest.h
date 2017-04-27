//
//  ZZObject+ZZRequest.h
//  ZZKit
//
//  Created by Song on 16/8/11.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//


#import "DDRequestModel.h"
#import "DDResponseModel.h"

/// 请求完成后的 response
typedef void(^DDRequestFinishedBlock)(__kindof DDResponseModel *responseModel);

@interface NSObject (DDRequest)

/// 文本请求，responseName 是 替换 request 之后的：BBLoginRequest -> BBLoginResponse（responseName）
- (void)requestWithModel:(DDRequestModel *)model finishedBlock:(DDRequestFinishedBlock)block;

@end
