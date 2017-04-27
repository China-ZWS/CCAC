//
//  DDCellModel.h
//  DDKit
//
//  Created by Song on 16/8/27.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import "DDObject.h"
#import <UIKit/UIKit.h>

@interface DDCellModel : DDObject

@property (nonatomic, copy) NSString *dd_cellName;                  //  cell 名称
@property (nonatomic, assign) CGFloat dd_cellHeight;                //  cell 高度
@property (nonatomic, strong) id dd_contentModel;                   //  cell Model

@end
