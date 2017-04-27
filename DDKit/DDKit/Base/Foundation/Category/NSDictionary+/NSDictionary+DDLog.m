//
//  NSDictionary+DDLog.m
//  DDKit
//
//  Created by Song on 16/8/26.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import "NSDictionary+DDLog.h"

@implementation NSDictionary (DDLog)

//解决NSDitionary中文乱码问题
- (NSString *)dd_stringFromDic;
{
    if (![self count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[self description] stringByReplacingOccurrencesOfString:@"\\u"
                                                  withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

@end
