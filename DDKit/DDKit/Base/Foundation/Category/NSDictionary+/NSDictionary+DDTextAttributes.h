//
//  NSDictionary+DDTextAttributes_h.h
//  DDKit
//
//  Created by Song on 16/8/27.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSDictionary (DDTextAttributes)

@property (nonatomic, readonly) UIFont *dd_fontAttribute;
@property (nonatomic, readonly) UIColor *dd_colorAttribute;
@property (nonatomic, readonly) NSShadow *dd_shadowAttribute;
@property (nonatomic, readonly) UIColor *dd_backgroundColorAttribute;
@property (nonatomic, readonly) NSParagraphStyle *dd_paragraphStyle;
@property (nonatomic, readonly) NSNumber *dd_strikethroughStyle;
@property (nonatomic, readonly) NSNumber *dd_underlineStyle;
@property (nonatomic, readonly) NSNumber *dd_kern;

/**
 *  创建TextAttributes用NSDictionary实例 AVAILABLE_IOS(6_0)
 *
 *  @param fontAttribute               字体属性
 *  @param colorAttribute              颜色属性
 *  @param backgroundColorAttribute    背景色属性
 *  @param shadowAttribute             阴影属性
 *  @param paragraphStyleAttribute     段落属性
 *  @param strikethroughStyleAttribute 删除线属性
 *  @param underlineStyleAttribute     下划线属性
 *  @param kernAttribute               字间距
 *
 *  @return TextAttributes用NSDictionary实例
 */
+ (instancetype)dd_textAttributesWithFont:(UIFont *)fontAttribute
                                    color:(UIColor *)colorAttribute
                          backgroundColor:(UIColor *)backgroundColorAttribute
                                   shadow:(NSShadow *)shadowAttribute
                           paragraphStyle:(NSParagraphStyle *)paragraphStyleAttribute
                       strikethroughStyle:(NSNumber *)strikethroughStyleAttribute
                           underlineStyle:(NSNumber *)underlineStyleAttribute
                                     kern:(NSNumber *)kernAttribute;

/**
 *  创建TextAttributes用NSDictionary实例
 *
 *  @param fontAttribute   字体属性
 *  @param colorAttribute  颜色属性
 *  @param shadowAttribute 阴影属性
 *
 *  @return TextAttributes用NSDictionary实例
 */
+ (instancetype)dd_textAttributesWithFont:(UIFont *)fontAttribute
                                    color:(UIColor *)colorAttribute
                                   shadow:(NSShadow *)shadowAttribute;


@end
