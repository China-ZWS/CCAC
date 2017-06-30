//
//  CCACProductVerifyTask.h
//  CCAC
//
//  Created by 周文松 on 2017/5/27.
//  Copyright © 2017年 周文松. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CCACProductVerifyModel.h"

@interface CCACProductVerifyRequest : DDRequestModel

@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *uuid;
@property (nonatomic, copy) NSString *member_id;

@end

@interface CCACProductVerifyResponse : DDResponseModel

@property (nonatomic, strong) CCACProductVerifyModel *data;

@end

@interface CCACProductVerifyTask : NSObject

+ (void)taskWithToken:(NSString *)token menber_id:(NSString *)member_id uuid:(NSString *)uuid block:(void (^)(CCACProductVerifyResponse *response))block;

@end
