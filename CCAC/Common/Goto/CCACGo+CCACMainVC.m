//
//  CCACGo+CCACMainVC.m
//  CCAC
//
//  Created by 周文松 on 2017/3/30.
//  Copyright © 2017年 周文松. All rights reserved.
//

#import "CCACGo+CCACMainVC.h"

@implementation CCACGo (CCACMainVC)

+ (void)pushLanguageVC {
    NSURL *url = GotoUrl(SCHEME, @"CCACLanguageVC", nil, nil);
    UIViewController *ctr = [[DDURLMediator sharedDDURLMediator] dd_performActionWithUrl:url completion:^(NSDictionary *info) {
        DDLog(@"%@",info);
    }];
    [self pushViewController:ctr];
}

+ (void)pushTestVC {
    NSURL *url = GotoUrl(SCHEME, @"CCACTestVC", nil, nil);
    UIViewController *ctr = [[DDURLMediator sharedDDURLMediator] dd_performActionWithUrl:url completion:^(NSDictionary *info) {
        DDLog(@"%@",info);
    }];
    [self pushViewController:ctr];
}

@end
