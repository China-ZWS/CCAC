//
//  DDWindow.m
//  RetailClient
//
//  Created by Song on 16/8/27.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import "DDWindow.h"

#import "iConsole.h"

@implementation DDWindow

- (void)sendEvent:(UIEvent *)event{
#ifdef DEBUG
    if ([iConsole sharedConsole].enabled && event.type == UIEventTypeTouches)
    {
        NSSet *touches = [event allTouches];
        if ([touches count] == (TARGET_IPHONE_SIMULATOR ? [iConsole sharedConsole].simulatorTouchesToShow: [iConsole sharedConsole].deviceTouchesToShow))
        {
            BOOL allUp = YES;
            BOOL allDown = YES;
            BOOL allLeft = YES;
            BOOL allRight = YES;

            for (UITouch *touch in touches)
            {
                if ([touch locationInView:self].y <= [touch previousLocationInView:self].y)
                {
                    allDown = NO;
                }
                if ([touch locationInView:self].y >= [touch previousLocationInView:self].y)
                {
                    allUp = NO;
                }
                if ([touch locationInView:self].x <= [touch previousLocationInView:self].x)
                {
                    allLeft = NO;
                }
                if ([touch locationInView:self].x >= [touch previousLocationInView:self].x)
                {
                    allRight = NO;
                }
            }

            switch ([UIApplication sharedApplication].statusBarOrientation)
            {
                case UIInterfaceOrientationPortrait:
                case UIInterfaceOrientationUnknown:
                {
                    if (allUp)
                    {
                        [iConsole show];
                    }
                    else if (allDown)
                    {
                        [iConsole hide];
                    }
                    break;
                }
                case UIInterfaceOrientationPortraitUpsideDown:
                {
                    if (allDown)
                    {
                        [iConsole show];
                    }
                    else if (allUp)
                    {
                        [iConsole hide];
                    }
                    break;
                }
                case UIInterfaceOrientationLandscapeLeft:
                {
                    if (allRight)
                    {
                        [iConsole show];
                    }
                    else if (allLeft)
                    {
                        [iConsole hide];
                    }
                    break;
                }
                case UIInterfaceOrientationLandscapeRight:
                {
                    if (allLeft)
                    {
                        [iConsole show];
                    }
                    else if (allRight)
                    {
                        [iConsole hide];
                    }
                    break;
                }
            }
        }
    }
#endif
    return [super sendEvent:event];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {

    if ([iConsole sharedConsole].enabled &&
        (TARGET_IPHONE_SIMULATOR ? [iConsole sharedConsole].simulatorShakeToShow: [iConsole sharedConsole].deviceShakeToShow))
    {
        if (event.type == UIEventTypeMotion && event.subtype == UIEventSubtypeMotionShake)
        {
            if ([iConsole sharedConsole].view.superview == nil)
            {
                [iConsole show];
            }
            else
            {
                [iConsole hide];
            }
        }
    }
    [super motionEnded:motion withEvent:event];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
