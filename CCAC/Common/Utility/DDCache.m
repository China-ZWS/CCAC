//
//  DDCache.m
//  RetailClient
//
//  Created by Song on 16/8/16.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

NSString *const kZZDefaultCacheNameKey = @"kZZDefaultCacheNameKey";

#import "DDCache.h"

#if __has_include(<YYCache/YYCache.h>)

#import <YYCache/YYCache.h>

@interface DDCache()

@property (nonatomic, strong) YYCache *yy_cache;

/// 获取 DDCache 实例
+ (DDCache *)cache;

@end

@implementation DDCache

#pragma mark - Private

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.yy_cache = [YYCache cacheWithName:kZZDefaultCacheNameKey];
    }
    return self;
}

#pragma mark - Public

+ (DDCache *)cache
{
    static dispatch_once_t onceToken;
    static DDCache *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DDCache alloc] init];
    });
    return sharedInstance;
}

#pragma mark - Cache

/// 存储一个对象到"默认仓储" 线程同步，建议轻量级的数据存储在这里
+ (void)storeObject:(nullable id<NSCoding>)object forKey:(nonnull NSString *)key
{
    [DDCache storeObject:object forKey:key toRepository:kZZDefaultCacheNameKey];
}

/// 存储一个对象到"默认仓储" 异步，建议轻量级的数据存储在这里
+ (void)storeObject:(nullable id<NSCoding>)object forKey:(NSString *)key withBlock:(nullable void(^)(void))block
{
    YYCache *cache = [YYCache cacheWithName:kZZDefaultCacheNameKey];
    [cache setObject:object forKey:key withBlock:block];
}

/// 从默认仓储中获取与 key 相关的对象，线程同步
+ (nullable id<NSCoding>)objectForKey:(nonnull NSString *)key
{
    return [DDCache objectForKey:key fromRepository:kZZDefaultCacheNameKey];
}

/// 从默认仓储中获取与 key 相关的对象，异步
+ (void)objectForKey:(nonnull NSString *)key withBlock:(nullable void(^)(NSString *key, id<NSCoding> object))block
{
    YYCache *cache = [YYCache cacheWithName:kZZDefaultCacheNameKey];
    [cache objectForKey:key withBlock:block];
}

/// 判断默认仓储中是否有与 key 相关的对象，线程同步
+ (BOOL)containsObjectForKey:(NSString *)key
{
    return [DDCache containsObjectForKey:key fromRepository:kZZDefaultCacheNameKey];
}

#pragma mark - --------/////////////////--------

/// 存储一个对象到"指定仓储" 线程同步
+ (void)storeObject:(nullable id<NSCoding>)object forKey:(nonnull NSString *)key toRepository:(nonnull NSString *)repositoryKey
{
    YYCache *cache = [YYCache cacheWithName:repositoryKey];
    [cache setObject:object forKey:key];
}

/// 存储一个对象到"指定仓储" 异步
+ (void)storeObject:(nullable id<NSCoding>)object forKey:(NSString *)key toRepository:(nonnull NSString *)repositoryKey withBlock:(nullable void(^)(void))block
{
    YYCache *cache = [YYCache cacheWithName:repositoryKey];
    [cache setObject:object forKey:key withBlock:block];
}

/// 从"指定仓储"中获取与 key 相关的对象
+ (nullable id<NSCoding>)objectForKey:(nonnull NSString *)key fromRepository:(nonnull NSString *)repositoryKey
{
    YYCache *cache = [YYCache cacheWithName:repositoryKey];
    return [cache objectForKey:key];
}

/// 从"指定仓储"中获取与 key 相关的对象，异步
+ (void)objectForKey:(nonnull NSString *)key fromRepository:(nonnull NSString *)repositoryKey withBlock:(nullable void(^)(NSString *key, id<NSCoding> object))block
{
    YYCache *cache = [YYCache cacheWithName:repositoryKey];
    [cache objectForKey:key withBlock:block];
}

+ (BOOL)containsObjectForKey:(NSString *)key fromRepository:(nonnull NSString *)repositoryKey
{
    YYCache *cache = [YYCache cacheWithName:repositoryKey];
    return [cache containsObjectForKey:key];
}

