//
//  DDSingletonDefine.h
//  DDKit
//
//  Created by Song on 16/8/26.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#ifndef DDSingletonDefine_h
#define DDSingletonDefine_h


/**
 *  定义单例（Header）
 *
 *  @param className 类名
 *  @param alias     别名
 *
 *  @return 单例对象
 */
#ifndef DEFINE_SINGLETON_FOR_HEADER_ALIAS

#define DEFINE_SINGLETON_FOR_HEADER_ALIAS(className, alias) \
\
+ (className *)alias;

#endif

/**
 *  定义单例（Implementation）
 *
 *  @param className 类名
 *  @param alias     别名
 *
 *  @return 单例对象
 */
#ifndef DEFINE_SINGLETON_FOR_CLASS_ALIAS

#define DEFINE_SINGLETON_FOR_CLASS_ALIAS(className, alias) \
\
+ (className *)alias { \
static NSMutableDictionary *managers = nil; \
if (!managers) { \
managers = [NSMutableDictionary new]; \
} \
NSString *managerName = NSStringFromClass([self class]); \
__block NSDictionary *managerInstanceDic = managers[managerName]; \
__block id sharedInstance = managerInstanceDic[@"sharedInstance"]; \
dispatch_once_t onceToken = [managerInstanceDic[@"onceToken"] longValue]; \
dispatch_once(&onceToken, ^{ \
sharedInstance = [self new]; \
}); \
managers[managerName] = @{@"onceToken":@(onceToken), \
@"sharedInstance":sharedInstance}; \
return sharedInstance; \
}

#endif

/**
 *  定义单例（Header）
 *
 *  @param className 类名
 *
 *  @return 单例对象
 */
#ifndef DEFINE_SINGLETON_FOR_H

#define DEFINE_SINGLETON_FOR_H(className) DEFINE_SINGLETON_FOR_HEADER_ALIAS(className, shared##className)

#endif

/**
 *  定义单例（Implementation）
 *
 *  @param className 类名
 *
 *  @return 单例对象
 */
#ifndef DEFINE_SINGLETON_FOR_M

#define DEFINE_SINGLETON_FOR_M(className) DEFINE_SINGLETON_FOR_CLASS_ALIAS(className, shared##className)

#endif

#endif /* DDSingletonDefine_h */
