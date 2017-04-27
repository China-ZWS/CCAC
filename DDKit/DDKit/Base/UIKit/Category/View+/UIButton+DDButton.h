//
//  UIButton+DDButton.h
//  RetailClient
//
//  Created by Song on 16/9/22.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (DDButton)

- (void)dd_setBackgroundColor:(UIColor *)color forState:(UIControlState)state;

-(void)dd_startTime:(NSInteger )timeout title:(NSString *)title waitTitle:(NSString *)waitTitle;

@end
