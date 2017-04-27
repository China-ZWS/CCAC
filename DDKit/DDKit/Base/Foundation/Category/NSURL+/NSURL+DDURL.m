//
//  NSURL+DDURL.m
//  DDKit
//
//  Created by Song on 16/12/31.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import "NSURL+DDURL.h"

@implementation NSURL (DDURL)

//判断
-(void) validateUrlWithCompletionBlock:(void(^)(BOOL))completionBlock {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self];
    [request setHTTPMethod:@"HEAD"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"error %@",error);
        if (!request && error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(NO);
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(YES);
            });
        }
    }];
    [task resume];
}

@end
