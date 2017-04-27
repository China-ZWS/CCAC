//
//  DDKitHelperObj .h
//  ZZKit
//
//  Created by Song on 16/8/15.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DDConsoleDelegate <NSObject>

/// 根据命令，返回相应的值
- (NSString *)handleCommand:(NSString *)command;

@end

@interface DDKitHelperObj : NSObject

/// 获取实例
+ (DDKitHelperObj *)obj;

/// 是否开启 console，设置 console 代理
+ (void)consoleEnabled:(BOOL)enabled withConsoleDelegate:(id<DDConsoleDelegate>)delegate;

/// 记录信息到控制台
+ (void)consoleInfo:(NSString *)info;

@end
