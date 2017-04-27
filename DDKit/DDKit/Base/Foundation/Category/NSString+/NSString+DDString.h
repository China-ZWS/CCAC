//
//  NSString+DDString.h
//  DDKit
//
//  Created by Song on 16/9/13.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (DDString)

- (BOOL)isNotBlank;

- (NSString*)urlEncodeValue;

- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;

- (NSURL *)smartURLForString;


@end

NS_ASSUME_NONNULL_END