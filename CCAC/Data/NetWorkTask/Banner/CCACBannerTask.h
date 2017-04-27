//
//  CCACBannerTask.h
//  CCAC
//
//  Created by 周文松 on 2017/3/30.
//  Copyright © 2017年 周文松. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CCACBannerModel.h"

/// banner
@interface CCACBannerRequest : DDRequestModel

@property (nonatomic, copy) NSString *lang;

@end

@interface CCACBannerResponse : DDResponseModel

@property (nonatomic, strong) NSArray <CCACBannerModel *>*data;

@end

@interface CCACBannerTask : NSObject

+ (void)taskWithLang:(NSString *)lang block:(void (^)(CCACBannerResponse *response))block;

@end
