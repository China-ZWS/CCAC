//
//  CALayer+DDLayer.h
//  DDKit
//
//  Created by 周文松 on 2017/3/31.
//  Copyright © 2017年 https://github.com/China-ZWS. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (DDLayer)

@property (nonatomic) CGFloat dd_left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat dd_top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat dd_right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat dd_bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat dd_width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat dd_height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat dd_centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat dd_centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint dd_origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  dd_size;        ///< Shortcut for frame.size.

@end
