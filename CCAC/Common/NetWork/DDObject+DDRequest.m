//
//  ZZObject+DDRequest.m
//  ZZKit
//
//  Created by Song on 16/8/11.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import "DDObject+DDRequest.h"

#import "YTKNetwork/YTKNetworkPrivate.h"
#import <AFNetworking/AFURLRequestSerialization.h>

//  task
#import "DDTextTask.h"

#import "DDKitHelperObj.h"

#if DEBUG

#ifndef kLogResponseToConsole
#define kLogResponseToConsole 0
#endif

#endif

@implementation NSObject (DDRequest)

- (void)requestWithModel:(DDRequestModel *)model finishedBlock:(DDRequestFinishedBlock)block
{
    NSAssert(model.dd_responseModelName.length > 0 || model, @"responseName 不能为空");
    NSAssert(model.dd_requestPath.length > 0, @" ******** 错误在这里 request path 不能为空 ********");

    DDTextTask *task = [DDTextTask new];
    task.dd_requestModel = model;

    NSString *baseUrl = kNetworkRequestDomain;
//
    if ([task useCDN]) {
        baseUrl = kNetworkCNDDomain;
        if ([task cdnUrl].length > 0) {
            baseUrl = [task cdnUrl];
        }
    } else {
        if ([task baseUrl].length > 0) {
            baseUrl = [task baseUrl];
        }
    }
    if ([task requestUrl].length > 0) {
        baseUrl = [baseUrl stringByAppendingPathComponent:[task requestUrl]];
    }
//
    if (model.dd_requestType == DDRequestGet) {

        NSString *requestUrl = [self urlStringWithOriginUrlString:baseUrl appendParameters:[task requestArgument]];
        DDLog(@"lsatRequestUrl = %@", requestUrl);
#if kLogResponseToConsole
        [DDKitHelperObj  consoleInfo:requestUrl];
#endif
    } else {

#if kLogResponseToConsole
        [DDKitHelperObj  consoleInfo:[NSString stringWithFormat:@"lastRequestUrl = %@, params:\n%@", baseUrl, [task requestArgument]]];
#endif
        DDLog(@"lastRequestUrl = %@, params:\n%@", baseUrl, [task requestArgument]);

    }
    [task startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {

        if (block) {

            if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {

                NSDictionary *responseJSONObjectDic = request.responseJSONObject;

                DDLog(@"lastResponse(%@) = \n%@", model.dd_responseModelName, responseJSONObjectDic.dd_stringFromDic);

#if kLogResponseToConsole
                [DDKitHelperObj  consoleInfo:[NSString stringWithFormat:@"lastResponse(%@) = \n%@", model.dd_responseModelName, responseJSONObjectDic.dd_stringFromDic]];
#endif
                id responseModel = [NSClassFromString(model.dd_responseModelName) yy_modelWithDictionary:request.responseJSONObject];
                if (!responseModel) {

                    DDLog(@"response == nil，请检查 response Name 是否设置正确");

#if kLogResponseToConsole
                    [DDKitHelperObj  consoleInfo:@"response == nil，请检查 response Name 是否设置正确"];
#endif
                }
                block(responseModel);

            } else {

                if (request.responseString.length > 0) {

                    DDLog(@"responseString(%@) = %@", model.dd_responseModelName, request.responseString);
#if kLogResponseToConsole
                    [DDKitHelperObj  consoleInfo:[NSString stringWithFormat:@"responseString(%@) = %@", model.dd_responseModelName, request.responseString]];
#endif

                } else if (request.responseData) {

                    NSString *responseDataString = [[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];

                    DDLog(@"responseDataString(%@) = %@", model.dd_responseModelName, responseDataString);

#if kLogResponseToConsole
                    [DDKitHelperObj  consoleInfo:[NSString stringWithFormat:@"responseDataString(%@) = %@", model.dd_responseModelName, responseDataString]];
#endif
                } else {

                    DDLog(@"response(%@) 不是 dict、string、data", model.dd_responseModelName);

#if kLogResponseToConsole
                    [DDKitHelperObj  consoleInfo:[NSString stringWithFormat:@"response(%@) 不是 dict、string、data", model.dd_responseModelName]];
#endif

                }

                DDResponseModel *responseModel = [NSClassFromString(model.dd_responseModelName) new];
                responseModel.errcode = DDResponseErrorCodeNotJson;
                responseModel.msg = @"返回的数据不是有效的 Json !";
                block(responseModel);
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {

        //  请求出错
        DDResponseModel *responseModel = [NSClassFromString(model.dd_responseModelName) new];
        responseModel.errcode = DDResponseErrorCodeFaild;
        responseModel.msg = @"请求失败~";
        block(responseModel);

        DDLog(@"request(%@) 请求失败, error = \n%@", NSStringFromClass(model.class), request.error.description);

#if kLogResponseToConsole
        [DDKitHelperObj  consoleInfo:[NSString stringWithFormat:@"request(%@) 请求失败, error = \n%@", NSStringFromClass(model.class), request.error.description]];
#endif
    }];
}

#pragma mark - iOS8 修改增加，后面改回来

- (NSString *)urlStringWithOriginUrlString:(NSString *)originUrlString appendParameters:(NSDictionary *)parameters
{
    NSString *filteredUrl = originUrlString;
    NSString *paraUrlString = [self urlParametersStringFromParameters:parameters];
    if (paraUrlString && paraUrlString.length > 0) {
        if ([originUrlString rangeOfString:@"?"].location != NSNotFound) {
            filteredUrl = [filteredUrl stringByAppendingString:paraUrlString];
        } else {
            filteredUrl = [filteredUrl stringByAppendingFormat:@"?%@", [paraUrlString substringFromIndex:1]];
        }
        return filteredUrl;
    } else {
        return originUrlString;
    }
}

- (NSString *)urlParametersStringFromParameters:(NSDictionary *)parameters
{
    NSMutableString *urlParametersString = [[NSMutableString alloc] initWithString:@""];
    if (parameters && parameters.count > 0) {
        for (NSString *key in parameters) {
            NSString *value = parameters[key];
            value = [NSString stringWithFormat:@"%@", value];
            value = [self urlEncode:value];
            [urlParametersString appendFormat:@"&%@=%@", key, value];
        }
    }
    return urlParametersString;
}

- (NSString*)urlEncode:(NSString*)str
{
    return AFPercentEscapedStringFromString(str);
}

@end
