//
//  ZZTextTask.m
//  RetailClient
//
//  Created by Song on 16/8/12.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import "DDTextTask.h"
#import <YTKNetwork/YTKNetworkConfig.h>
#import "NSString+DDSecurity.h"

@interface DDTextTask()

@property (nonatomic, strong) NSDictionary *dd_params;

@end

@implementation DDTextTask

+ (void)load
{
    [super load];

    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = kNetworkRequestDomain;
    config.cdnUrl = @"";
}

- (NSString*)baseUrl
{
    return _dd_requestModel.dd_requestDomain;
}

/// request path
- (NSString *)requestUrl
{
    return _dd_requestModel.dd_requestPath;
}

/// request method
- (YTKRequestMethod)requestMethod
{
    YTKRequestMethod type = YTKRequestMethodGET;
    if (_dd_requestModel.dd_requestType == DDRequestPost) {
        type = YTKRequestMethodPOST;
    }
    return type;
}

/// request 数据 dict
- (id)requestArgument
{
    if (!_dd_params) {

        NSMutableDictionary *mParams = nil;
        NSDictionary *dict = [_dd_requestModel yy_modelToJSONObject];
        
        if (dict.count) {

            mParams = [NSMutableDictionary dictionaryWithDictionary:dict];
        } else {

            mParams = [NSMutableDictionary dictionary];
        }
        NSString *signMaterial = [mParams dd_signParams];
        NSString *signValue = nil;
        if (_dd_requestModel.dd_signType == DDRequestSignSHA1) {

            signValue = [kSHA1SignSalt stringByAppendingString:signMaterial].sha1String;
        }
//        [mParams setObject:signValue forKey:@"sign"];

        self.dd_params = mParams;
    }

    return _dd_params;
}

/// 是否使用 CDN
- (BOOL)useCDN
{
    return _dd_requestModel.dd_useCDN;
}

/// 断点续传地址
- (NSString *)resumableDownloadPath
{
    return _dd_requestModel.dd_resumableDownloadPath;
}

/// 缓存时间
- (NSInteger)cacheTimeInSeconds
{
    return _dd_requestModel.dd_cacheTimeInSeconds;
}

/// 在HTTP报头添加的自定义参数
- (NSDictionary *)requestHeaderFieldValueDictionary
{
    return _dd_requestModel.dd_requestHeader;
}



@end
