//
//  CACCMemberModel.h
//  CCAC
//
//  Created by 周文松 on 2017/3/29.
//  Copyright © 2017年 周文松. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CACCMemberModel : NSObject

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *headimgurl;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *openid;
@property (nonatomic, copy) NSString *uniqid;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *cellphone;
@property (nonatomic, copy) NSString *rank_id;
@property (nonatomic, copy) NSString *rank_name;
@property (nonatomic, copy) NSString *category_id;
@property (nonatomic, copy) NSString *category_name;
@property (nonatomic, copy) NSString *company_name;
@property (nonatomic, copy) NSString *company_address;
@property (nonatomic, copy) NSString *real_name;
@property (nonatomic, copy) NSString *id_card;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *address_id;
@property (nonatomic, copy) NSString *updated_at;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *deleted;

@end
