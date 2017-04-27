//
//  NSTimer+DDTimer.m
//  DDKit
//
//  Created by Song on 17/1/2.
//  Copyright © 2017年 https://github.com/China-ZWS. All rights reserved.
//

#import "NSTimer+DDTimer.h"

@implementation NSTimer (DDTimer)

- (void)pause {
    if (!self.isValid) return;
    [self setFireDate:[NSDate distantFuture]];
}

- (void)resume {
    if (!self.isValid) return;
    [self setFireDate:[NSDate date]];
}

- (void)resumeWithTimeInterval:(NSTimeInterval)time {
    if (!self.isValid) return;
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:time]];
}

@end
