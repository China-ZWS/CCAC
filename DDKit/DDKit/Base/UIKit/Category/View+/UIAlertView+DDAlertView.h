//
//  UIAlertView+DDAlertView.h
//  RetailClient
//
//  Created by Song on 16/9/22.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (DDAlertView)

@property (nonatomic, copy, setter = bk_setDidDismissBlock:) void (^bk_didDismissBlock)(UIAlertView *alertView, NSInteger buttonIndex);

+ (UIAlertView*)dd_showAlertViewWithTitle:(NSString *)title
                                  message:(NSString *)message
                        cancelButtonTitle:(NSString *)cancelButtonTitle
                        otherButtonTitles:(NSArray *)otherButtonTitles
                                  handler:(void (^)(UIAlertView *alertView, NSInteger buttonIndex))block;
@end
