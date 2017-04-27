//
//  DDCache.h
//  RetailClient
//
//  Created by Song on 16/8/16.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 默认仓储 key
extern NSString *const kZZDefaultCacheNameKey;


/// 存储
@interface DDCache : NSObject

#pragma mark - 默认仓储
/// 存储一个对象到"默认仓储" 线程同步，建议轻量级的数据存储在这里，如果 objec 为 nil，则会调用 removeObjectForKey
+ (void)storeObject:(nullable id<NSCoding>)object forKey:(nonnull NSString *)key;

/// 存储一个对象到"默认仓储" 异步，建议轻量级的数据存储在这里，如果 objec 为 nil，则会调用 removeObjectForKey
+ (void)storeObject:(nullable id<NSCoding>)object forKey:(NSString *)key withBlock:(nullable void(^)(void))block;

/// 从默认仓储中获取与 key 相关的对象，线程同步
+ (nullable id<NSCoding>)objectForKey:(nonnull NSString *)key;

/// 从默认仓储中获取与 key 相关的对象，异步
+ (void)objectForKey:(nonnull NSString *)key withBlock:(nullable void(^)(NSString *key, id<NSCoding> object))block;

/// 判断默认仓储中是否有与 key 相关的对象，线程同步
+ (BOOL)containsObjectForKey:(NSString *)key;

#pragma mark - 指定仓储
/// 存储一个对象到"指定仓储" 线程同步，如果 objec 为 nil，则会调用 removeObjectForKey
+ (void)storeObject:(nullable id<NSCoding>)object forKey:(nonnull NSString *)key toRepository:(nonnull NSString *)repositoryKey;

/// 存储一个对象到"指定仓储" 异步，如果 objec 为 nil，则会调用 removeObjectForKey
+ (void)storeObject:(nullable id<NSCoding>)object forKey:(NSString *)key toRepository:(nonnull NSString *)repositoryKey withBlock:(nullable void(^)(void))block;

/// 从"指定仓储"中获取与 key 相关的对象，线程同步
+ (nullable id<NSCoding>)objectForKey:(nonnull NSString *)key fromRepository:(nonnull NSString *)repositoryKey;

/// 从"指定仓储"中获取与 key 相关的对象，异步
+ (void)objectForKey:(nonnull NSString *)key fromRepository:(nonnull NSString *)repositoryKey withBlock:(nullable void(^)(NSString *key, id<NSCoding> object))block;

/// 判断默认仓储中是否有与 key 相关的对象，线程同步
+ (BOOL)containsObjectForKey:(NSString *)key fromRepository:(nonnull NSString *)repositoryKey;

#pragma mark - 版本控制

/// 检测与版本相关的 key值是否存在，比如：App介绍页，每个版本都要显示一次
+ (BOOL)associateVersionCacheWithKey:(nonnull NSString *)key;

/// 在当前版本记录 key，下次调用：associateVersionCacheWithKey: 的时候，返回 YES
+ (void)cacheAssociateVersionWithKey:(nonnull NSString *)key;

@end

NS_ASSUME_NONNULL_END