//
//  CCACBannerModel.h
//  CCAC
//
//  Created by 周文松 on 2017/3/30.
//  Copyright © 2017年 周文松. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCACBannerModel : NSObject

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *lang;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) NSInteger article_id;
@property (nonatomic, assign) NSInteger sort;

@end
