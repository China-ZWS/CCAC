//
//  CCACGo.h
//  CCAC
//
//  Created by 周文松 on 2017/3/30.
//  Copyright © 2017年 周文松. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DDURLMediator.h"

#define SCHEME @"CCAC"
#define  GotoUrl(scheme,targetName, actionName, params) [NSURL URLWithString:[NSString stringWithFormat:@"%@://%@/%@?%@",scheme,targetName,actionName,params]]


@interface CCACGo : NSObject

/**
 *  push 一个 controller
 */
+ (void)pushViewController:(UIViewController *)controller;

/**
 *  present controller
 *  不需要封装在 navigationController 下
 */
+ (void)presentViewController:(UIViewController *)controller completion:(dispatch_block_t)completion;


+ (void)dismissToRootViewControllerWithCompletion:(dispatch_block_t)completion;

+ (void)popViewController;

+ (void)popToRootViewController;


@end
