//
//  CCACSignInTask.h
//  CCAC
//
//  Created by 周文松 on 2017/3/29.
//  Copyright © 2017年 周文松. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CCACSignInModel.h"


@interface CCACSignInRequest : DDRequestModel

@property (nonatomic, copy) NSString *openid;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *headimgurl;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *uniqid;

@end

@interface CCACSignInResponse : DDResponseModel

@property (nonatomic, strong) CCACSignInModel *data;

@end


@interface CCACSignInTask : NSObject

+ (void)taskWithParameters:(NSDictionary *)parameters block:(void (^)(CCACSignInResponse *response))block;

@end
