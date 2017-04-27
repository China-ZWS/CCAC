//
//  CCACSocialHelper.h
//  CCAC
//
//  Created by 周文松 on 2017/3/30.
//  Copyright © 2017年 周文松. All rights reserved.
//

#import <Foundation/Foundation.h>


/// 登录类型枚举
typedef NS_ENUM(NSInteger, CACCLoginType) {
    LoginWeibo                     ,            ///<微博登录
    LoginWeixin                    ,            ///<微信登录
    LoginQQ                                     ///<QQ 登录
};


/// 第三方帐号获取信息后Model
@interface CCACSocialModel : DDObject

@property (nonatomic, copy) NSString *openid;
@property (nonatomic, copy) NSString *unionid;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *headimgurl;
@property (nonatomic, copy) NSString *type;

@end


/// 登录成功或失败回调。error = nil 为成功，否则 error里面是错误信息。Model 包含第三方平台信息。
typedef void (^LoginWithBlock) (NSError *error, CCACSocialModel *model);


@interface CCACSocialHelper : NSObject

+ (CCACSocialHelper *)server;

+ (void)loginWithType:(CACCLoginType)type presentingController:(UIViewController *)presentingController block:(LoginWithBlock)block;
+ (BOOL)handleOpenURL:(NSURL *)url;


@end
