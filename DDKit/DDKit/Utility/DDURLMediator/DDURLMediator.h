//
//  DDURLMediator.h
//  DDKit
//
//  Created by Song on 16/8/20.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DDSingletonDefine.h"

NS_ASSUME_NONNULL_BEGIN

typedef NSString* __nullable (^DDParseTargetBlock)(NSURL *url);
typedef NSString* __nullable (^DDParseActionBlock)(NSURL *url);


@interface DDURLMediator : NSObject

DEFINE_SINGLETON_FOR_H(DDURLMediator)

@property (nonatomic, copy) DDParseTargetBlock  parseTargetBlock;
@property (nonatomic, copy) DDParseActionBlock  parseActionBlock;

+ (void)dd_setupForScheme:(NSString *)scheme;

- (id)dd_performActionWithUrl:(NSURL *)url completion:(void(^)(NSDictionary *info))completion;

- (id)dd_performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
