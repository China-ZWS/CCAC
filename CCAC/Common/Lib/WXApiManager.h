//
//  WXApiManager.h
//  CCAC
//
//  Created by 周文松 on 2017/3/30.
//  Copyright © 2017年 周文松. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WXApi.h"

@protocol WXApiManagerDelegate <NSObject>

@optional

- (void)managerDidRecvAuthResponse:(SendAuthResp *)response;

@end

@interface WXApiManager : NSObject <WXApiDelegate>

@property (nonatomic, assign) id<WXApiManagerDelegate> delegate;

+ (instancetype)sharedManager;


@end
