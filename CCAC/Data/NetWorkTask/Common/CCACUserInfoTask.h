//
//  CCACUserInfoTask.h
//  CCAC
//
//  Created by 周文松 on 2017/4/17.
//  Copyright © 2017年 周文松. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CACCMemberModel.h"

@interface CCACUserInfoRequest : DDRequestModel

@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *member_id;

@end

@interface CCACUserInfoResponse : DDResponseModel

@property (nonatomic, strong) CACCMemberModel *data;

@end

@interface CCACUserInfoTask : NSObject

+ (void)taskWithToken:(NSString *)token menber_id:(NSString *)member_id block:(void (^)(CCACUserInfoResponse *response))block;

@end
