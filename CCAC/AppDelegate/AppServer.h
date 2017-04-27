//
//  AppServer.h
//  CCAC
//
//  Created by 周文松 on 2017/3/27.
//  Copyright © 2017年 周文松. All rights reserved.
//

#import <Foundation/Foundation.h>

// member
#import "CCACSignInModel.h"

@interface AppServer : NSObject

+ (AppServer *)server;

@property (nonatomic, readonly) CACCMemberModel *menberModel;        ///<用户模型
@property (nonatomic, readonly) NSString *token;
@property (nonatomic, readonly) NSString *visitor_uniqid;

/**
 *  @brief 设置用户模型和账户模型
 *
 *  @param signInModel 用户模型
 */
- (void)configSignInModel:(CCACSignInModel *)signInModel;

/**
 *  @brief  用户是否登录
 *
 *  @return 登录状态
 */
BOOL kUserDidLogin();

/**
 *  @brief  获取用户 ID
 *
 *  @return 用户ID
 */
NSString *kUserId();

/**
 *  @brief  获取用户token
 *
 *  @return token
 */
NSString *kUserToken();


/**
 获取上次游客登录Uniqid

 @return 返回Uniqid
 */
NSString *kVisitorUniqid();

- (void)setCookies;
- (NSString *)readJSCookie;
- (NSString *)readCookie;

- (void)clearType;

@end
