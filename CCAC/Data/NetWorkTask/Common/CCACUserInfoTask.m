//
//  CCACUserInfoTask.m
//  CCAC
//
//  Created by 周文松 on 2017/4/17.
//  Copyright © 2017年 周文松. All rights reserved.
//

#import "CCACUserInfoTask.h"

@implementation CCACUserInfoRequest

- (instancetype)init {
    if ((self = [super init])) {
        self.dd_requestType = DDRequestGet;
        self.dd_requestPath = @"api/member/show";
    }
    return self;
}

@end

@implementation CCACUserInfoResponse

@end

@implementation CCACUserInfoTask

+ (void)taskWithToken:(NSString *)token menber_id:(NSString *)member_id block:(void (^)(CCACUserInfoResponse *response))block {
    CCACUserInfoRequest *request = CCACUserInfoRequest.new;
    request.token = token;
    request.member_id = member_id;
    [request requestWithModel:request finishedBlock:^(__kindof DDResponseModel *responseModel) {
        if (block) {
            block((CCACUserInfoResponse *)responseModel);
        }
    }];
}


@end
