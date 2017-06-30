//
//  CCACSignInTask.m
//  CCAC
//
//  Created by 周文松 on 2017/3/29.
//  Copyright © 2017年 周文松. All rights reserved.
//

#import "CCACSignInTask.h"

@implementation CCACSignInRequest

- (instancetype)init {
    if ((self = [super init])) {
        self.dd_requestPath = @"api/auth/login";
        
    }
    return self;
}

@end

@implementation CCACSignInResponse

@end

@implementation CCACSignInTask

+ (void)taskWithParameters:(NSDictionary *)parameters block:(void (^)(CCACSignInResponse *response))block {
    CCACSignInRequest *request = [CCACSignInRequest yy_modelWithDictionary:[parameters yy_modelToJSONObject]];
    request.openid = parameters[@"openid"];
    request.nickname = parameters[@"nickname"];
    request.headimgurl = parameters[@"headimgurl"];
    request.type = parameters[@"type"];
    request.uniqid = parameters[@"unionid"];
    [request requestWithModel:request finishedBlock:^(__kindof DDResponseModel *responseModel) {
        if (block) {
            block((CCACSignInResponse *)responseModel);
        }
    }];
}

@end
