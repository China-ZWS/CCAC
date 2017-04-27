//
//  NSString+NSAttributed.m
//  DDKit
//
//  Created by Song on 16/10/15.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import "NSString+NSAttributed.h"

@implementation NSString (NSAttributed)


- (NSMutableAttributedString *)dd_attributedStringWithFrontColor:(UIColor *)frontColor font:(UIFont *)frontFont frontText:(NSString *)frontText tailColor:(UIColor *)tailColor tailFont:(UIFont *)tailFont
{
    NSMutableAttributedString *attributed = nil;

    if (self.length > 0 && frontText.length < self.length) {
        if (frontFont && frontColor && frontText) {
            attributed = [self dd_attributedStringFromStingWithFont:frontFont textColor:frontColor lineSpacing:0];
        }
        if (tailColor && tailFont) {
            NSRange range = NSMakeRange(frontText.length, self.length - frontText.length);
            [attributed addAttribute:NSForegroundColorAttributeName value:tailColor range:range];
            [attributed addAttribute:NSFontAttributeName value:tailFont range:range];
        }
    }

    return attributed;
}

- (NSMutableAttributedString *)dd_attributedStringFromStingWithFont:(UIFont *)font textColor:(UIColor *)textColor lineSpacing:(CGFloat)lineSpacing
{
    NSMutableAttributedString *attributed = nil;

    if (self.length > 0 && font) {
        attributed = [self dd_attributedStringFromStingWithFont:font withLineSpacing:lineSpacing];

        if (textColor) {
            [attributed addAttribute:NSForegroundColorAttributeName
                               value:textColor
                               range:[self rangeOfString:self]];
        }
    }

    return attributed;
}

- (NSMutableAttributedString *)dd_attributedStringFromStingWithFont:(UIFont *)font withLineSpacing:(CGFloat)lineSpacing
{
    return [self dd_attributedStringFromStingWithFont:font withLineSpacing:lineSpacing headIndent:0];
}

- (NSMutableAttributedString *)dd_attributedStringFromStingWithFont:(UIFont *)font withLineSpacing:(CGFloat)lineSpacing headIndent:(CGFloat)indent
{
    NSMutableAttributedString *attributedStr = nil;
    if (font && self.length > 0) {
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {

            attributedStr = [[NSMutableAttributedString alloc] initWithString:self attributes:@{NSFontAttributeName : font}];

            NSMutableParagraphStyle *paragraphStyle = [self dd_paragraphWithLineSpacing:lineSpacing headIndent:indent alignmentJustified:NO];

            [attributedStr addAttribute:NSParagraphStyleAttributeName
                                  value:paragraphStyle
                                  range:NSMakeRange(0, [self length])];
        }
    }
    return attributedStr;
}



- (NSMutableAttributedString *)dd_attributedStringWithFont:(UIFont *)font textColor:(UIColor *)textColor withLineSpacing:(CGFloat)lineSpacing headIndent:(CGFloat)indent alignmentJustified:(BOOL)justified;
{
    NSMutableAttributedString *attributedStr = nil;
    if (self.length > 0) {

        attributedStr = [[NSMutableAttributedString alloc] initWithString:self];

        if (font) {
            [attributedStr addAttribute:NSFontAttributeName
                                  value:font
                                  range:[self rangeOfString:self]];
        }
        if (textColor) {
            [attributedStr addAttribute:NSForegroundColorAttributeName
                                  value:textColor
                                  range:[self rangeOfString:self]];
        }
        if (lineSpacing > 0 || indent > 0 || justified) {
            NSMutableParagraphStyle *paragraphStyle = [self dd_paragraphWithLineSpacing:lineSpacing headIndent:indent alignmentJustified:justified];
            [attributedStr addAttribute:NSParagraphStyleAttributeName
                                  value:paragraphStyle
                                  range:[self rangeOfString:self]];
        }
    }
    return attributedStr;

}

- (NSMutableParagraphStyle *)dd_paragraphWithLineSpacing:(CGFloat)lineSpacing headIndent:(CGFloat)headIndent alignmentJustified:(BOOL)justified
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;                   // 行间距
    paragraphStyle.firstLineHeadIndent = headIndent;            // 段落第一句缩进
    if (justified) {
        paragraphStyle.alignment = NSTextAlignmentJustified;     // 对齐方式, 设置为两端对齐。
        paragraphStyle.paragraphSpacing = 0;                     // 段落后的间距
        paragraphStyle.paragraphSpacingBefore = 0;               // 段落前的间距
        paragraphStyle.headIndent = 0;                           // 头部缩进(不包括段落第一句)
    }

    return paragraphStyle;
}


@end
