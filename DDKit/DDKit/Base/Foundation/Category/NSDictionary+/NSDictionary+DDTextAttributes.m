//
//  NSDictionary+DDTextAttributes.m
//  DDKit
//
//  Created by Song on 16/8/27.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import "NSDictionary+DDTextAttributes.h"

@implementation NSDictionary (DDTextAttributes)

#pragma mark Property Methods

- (UIFont *)dd_fontAttribute
{
    return self[NSFontAttributeName];
}

- (UIColor *)dd_colorAttribute
{
    return self[NSForegroundColorAttributeName];
}

- (NSShadow *)dd_shadowAttribute
{
    return self[NSShadowAttributeName];
}

- (UIColor *)dd_backgroundColorAttribute
{
    return self[NSBackgroundColorAttributeName];
}

- (NSParagraphStyle *)dd_paragraphStyle
{
    return self[NSParagraphStyleAttributeName];
}

- (NSNumber *)dd_strikethroughStyle
{
    return self[NSStrikethroughStyleAttributeName];
}

- (NSNumber *)dd_underlineStyle
{
    return self[NSUnderlineStyleAttributeName];
}

- (NSNumber *)dd_kern
{
    return self[NSKernAttributeName];
}

#pragma mark Interface Methods

+ (instancetype)dd_textAttributesWithFont:(UIFont *)fontAttribute
                                    color:(UIColor *)colorAttribute
                          backgroundColor:(UIColor *)backgroundColorAttribute
                                   shadow:(NSShadow *)shadowAttribute
                           paragraphStyle:(NSParagraphStyle *)paragraphStyleAttribute
                       strikethroughStyle:(NSNumber *)strikethroughStyleAttribute
                           underlineStyle:(NSNumber *)underlineStyleAttribute
                                     kern:(NSNumber *)kernAttribute
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];

    if (fontAttribute) {
        dic[NSFontAttributeName] = fontAttribute;
    }

    if (colorAttribute) {
        dic[NSForegroundColorAttributeName] = colorAttribute;
    }

    if (backgroundColorAttribute) {
        dic[NSBackgroundColorAttributeName] = backgroundColorAttribute;
    }

    if (shadowAttribute) {
        dic[NSShadowAttributeName] = shadowAttribute;
    }

    if (paragraphStyleAttribute) {
        dic[NSParagraphStyleAttributeName] = paragraphStyleAttribute;
    }

    if (strikethroughStyleAttribute) {
        dic[NSStrikethroughStyleAttributeName] = strikethroughStyleAttribute;
    }

    if (underlineStyleAttribute) {
        dic[NSUnderlineStyleAttributeName] = underlineStyleAttribute;
    }

    if (kernAttribute) {
        dic[NSKernAttributeName] = kernAttribute;
    }

    return dic;
}

+ (instancetype)dd_textAttributesWithFont:(UIFont *)fontAttribute
                                    color:(UIColor *)colorAttribute
                                   shadow:(NSShadow *)shadowAttribute
{
    NSDictionary *dic = [NSDictionary dd_textAttributesWithFont:fontAttribute
                                                          color:colorAttribute
                                                backgroundColor:nil
                                                         shadow:shadowAttribute
                                                 paragraphStyle:nil
                                             strikethroughStyle:nil
                                                 underlineStyle:nil
                                                           kern:nil];
    
    return dic;
}

@end
