//
//  NSURL+DDURL.h
//  DDKit
//
//  Created by Song on 16/12/31.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (DDURL)

-(void) validateUrlWithCompletionBlock:(void(^)(BOOL))completionBlock;

@end
