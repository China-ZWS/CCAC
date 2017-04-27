//
//  NSTimer+DDTimer.h
//  DDKit
//
//  Created by Song on 17/1/2.
//  Copyright © 2017年 https://github.com/China-ZWS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (DDTimer)

- (void)pause;
- (void)resume;
- (void)resumeWithTimeInterval:(NSTimeInterval)time;

@end
