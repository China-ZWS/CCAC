//
//  UIView+CCACView.m
//  CCAC
//
//  Created by 周文松 on 2017/3/29.
//  Copyright © 2017年 周文松. All rights reserved.
//

#import "UIView+CCACView.h"

@implementation UIView (CCACView)

@end

@implementation UIView (RCProgressView)


+ (void)load
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
    [SVProgressHUD setMinimumDismissTimeInterval:1.f];
    [SVProgressHUD setBackgroundColor:DDWhiteColor(1)];
    [SVProgressHUD setBackgroundLayerColor:DDClearColor];
}

- (void)dismissProgress;
{
    [SVProgressHUD dismiss];
}

- (void)progressWithText:(NSString *)text;
{
    [SVProgressHUD showWithStatus:text];
}

- (void)successWithText:(NSString *)text;
{
    [SVProgressHUD showSuccessWithStatus:text];
}


- (void)errorWithText:(NSString *)text;
{
    [SVProgressHUD showInfoWithStatus:text];
}

@end


@implementation UITableView(NotifyView)

- (void)notifyFooterViewWithText:(NSString *)notify
{
    UIView *footerView = [[UIView alloc] initWithFrame:self.bounds];
    UILabel *label = UILabel.new;
    label.frame = CGRectMake(40.0f, 0, footerView.dd_width - 40 * 2, footerView.dd_height * 3 / 4 - DDLayoutIphone6Pixels(20.0f));
    label.font = DDFont(DDLayoutIphone6Pixels(13.0f));
    label.textColor = DDColorRGB(205, 206, 207);
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.text = notify;
    [footerView addSubview:label];
    
    self.tableFooterView = footerView;
}

@end
