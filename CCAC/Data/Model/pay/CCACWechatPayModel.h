//
//  CCACWechatPayModel.h
//  CCAC
//
//  Created by 周文松 on 2017/4/5.
//  Copyright © 2017年 周文松. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCACWechatPayModel : NSObject

@property (nonatomic, copy) NSString *package;
@property (nonatomic, copy) NSString *partnerid;
@property (nonatomic, copy) NSString *prepayid;            ///<预付交易回话标识
@property (nonatomic, copy) NSString *sign;                 ///<签名
@property (nonatomic, copy) NSString *appid;                ///<appid
@property (nonatomic, copy) NSString *noncestr;             ///<随机字符串
@property (nonatomic, assign) UInt32 timestamp;             ///<时间戳

@end
