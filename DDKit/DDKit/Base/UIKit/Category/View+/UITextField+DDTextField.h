//
//  UITextField+DDTextField.h
//  DDKit
//
//  Created by Song on 16/9/6.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (DDTextField)

/**
 Set all text selected.
 */
- (void)selectAllText;

/**
 Set text in range selected.

 @param range  The range of selected text in a document.
 */
- (void)setSelectedRange:(NSRange)range;

@end

NS_ASSUME_NONNULL_END
