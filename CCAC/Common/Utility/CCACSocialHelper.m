//
//  CCACSocialHelper.m
//  CCAC
//
//  Created by 周文松 on 2017/3/30.
//  Copyright © 2017年 周文松. All rights reserved.
//

#import "CCACSocialHelper.h"

#import "WXApiRequestHandler.h"
#import "WXApiManager.h"

@implementation CCACSocialModel


@end

@interface CCACSocialHelper () <WXApiManagerDelegate>

@property (nonatomic, strong) LoginWithBlock block;

@end

@implementation CCACSocialHelper

+ (void)load {
    [super load];
    [WXApi registerApp:kWechatAppId];
    [WXApiManager sharedManager].delegate = [CCACSocialHelper server];
}

+ (CCACSocialHelper *)server {
    static dispatch_once_t onceToken;
    static CCACSocialHelper *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CCACSocialHelper alloc] init];
    });
    return sharedInstance;
}

+ (BOOL)handleOpenURL:(NSURL *)url {
   return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}


+ (void)loginWithType:(CACCLoginType)type
 presentingController:(UIViewController *)presentingController
                block:(LoginWithBlock)block {
    [CCACSocialHelper server].block = block;
    if (type == LoginWeixin) {
        [WXApiRequestHandler sendAuthRequestScope:kAuthScope
                                            State:kWXPacket_State
                                           OpenID:kWechatAppId
                                 InViewController:presentingController];

    }
}

- (void)managerDidRecvAuthResponse:(SendAuthResp *)response {
    
    SendAuthResp *resp = (SendAuthResp *)response;
    if(resp.errCode== 0 && [resp.state isEqualToString:kWXPacket_State])
    {
        NSString *code = resp.code;
        [DD_ApplicationWindow progressWithText:NSLocalizedString(@"progress.logging",nil)];
        [self getAccess_token:code];
    }
}

//通过code获取access_token，openid，unionid
- (void)getAccess_token:(NSString *)code {
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",kWechatAppId,kWeChatAppSecret,code];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data){
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSString *errcode = dic[@"errcode"];
                if (errcode) {
                    _block(NSError.new, nil);
                } else {
                    [self getUserInfo:dic];
                }
            }
        });
    });
}

- (void)getUserInfo:(NSDictionary *)data {
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",data[@"access_token"],data[@"openid"]];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *requst = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    //异步链接(形式1,较少用)
    [NSURLConnection sendAsynchronousRequest:requst queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSString *errcode = dic[@"errcode"];
        if (errcode) {
            _block(NSError.new, nil);
        } else {
            CCACSocialModel *model = [CCACSocialModel yy_modelWithDictionary:dic];
            model.type = @"wechat";
            _block(nil,model);
        }
    }];
}

@end
