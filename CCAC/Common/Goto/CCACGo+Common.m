//
//  CCACGo+Common.m
//  CCAC
//
//  Created by 周文松 on 2017/3/30.
//  Copyright © 2017年 周文松. All rights reserved.
//

#import "CCACGo+Common.h"
#import "DDScanVC.h"

@implementation CCACGo (Common)

+ (NSMutableString *)getQueryStringFromParameter:(NSDictionary *)parameter {
    NSMutableString *query = [NSMutableString string];
    int index = 0;
    for (NSString *key in [parameter allKeys]) {
        //        NSLog(@"%@,%@",key,[fieldsToBePosted valueForKey:key]);
        // 在接收者末尾添加字符串（appendString方法）
        [query appendString:(index!=0)?@"&":@""];
        [query appendString:[NSString stringWithFormat:@"%@=%@",key,[[parameter valueForKey:key] urlEncodeValue]]];
        index++;
    }
    return query;
}

+ (void)pushWapVCWithClassName:(NSString *)className parameter:(NSDictionary *)parameter hidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed
{
    NSMutableString *query = [self getQueryStringFromParameter:parameter];
    NSURL *url = GotoUrl(SCHEME, className, nil,query);
    UIViewController *controller = [[DDURLMediator sharedDDURLMediator] dd_performActionWithUrl:url completion:^(NSDictionary *info) {
        if (!info) {
            DDLog(@"%@",url);
        }
    }];
    
    controller.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed;
    [self pushViewController:controller];
}

+ (void)pushWithParameter:(NSDictionary *)parameter {
    [self pushWapVCWithClassName:@"CCACCommonWapVC" parameter:parameter hidesBottomBarWhenPushed:YES];
}

+ (void)gotoScanWithCompletionWithQRCodeBlock:(void(^)(NSString *))completionWithQRCodeBlock
                 completionWithOtherCodeBlock:(void(^)(NSString *))completionWithOtherCodeBlock {
    NSURL *url = GotoUrl(SCHEME, @"DDScanVC", nil,nil);
    DDScanVC *controller = [[DDURLMediator sharedDDURLMediator] dd_performActionWithUrl:url completion:^(NSDictionary *info) {
        if (!info) {
            DDLog(@"%@",url);
        }
    }];
    controller.completionWithQRCodeBlock = completionWithQRCodeBlock;
    controller.completionWithOtherCodeBlock = completionWithOtherCodeBlock;
    controller.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    controller.title = NSLocalizedString(@"CCACTestVC.testText",nil);
    [self presentViewController:[[NSClassFromString(@"CCACNavigationVC") alloc] initWithRootViewController:controller] completion:NULL];
}



@end
