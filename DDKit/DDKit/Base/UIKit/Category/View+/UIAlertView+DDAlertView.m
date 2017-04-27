//
//  UIAlertView+DDAlertView.m
//  RetailClient
//
//  Created by Song on 16/9/22.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import "UIAlertView+DDAlertView.h"

@interface NSObject (DynamicDelegate) <UIAlertViewDelegate>


- (id)bk_dynamicDelegate;

@end

@implementation NSObject (DynamicDelegate)

- (id)bk_dynamicDelegate;
{
    return self;
}

@end


@implementation UIAlertView (DDAlertView)

@dynamic bk_didDismissBlock;

+ (UIAlertView*)dd_showAlertViewWithTitle:(NSString *)title
                                  message:(NSString *)message
                        cancelButtonTitle:(NSString *)cancelButtonTitle
                        otherButtonTitles:(NSArray *)otherButtonTitles
                                  handler:(void (^)(UIAlertView *alertView, NSInteger buttonIndex))block;
{
    // If no buttons were specified, cancel button becomes "Dismiss"
    if (!cancelButtonTitle.length && !otherButtonTitles.count)
        cancelButtonTitle = NSLocalizedString(@"Dismiss", nil);

    UIAlertView *alertView = [[[self class] alloc] initWithTitle:title message:message delegate:self.bk_dynamicDelegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];

    // Set other buttons
    [otherButtonTitles enumerateObjectsUsingBlock:^(NSString *button, NSUInteger idx, BOOL *stop) {
        [alertView addButtonWithTitle:button];
    }];

    // Set `didDismissBlock`
    if (block) alertView.bk_didDismissBlock = block;

    // Show alert view
    [alertView show];
    
    return alertView;
}

@end
