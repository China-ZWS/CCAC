//
//  DDScanVC.h
//  RetailClient
//
//  Created by Song on 16/12/28.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface DDScanVC : UIViewController

@property (copy, nonatomic) void (^completionWithQRCodeBlock) (NSString *);      //!< 二维码扫描完成回调block

@property (copy, nonatomic) void (^completionWithOtherCodeBlock) (NSString *);    //!< 条形码扫描完成回调block

@property (nonatomic, strong) NSString *navigationTitle;
@property (nonatomic, strong) NSArray *metadataObjectTypes;

@end
