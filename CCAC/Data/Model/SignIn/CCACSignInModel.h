//
//  CCACSignInModel.h
//  CCAC
//
//  Created by 周文松 on 2017/3/29.
//  Copyright © 2017年 周文松. All rights reserved.
//

#import <Foundation/Foundation.h>

// menber
#import "CACCMemberModel.h"

@interface CCACSignInModel : NSObject

@property (nonatomic, copy) NSString *token;
@property (nonatomic, strong) CACCMemberModel *member;

@end
