//
//  CCACBannerTask.m
//  CCAC
//
//  Created by 周文松 on 2017/3/30.
//  Copyright © 2017年 周文松. All rights reserved.
//

#import "CCACBannerTask.h"

@implementation CCACBannerRequest

- (instancetype)init {
    if ((self = [super init])) {
        self.dd_requestPath = @"api/banner/list";
    }
    return self;
}

@end

@implementation CCACBannerResponse

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"data" : [CCACBannerModel class]};
}

@end

@implementation CCACBannerTask

+ (void)taskWithLang:(NSString *)lang block:(void (^)(CCACBannerResponse *response))block {
    CCACBannerRequest *request = CCACBannerRequest.new;
    request.lang = lang;
    [request requestWithModel:request finishedBlock:^(__kindof DDResponseModel *responseModel) {
        if (block) {
            block((CCACBannerResponse *)responseModel);
        }
    }];
}

@end
