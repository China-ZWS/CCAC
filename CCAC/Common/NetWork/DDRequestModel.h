//
//  DDRequestModel.h
//  zzKit
//
//  Created by Song on 16/8/11.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//


/// request 类型
typedef NS_ENUM(NSInteger, DDRequestType) {
    /// get 请求
    DDRequestGet                    = 0,
    /// post 请求
    DDRequestPost                      ,
};

/// request 参数签名类型
typedef NS_ENUM(NSInteger, DDRequestSignType) {
    /// SHA1
    DDRequestSignSHA1               = 0,
    /// RSA
    DDRequestSignRSA                   ,
    ///
};



/**
 *  网络请求 request 基类
 */
@interface DDRequestModel : NSObject


/// 请求域名，默认已经设置为：kNetworkRequestDomain
@property (nonatomic, copy) NSString *dd_requestDomain;

/// 请求路径，比如：www.zuojiabag.com/app/register 接口，path 就是 app/register（除域名外路径）
@property (nonatomic, copy) NSString *dd_requestPath;

/// 请求类型，默认 post
@property (nonatomic, assign) DDRequestType dd_requestType;

/// 是否使用 cdn
@property (nonatomic, assign) BOOL dd_useCDN;

/// 断点续传地址，如果有值，会将文件下载到这个地址
@property (nonatomic, copy) NSString *dd_resumableDownloadPath;

/// 请求缓存时间，多久内不发送请求，使用上一次的 response
@property (nonatomic, assign) NSUInteger dd_cacheTimeInSeconds;

/// 解析Model的名称，默认是替换自身名称的request为response得到的名字，如：DDLoginRequest -> DDLoginResponse
@property (nonatomic, copy) NSString *dd_responseModelName;

/// request header（报头）默认：（device_no-设备号、client_version-客户端版本号、request_time-请求时间戳、os_version-客户端系统版本号、from_channel-App还是h5、use_agent-设备分辨率，如：ios_320*480）
@property (nonatomic, strong) NSDictionary *dd_requestHeader;

/// 签名类型，默认 DDRequestSignSHA1
@property (nonatomic, assign) DDRequestSignType dd_signType;

@end

/**
 *  获取签名参数
 */
@interface NSDictionary(DDRequestSignParams)

- (NSString *)dd_signParams;

@end