#pragma mark - 版本控制

+ (BOOL)associateVersionCacheWithKey:(nonnull NSString *)key
{
    BOOL associate = NO;
    if (key) {
        NSString *version = DD_APP_VERSION;
        NSString *versionKey = [version stringByAppendingString:key];
        YYCache *cache = [YYCache cacheWithName:kZZDefaultCacheNameKey];
        associate = [cache containsObjectForKey:versionKey];
    }
    return associate;
}

+ (void)cacheAssociateVersionWithKey:(nonnull NSString *)key
{
    if (key) {
        NSString *version = DD_APP_VERSION;
        NSString *versionKey = [version stringByAppendingString:key];
        YYCache *cache = [YYCache cacheWithName:kZZDefaultCacheNameKey];
        [cache setObject:@(YES) forKey:versionKey];
    }
}


@end

#else

@implementation DDCache

+ (DDCache *)cache
{
    CLog(@"please include <YYCache/YYCache.h>");
    return nil;
}

/// 存储一个对象到"默认仓储" 线程同步，建议轻量级的数据存储在这里
+ (void)storeObject:(nullable id<NSCoding>)object forKey:(nonnull NSString *)key
{
    DDLog(@"please include <YYCache/YYCache.h>");
}

/// 存储一个对象到"默认仓储" 异步，建议轻量级的数据存储在这里
+ (void)storeObject:(nullable id<NSCoding>)object forKey:(NSString *)key withBlock:(nullable void(^)(void))block
{
    DDLog(@"please include <YYCache/YYCache.h>");
}

/// 从默认仓储中获取与 key 相关的对象，线程同步
+ (nullable id<NSCoding>)objectForKey:(nonnull NSString *)key
{
    DDLog(@"please include <YYCache/YYCache.h>");
    return nil;
}

/// 从默认仓储中获取与 key 相关的对象，异步
+ (void)objectForKey:(nonnull NSString *)key withBlock:(nullable void(^)(NSString *key, id<NSCoding> object))block
{
    DDLog(@"please include <YYCache/YYCache.h>");
}

/// 判断默认仓储中是否有与 key 相关的对象，线程同步
+ (BOOL)containsObjectForKey:(NSString *)key
{
    DDLog(@"please include <YYCache/YYCache.h>");
    return NO;
}

#pragma mark - --------/////////////////--------

/// 存储一个对象到"指定仓储" 线程同步
+ (void)storeObject:(nullable id<NSCoding>)object forKey:(nonnull NSString *)key toRepository:(nonnull NSString *)repositoryKey
{
    DDLog(@"please include <YYCache/YYCache.h>");
}

/// 存储一个对象到"指定仓储" 异步
+ (void)storeObject:(nullable id<NSCoding>)object forKey:(NSString *)key toRepository:(nonnull NSString *)repositoryKey withBlock:(nullable void(^)(void))block
{
    DDLog(@"please include <YYCache/YYCache.h>");
}

/// 从"指定仓储"中获取与 key 相关的对象
+ (nullable id<NSCoding>)objectForKey:(nonnull NSString *)key fromRepository:(nonnull NSString *)repositoryKey
{
    DDLog(@"please include <YYCache/YYCache.h>");
    return nil;
}

/// 从"指定仓储"中获取与 key 相关的对象，异步
+ (void)objectForKey:(nonnull NSString *)key fromRepository:(nonnull NSString *)repositoryKey withBlock:(nullable void(^)(NSString *key, id<NSCoding> object))block
{
    DDLog(@"please include <YYCache/YYCache.h>");
}

+ (BOOL)containsObjectForKey:(NSString *)key fromRepository:(nonnull NSString *)repositoryKey
{
    DDLog(@"please include <YYCache/YYCache.h>");
    return NO;
}

#pragma mark - 版本控制

+ (BOOL)associateVersionCacheWithKey:(nonnull NSString *)key
{
    DDLog(@"please include <YYCache/YYCache.h>");
    return NO;
}

+ (void)cacheAssociateVersionWithKey:(nonnull NSString *)key
{
    DDLog(@"please include <YYCache/YYCache.h>");
}

@end

#endif
