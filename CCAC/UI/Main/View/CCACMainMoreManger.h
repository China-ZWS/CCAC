//
//  CCACMainMoreManger.h
//  CCAC
//
//  Created by 周文松 on 2017/3/29.
//  Copyright © 2017年 周文松. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCACMainMoreManger : UIView

/**
 加载

 @param subView 子视图
 @return CCACMainMoreManger 实例
 */
+ (id)showMenuAddSubView:(UIView *)subView toView:(UIView *)toView;

/**
 消除

 @param fromView fromView
 @return 成功或失败
 */
+ (BOOL)hideMenuFromView:(UIView *)fromView;

@end
