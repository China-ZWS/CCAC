//
//  AppServer.m
//  CCAC
//
//  Created by 周文松 on 2017/3/27.
//  Copyright © 2017年 周文松. All rights reserved.
//


NSString *const kCCACMemberModel = @"kCACCMemberModel";
NSString *const kCCACToken = @"kCACCToken";
NSString *const kCCACVisitorUniqid = @"kCCACVisitorUniqid";

#import "AppServer.h"

#import "DDCache.h"
#import "DDKitHelperObj.h"


NSString *kUserId() {
    return [AppServer server].menberModel.uniqid;
}

BOOL kUserDidLogin() {
    return kUserId() > 0;
}

NSString *kUserToken() {
    NSString *token = nil;
    if (kUserDidLogin()) {
        token = [AppServer server].token;
    }
    return token;
}

NSString *kVisitorUniqid() {
    return [AppServer server].visitor_uniqid;
}

@interface AppServer () <DDConsoleDelegate>

/// 用户模型
@property (nonatomic, strong) CACCMemberModel *menberModel;
/// token
@property (nonatomic, copy) NSString *token;
/// VisitorUniqid
@property (nonatomic, copy) NSString *visitor_uniqid;
@end

@implementation AppServer

+ (AppServer *)server {
    static dispatch_once_t onceToken;
    static AppServer *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AppServer alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _visitor_uniqid = (NSString *)[DDCache objectForKey:kCCACVisitorUniqid];
        _token = (NSString *)[DDCache objectForKey:kCCACToken];
        NSDictionary *memberDict = (NSDictionary *)[DDCache objectForKey:kCCACMemberModel];
        _menberModel = [CACCMemberModel yy_modelWithJSON:memberDict];
         /// 设置 console 代理
        [DDKitHelperObj consoleEnabled:YES withConsoleDelegate:self];
    }
    return self;
}

- (void)configSignInModel:(CCACSignInModel *)signInModel {
    self.menberModel = signInModel.member;
    self.token = signInModel.token;
    [DDCache storeObject:[_menberModel yy_modelToJSONObject] forKey:kCCACMemberModel];
    [DDCache storeObject:_token forKey:kCCACToken];
    if ( [signInModel.member.type isEqualToString:@"visitor"]) {
        self.visitor_uniqid = signInModel.member.uniqid;
        [DDCache storeObject:signInModel.member.uniqid forKey:kCCACVisitorUniqid];
    }
}

- (void)setCookies {
    if (!kUserDidLogin()) return;
    NSArray *langs = [[NSUserDefaults standardUserDefaults] valueForKey:@"AppleLanguages"];
    NSString *language = [langs.firstObject componentsSeparatedByString:@"-"].firstObject;
    NSDictionary *dic = @{@"lang":language,@"member_id":[NSString stringWithFormat:@"%zd",_menberModel.id],@"token":_token,@"isios":@"1"};
    [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        // 设定 cookie
        NSHTTPCookie *cookieWap = [NSHTTPCookie cookieWithProperties:
                                   [NSDictionary dictionaryWithObjectsAndKeys:
                                    [NSURL URLWithString:kCommentDomain].host, NSHTTPCookieDomain,
                                    @"/", NSHTTPCookiePath,
                                    key,NSHTTPCookieName,
                                    obj,NSHTTPCookieValue,
                                    nil]];
        
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookieWap];
    }];

}

- (NSString *)readJSCookie {
    NSString *domainString = [NSURL URLWithString:kCommentDomain].host;
    NSMutableString *cookieString = NSMutableString.new;
    NSHTTPCookieStorage*cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie*cookie in [cookieJar cookies]) {
        if ([cookie.domain rangeOfString:domainString].location != NSNotFound) {
            [cookieString appendFormat:@"document.cookie='%@=%@';",cookie.name,cookie.value];
        }
    }
    return cookieString;
}

- (NSString *)readCookie {
    NSString *domainString = [NSURL URLWithString:kCommentDomain].host;
    NSMutableString *cookieString = NSMutableString.new;
    NSHTTPCookieStorage*cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie*cookie in [cookieJar cookies]) {
        if ([cookie.domain rangeOfString:domainString].location != NSNotFound) {
            [cookieString appendFormat:@"%@=%@",cookie.name,cookie.value];
        }
    }
//    if (cookieString.length) {
//        [cookieString deleteCharactersInRange:NSMakeRange(cookieString.length - 1, 1)];
//    }
    return cookieString;
}

- (void)clearType {
    [DDCache storeObject:nil forKey:kCCACMemberModel];
    [DDCache storeObject:nil forKey:kCCACToken];
    if ( [_menberModel.type isEqualToString:@"visitor"]) {
        [DDCache storeObject:nil forKey:kCCACVisitorUniqid];
    }
}


#pragma mark - BBConsoleDelegate

- (NSString *)handleCommand:(NSString *)command
{
    if ([command isEqualToString:@"uid"]) {
        if (kUserDidLogin()) {
            return [NSString stringWithFormat:@"用户ID : %zd", kUserId()];
        } else {
            return @"未登录";
        }
    } else {
        return @"未设置此命令";
    }
}


@end
