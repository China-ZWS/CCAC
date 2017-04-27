//
//  DDRequestModel.m
//  DDKit
//
//  Created by Song on 16/8/11.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import "DDRequestModel.h"
#import <DeviceUtil/DeviceUtil.h>

@implementation DDRequestModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *className = NSStringFromClass([self class]);
        self.dd_responseModelName = [className stringByReplacingOccurrencesOfString:@"Request" withString:@"Response"];

        self.dd_requestType = DDRequestPost;
        self.dd_requestHeader = [self generateRequestHeader];
        self.dd_signType = DDRequestSignSHA1;
    }
    return self;
}

NSString * kDDDeviceDescription__() {
    static NSString *k_device_description_;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        k_device_description_ = [DeviceUtil hardwareDescription];
        if (k_device_description_.length == 0) {
            k_device_description_ = @"unknown hardware";
        }
    });
    return k_device_description_;
}

/// 生成 http header
- (NSDictionary *)generateRequestHeader
{
    NSMutableDictionary *headDict = [NSMutableDictionary dictionary];

    NSString *device_no = kDDDeviceDescription__();
    NSString *client_version = DD_APP_VERSION;
    if (!client_version) {
        client_version = @"iOS nil";
    }

    NSUInteger request_time = (NSUInteger)[NSDate timeIntervalSinceReferenceDate];

    NSString *os_version = DD_SYSTEM_VERSION;
    if (!os_version) {
        os_version = @"iOS nil";
    }

    NSString *use_agent = [NSString stringWithFormat:@"iOS_%.0f*%.0f", DD_ScreenWidth, DD_ScreenHeight];
    NSString *from_channel = @"iOS";
    NSString *net_type = @"wifi";

    [headDict setObject:device_no forKey:@"device_no"];
    [headDict setObject:client_version forKey:@"client_version"];
    [headDict setObject:[NSString stringWithFormat:@"%zd", request_time] forKey:@"request_time"];
    [headDict setObject:os_version forKey:@"os_version"];
    [headDict setObject:use_agent forKey:@"use_agent"];
    [headDict setObject:from_channel forKey:@"from_channel"];
    [headDict setObject:net_type forKey:@"net_type"];

    return headDict;
}

/// 设置不参与解析的字段
+ (NSArray *)modelPropertyBlacklist
{
    return @[@"dd_requestDomain", @"dd_requestPath", @"dd_requestType", @"dd_useCDN", @"dd_resumableDownloadPath", @"dd_cacheTimeInSeconds", @"dd_responseModelName", @"dd_requestHeader", @"dd_signType"];
}

@end

@implementation NSDictionary(DDRequestSignParams)

- (NSString *)dd_signParams
{
    NSString *sign = @"";

    if (self.count) {

        NSArray *allKeys = self.allKeys;
        NSArray *sortKeys = [allKeys sortedArrayUsingSelector:@selector(compare:)];

        for (NSInteger i = 0, j = sortKeys.count; i < j; i++) {

            id value = [self objectForKey:sortKeys[i]];

            if ([value isKindOfClass:[NSString class]]) {
            NSString *valueString = (NSString *)value;
            valueString = [NSString stringWithFormat:@"%@=%@", sortKeys[i], valueString];
            sign = [sign stringByAppendingString:valueString];
            }
        }
    }
    return sign;
}

@end
