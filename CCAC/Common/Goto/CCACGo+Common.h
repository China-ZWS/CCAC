//
//  CCACGo+Common.h
//  CCAC
//
//  Created by 周文松 on 2017/3/30.
//  Copyright © 2017年 周文松. All rights reserved.
//

#import "CCACGo.h"

@interface CCACGo (Common)


/**
 *  native to Wap
 */
+ (void)pushWapVCWithClassName:(NSString *)className parameter:(NSDictionary *)parameter hidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed;

+ (NSMutableString *)getQueryStringFromParameter:(NSDictionary *)parameter;

+ (void)pushWithParameter:(NSDictionary *)parameter;

+ (void)gotoScanWithCompletionWithQRCodeBlock:(void(^)(NSString *))completionWithQRCodeBlock
                 completionWithOtherCodeBlock:(void(^)(NSString *))completionWithOtherCodeBlock;


@end
