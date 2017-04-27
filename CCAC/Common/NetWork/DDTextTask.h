//
//  ZZTextTask.h
//  RetailClient
//
//  Created by Song on 16/8/12.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>
#import "DDRequestModel.h"

@interface DDTextTask : YTKRequest

/// 设置请求相关参数
@property (nonatomic, strong) DDRequestModel *dd_requestModel;

@end
