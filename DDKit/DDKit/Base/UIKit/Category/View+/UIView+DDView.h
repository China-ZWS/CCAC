//
//  UIView+DDView.h
//  DDKit
//
//  Created by Song on 16/8/27.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (DDView)

/**
 Create a snapshot image of the complete view hierarchy.
 */
- (nullable UIImage *)dd_snapshotImage;

/**
 Create a snapshot image of the complete view hierarchy.
 @discussion It's faster than "snapshotImage", but may cause screen updates.
 See -[UIView drawViewHierarchyInRect:afterScreenUpdates:] for more information.
 */
- (nullable UIImage *)dd_snapshotImageAfterScreenUpdates:(BOOL)afterUpdates;

/**
 Create a snapshot PDF of the complete view hierarchy.
 */
- (nullable NSData *)dd_snapshotPDF;

/**
 Shortcut to set the view.layer's shadow

 @param color  Shadow Color
 @param offset Shadow offset
 @param radius Shadow radius
 */
- (void)dd_setLayerShadow:(nullable UIColor*)color dd_offset:(CGSize)offset dd_radius:(CGFloat)radius;

/**
 Remove all subviews.

 @warning Never call this method inside your view's drawRect: method.
 */
- (void)dd_removeAllSubviews;

/**
 Returns the view's view controller (may be nil).
 */
@property (nullable, nonatomic, readonly) UIViewController *dd_viewController;

@property (nullable, nonatomic, readonly) UIViewController *dd_viewControllerFromWidow;

/**
 Returns the visible alpha on screen, taking into account superview and window.
 */
@property (nonatomic, readonly) CGFloat dd_visibleAlpha;

/**
 Converts a point from the receiver's coordinate system to that of the specified view or window.

 @param point A point specified in the local coordinate system (bounds) of the receiver.
 @param view  The view or window into whose coordinate system point is to be converted.
 If view is nil, this method instead converts to window base coordinates.
 @return The point converted to the coordinate system of view.
 */
- (CGPoint)dd_convertPoint:(CGPoint)point dd_toViewOrWindow:(nullable UIView *)view;

/**
 Converts a point from the coordinate system of a given view or window to that of the receiver.

 @param point A point specified in the local coordinate system (bounds) of view.
 @param view  The view or window with point in its coordinate system.
 If view is nil, this method instead converts from window base coordinates.
 @return The point converted to the local coordinate system (bounds) of the receiver.
 */
- (CGPoint)dd_convertPoint:(CGPoint)point dd_fromViewOrWindow:(nullable UIView *)view;

/**
 Converts a rectangle from the receiver's coordinate system to that of another view or window.

 @param rect A rectangle specified in the local coordinate system (bounds) of the receiver.
 @param view The view or window that is the target of the conversion operation. If view is nil, this method instead converts to window base coordinates.
 @return The converted rectangle.
 */
- (CGRect)dd_convertRect:(CGRect)rect dd_toViewOrWindow:(nullable UIView *)view;

/**
 Converts a rectangle from the coordinate system of another view or window to that of the receiver.

 @param rect A rectangle specified in the local coordinate system (bounds) of view.
 @param view The view or window with rect in its coordinate system.
 If view is nil, this method instead converts from window base coordinates.
 @return The converted rectangle.
 */
- (CGRect)dd_convertRect:(CGRect)rect dd_fromViewOrWindow:(nullable UIView *)view;


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

NS_ASSUME_NONNULL_END

