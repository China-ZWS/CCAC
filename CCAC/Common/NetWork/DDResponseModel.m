//
//  DDResponseModel.m
//  DDKit
//
//  Created by Song on 16/8/11.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import "DDResponseModel.h"

BOOL DDValidResponse(DDResponseModel *responseModel) {
    return responseModel != nil && responseModel.errcode == DDResponseErrorCodeNull;
}

@implementation DDResponseModel

@end
