//
//  CCACMainMoreView.h
//  CCAC
//
//  Created by 周文松 on 2017/3/29.
//  Copyright © 2017年 周文松. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCACMainMoreView : UITableView

@property (nonatomic, copy) void (^selected)(NSInteger, NSString *);

- (void)moreViewRefreshHeadImg;

@end
