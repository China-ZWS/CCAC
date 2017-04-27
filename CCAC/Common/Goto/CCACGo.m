//
//  CCACGo.m
//  CCAC
//
//  Created by 周文松 on 2017/3/30.
//  Copyright © 2017年 周文松. All rights reserved.
//

#import "CCACGo.h"

#import "DDURLNavgation.h"

@implementation CCACGo

+ (void)pushViewController:(UIViewController *)controller;
{
    [DDURLNavgation pushViewController:controller animated:YES replace:NO];
}

+ (void)presentViewController:(UIViewController *)controller completion:(dispatch_block_t)completion;
{
    [DDURLNavgation presentViewController:controller animated:YES completion:completion];
}

+ (void)dismissToRootViewControllerWithCompletion:(dispatch_block_t)completion
{
    [DDURLNavgation dismissToRootViewControllerAnimated:YES completion:completion];
}

+ (void)popViewController
{
    [DDURLNavgation popViewControllerWithTimes:1 animated:YES];
}

+ (void)popToRootViewController
{
    [DDURLNavgation popToRootViewControllerAnimated:YES];
}

@end
