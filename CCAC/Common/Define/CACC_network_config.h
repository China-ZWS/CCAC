//
//  CACC_network_config.h
//  CCAC
//
//  Created by 周文松 on 2017/3/27.
//  Copyright © 2017年 周文松. All rights reserved.
//

#ifndef CACC_network_config_h
#define CACC_network_config_h


/// 位置网络加载错误提醒
#define kUnknownErrorTips @"网络加载失败，未知错误"

#define kSHA1SignSalt @"zz_mytx"
#define kNetworkCNDDomain @""



#if DEBUG  ///<测试环境>///////////////////////////////////////////////////////////////////////
#define kNetworkRequestDomain @"http://eshop.argentina.zjtech.cc"
#define kCommentDomain @"http://eshop.argentina.zjtech.cc/ios_web"
#else     ///<生产环境>/////////////////////////////////////////////////////////////////////////
#define kNetworkRequestDomain @"http://eshop.argentina.zjtech.cc"
#define kCommentDomain @"http://eshop.argentina.zjtech.cc/ios_web"
#endif


#endif /* CACC_network_config_h */
