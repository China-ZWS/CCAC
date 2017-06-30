//
//  CCACProductVerifyTask.m
//  CCAC
//
//  Created by 周文松 on 2017/5/27.
//  Copyright © 2017年 周文松. All rights reserved.
//

#import "CCACProductVerifyTask.h"

@implementation CCACProductVerifyRequest

- (instancetype)init {
    if ((self = [super init])) {
        self.dd_requestType = DDRequestPost;
        self.dd_requestPath = @"api/product/verify";
    }
    return self;
}


@end

@implementation CCACProductVerifyResponse

@end

@implementation CCACProductVerifyTask

+ (void)taskWithToken:(NSString *)token menber_id:(NSString *)member_id uuid:(NSString *)uuid block:(void (^)(CCACProductVerifyResponse *response))block {
    CCACProductVerifyRequest *request = CCACProductVerifyRequest.new;
    request.token = token;
    request.member_id = member_id;
    request.uuid = uuid;
    [request requestWithModel:request finishedBlock:^(__kindof DDResponseModel *responseModel) {
        if (block) {
            block((CCACProductVerifyResponse *)responseModel);
        }
    }];
}

@end
