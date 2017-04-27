//
//  NSString+NSAttributed.h
//  DDKit
//
//  Created by Song on 16/10/15.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (NSAttributed)

/**
 *  前面一段文字和后面一段文字的 attributed
 */
- (NSMutableAttributedString *)dd_attributedStringWithFrontColor:(UIColor *)frontColor font:(UIFont *)frontFont frontText:(NSString *)frontText tailColor:(UIColor *)tailColor tailFont:(UIFont *)tailFont;

/// 是否左右对其 NSMutableAttributedString
- (NSMutableAttributedString *)dd_attributedStringWithFont:(UIFont *)font textColor:(UIColor *)textColor withLineSpacing:(CGFloat)lineSpacing headIndent:(CGFloat)indent alignmentJustified:(BOOL)justified;

@end

NS_ASSUME_NONNULL_END