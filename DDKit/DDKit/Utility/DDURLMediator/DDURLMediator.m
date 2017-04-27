//
//  DDURLMediator.m
//  DDKit
//
//  Created by Song on 16/8/20.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import "DDURLMediator.h"

static DDURLMediator * mediator = nil;
static dispatch_once_t onceToken;

@interface DDURLMediator ()

@property (nonatomic, copy) NSString *safeScheme;

@end

@implementation DDURLMediator

DEFINE_SINGLETON_FOR_M(DDURLMediator)


+ (void)dd_setupForScheme:(NSString *)scheme {
    [DDURLMediator sharedDDURLMediator].safeScheme = scheme;
}

#pragma mark - public methods

- (id)init {
    self = [super init];
    if (self) {
        self.parseTargetBlock = ^(NSURL *url) {
            return url.host;
        };

        self.parseActionBlock = ^(NSURL *url) {
            return [url.path stringByReplacingOccurrencesOfString:@"/" withString:@""];
        };
    }

    return self;
}

- (id)dd_performActionWithUrl:(NSURL *)url completion:(void(^)(NSDictionary *info))completion;
{
    NSString     *scheme     = url.scheme;
    NSDictionary *params     = [self parseParams:url.query];
    NSString     *targetName = self.parseTargetBlock(url);
    NSString     *actionName = self.parseActionBlock(url);

    // 这里可以加强安全机制
    if (![[scheme lowercaseString] isEqualToString:[self.safeScheme lowercaseString]]) {
        return @(NO);
    }

    id result = [self dd_performTarget:targetName action:actionName params:params];

    if (completion) {
        completion(@{@"result": result});
    }

    return result;
}

- (id)dd_performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params {
    Class targetClass = NSClassFromString(targetName);
    id    target      = [[targetClass alloc] init];
    SEL   action      = NSSelectorFromString(actionName);

    if (target == nil) {
        return nil;
    }
    [target setValuesForKeysWithDictionary:params];

    if ([target respondsToSelector:action]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
    } else {
        return target;
    }
}

#pragma mark - private methods

//- (NSDictionary *)parseParams:(NSString *)query {
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    if (query.length && [query rangeOfString:@"="].location != NSNotFound) {
//        NSArray *keyValuePairs = [query componentsSeparatedByString:@"&"];
//        for (NSString *keyValuePair in keyValuePairs) {
//            NSArray *pair = [keyValuePair componentsSeparatedByString:@"="];
//            // don't assume we actually got a real key=value pair. start by assuming we only got @[key] before checking count
//            NSString *paramValue = pair.count == 2 ? pair[1] : @"";
//            // CFURLCreateStringByReplacingPercentEscapesUsingEncoding may return NULL
//            parameters[pair[0]] = [paramValue stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ?: @"";
//        }
//    }
//    return parameters;
//}

- (NSDictionary *)parseParams:(NSString *)query {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    for (NSString *param in [query componentsSeparatedByString:@"&"]) {
        NSArray *kvPair = [param componentsSeparatedByString:@"="];

        if (kvPair.count < 2) {
            continue;
        }
        NSString *key = kvPair[0];
        NSString *val = kvPair[1];

        val = [val stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        [params setObject:val forKey:key];
    }

    return params;
}


@end
