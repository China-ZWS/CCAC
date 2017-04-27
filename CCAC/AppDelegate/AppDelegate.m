//
//  AppDelegate.m
//  CCAC
//
//  Created by 周文松 on 2017/3/27.
//  Copyright © 2017年 周文松. All rights reserved.
//

#import "AppDelegate.h"

// window
#import "DDWindow.h"

#import "CCACSocialHelper.h"
#import "CCACWechatPayService.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)setupGeneralUIAppearance {
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    // 默认背景颜色
    [UIViewController setDD_viewControllerBackgroundColor:DDBKColor];
    
    // 导航栏标题文字属性
    [UINavigationBar dd_setNavigationBarTitleTextAttributes:[NSDictionary dd_textAttributesWithFont:DDBoldFont(18.0f) color:DDWhiteColor(1) shadow:nil]];
    
    [UINavigationBar dd_setNavigationBarTintColor:CCACRedColor];
    // 返回按钮Icon图片 Normal
    [UINavigationItem dd_setGeneralBackNormalIcon:DDImageName(@"back_icon")];
    [UINavigationItem dd_setGeneralBackHighlightIcon:DDImageName(@"back_icon")];
    
}

- (void)launchControllers {
    
    if (kUserDidLogin()) {
        _window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[NSClassFromString(@"CCACMainVC") new]];
    } else {
        _window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[NSClassFromString(@"CCACSignInVC") new]];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    [self setupGeneralUIAppearance];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"myLanguage"] && ![[[NSUserDefaults standardUserDefaults] objectForKey:@"myLanguage"] isEqualToString:@""]) {
        [NSBundle setLanguage:[[NSUserDefaults standardUserDefaults] objectForKey:@"myLanguage"]];
    }

    [DDURLMediator dd_setupForScheme:SCHEME];
    [[AppServer server] setCookies];

    // Override point for customization after application launch.
    _window = [[DDWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _window.backgroundColor = [UIColor whiteColor];
    [self launchControllers];
    [_window makeKeyAndVisible];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [CCACSocialHelper handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([[url absoluteString] rangeOfString:kSourceApplicationWechatPay].location != NSNotFound) {
        //  微信支付回调
        return [CCACWechatPayService handleOpenURL:url];
    }

    return  [CCACSocialHelper handleOpenURL:url];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
