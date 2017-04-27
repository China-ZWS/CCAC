//
//  DDViewControllerIntercepter.m
//  ZZKit
//
//  Created by Song on 16/8/22.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#import "DDViewControllerIntercepter.h"

#import "Aspects.h"

#import "DDCommonDefine.h"

#import "UIViewController+DDIntercepter.h"

#import "UIViewController+DDViewController.h"

#import "UINavigationBar+DDNavigationBar.h"

NSString * kZZFirstLoadedKey = @"kZZFirstLoadedKey";
static NSDictionary *kExcludeController;





#pragma mark -
#pragma mark - category for viewcontroller

@interface UIViewController(DDViewControllerIntercepter)

/// 执行完 viewDidAppear 后，dd_firstLoaded = yes
@property (nonatomic, assign) BOOL dd_firstLoaded;

@end

@implementation UIViewController(DDViewControllerIntercepter)

- (void)setDd_firstLoaded:(BOOL)dd_firstLoaded
{
    objc_setAssociatedObject(self, &kZZFirstLoadedKey, @(dd_firstLoaded), OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

- (BOOL)dd_firstLoaded
{
    NSNumber *firstLoaded =objc_getAssociatedObject(self, &kZZFirstLoadedKey);
    return [firstLoaded boolValue];
}

@end

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////


@implementation DDViewControllerIntercepter

+ (void)load
{
    [super load];

    [DDViewControllerIntercepter sharedInstance];
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static DDViewControllerIntercepter *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DDViewControllerIntercepter alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {

        kExcludeController = @{@"UIInputWindowController" : @(YES),
                               @"WXUIWebViewControll":@(YES),
                               @"UINavigationController" : @(YES),
                               @"UIInputViewController" : @(YES),
                               @"UICompatibilityInputViewController" : @(YES),
                               @"_UIRemoteInputViewController" : @(YES),
                               @"UIApplicationRotationFollowingControllerNoTouches" : @(YES),
                               @"UIKeyboardCandidateGridCollectionViewController" : @(YES),
                               @"UIApplicationRotationFollowingController" : @(YES),
                               @"UIAlertController" : @(YES),
                               @"_UIAlertShimPresentingViewController" : @(YES),
                               @"_UIAlertControllerTextFieldViewController" : @(YES),
                               @"_UIFallbackPresentationViewController" : @(YES),
                               @"UIActivityViewController" : @(YES),
                               @"UIActivityGroupViewController" : @(YES),
                               @"_UIActivityGroupListViewController" : @(YES),
                               @"SFAirDropActivityViewController" : @(YES)};

        /// viewDidLoad 拦截
        [UIViewController aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {

            [self dd_viewDidLoad:[aspectInfo instance]];

        } error:NULL];

        /// viewWillAppear: 拦截
        [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated) {

            [self dd_viewWillAppear:animated viewController:[aspectInfo instance]];

        } error:NULL];

        /// viewDidAppear: 拦截
        [UIViewController aspect_hookSelector:@selector(viewDidAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated) {

            [self dd_viewDidAppear:animated viewController:[aspectInfo instance]];

        } error:NULL];
    }
    return self;
}

- (void)dd_viewDidLoad:(UIViewController *)controller
{
    NSString *stringFromController = NSStringFromClass([controller class]);
    if (kExcludeController[stringFromController]) {
        //        DDLog(@"%@ not setup viewDidLoad", stringFromController);
    } else {

        if ([[controller class] isSubclassOfClass:[UINavigationController class]]) {
            //  UINavigationController
            //            DDLog(@"%@ not setup viewDidLoad", stringFromController);
        }
        else if ([[controller class] isSubclassOfClass:[UIInputViewController class]]) {
            //  UIInputViewController
            //            DDLog(@"%@ not setup viewDidLoad", stringFromController);
        }
        else if ([[controller class] isSubclassOfClass:[UIAlertController class]]) {
            //  UIAlertController
            //            DDLog(@"%@ not setup viewDidLoad", stringFromController);
        }
        else {

            [self dd_setupNavigationBar:controller];

            controller.view.backgroundColor = [UIViewController dd_viewControllerBackgroundColor];

            //            DDLog(@"%@ -- xxxxxx", stringFromController);
        }
    }
}

- (void)dd_viewWillAppear:(BOOL)animated viewController:(UIViewController *)controller
{
    NSString *stringFromController = NSStringFromClass([controller class]);
    if (!kExcludeController[stringFromController]) {

        [controller.navigationController setNavigationBarHidden:[controller dd_isNaviBarHidden] animated:controller.dd_firstLoaded || controller.navigationController.viewControllers.firstObject != controller];

        if (!controller.dd_firstLoaded) {
            [controller dd_viewWillAppearForTheFirstTime];
        }
    }
}

- (void)dd_viewDidAppear:(BOOL)animated viewController:(UIViewController *)controller
{
    NSString *stringFromController = NSStringFromClass([controller class]);
    if (!kExcludeController[stringFromController]) {

        if (!controller.dd_firstLoaded) {
            controller.dd_firstLoaded = YES;
            [controller dd_viewDidAppearForTheFirstTime];
        }
    }
}

- (void)dd_setupNavigationBar:(UIViewController *)controller
{
    if (controller.navigationController.viewControllers.lastObject != controller) {
        return;
    }
    controller.navigationController.navigationBar.translucent = NO;
    if (controller.navigationController.navigationBar.dd_navigationBarTitleTextAttributes) {
        [controller.navigationController.navigationBar setTitleTextAttributes:controller.navigationController.navigationBar.dd_navigationBarTitleTextAttributes];
    }

    // 自动添加返回按钮
    if (controller.navigationController && ![controller dd_isNaviBackItemHidden]) {
        if (controller.navigationController.viewControllers.count > 1 && controller != controller.navigationController.viewControllers.firstObject) {
            [controller dd_addBackButton];
        } else if (controller.navigationController.presentingViewController) {
            [controller dd_addBackButton];
        }
    } else {
        controller.navigationItem.backBarButtonItem  = nil;
        controller.navigationItem.hidesBackButton = YES;
    }

    UIColor *tintColor = controller.navigationController.navigationBar.dd_navigationBarTintColor;
    controller.navigationController.navigationBar.barTintColor = tintColor;
}

@end
