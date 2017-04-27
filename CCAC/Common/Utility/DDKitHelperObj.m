//
//  DDKitHelperObj .m
//  DDKit
//
//  Created by Song on 16/8/15.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//



#import "DDKitHelperObj.h"
#import "iConsole.h"


@interface DDKitHelperObj ()<iConsoleDelegate>

@property (nonatomic, assign) BOOL consoleEnabled;  ///<是否开启 console，4个手指滑动显示。默认是隐藏的
@property (nonatomic, weak) id<DDConsoleDelegate> consoleDelegate;  ///<console delegate

@end

@implementation DDKitHelperObj

+ (DDKitHelperObj *)obj
{
    static DDKitHelperObj *obj;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[DDKitHelperObj alloc] init];
    });
    return obj;
}

#pragma mark - Console

+ (void)consoleEnabled:(BOOL)enabled withConsoleDelegate:(id<DDConsoleDelegate>)delegate
{
    [DDKitHelperObj obj].consoleEnabled = enabled;
    [DDKitHelperObj obj].consoleDelegate = delegate;
}

- (void)setConsoleEnabled:(BOOL)consoleEnabled
{
    _consoleEnabled = consoleEnabled;

    iConsole *_console = [iConsole sharedConsole];

    if (_consoleEnabled) {

        _console.delegate = self;
        _console.deviceShakeToShow = NO;
        _console.simulatorShakeToShow = NO;
        _console.deviceTouchesToShow = 3;
        _console.simulatorTouchesToShow = 0;
        _console.enabled = YES;
    } else {
        _console.enabled = NO;
    }

}

+ (void)consoleInfo:(NSString *)info
{
    if (info) {
        [iConsole info:info, nil];
    }
}

#pragma mark - iConsoleDelegate

- (void)handleConsoleCommand:(NSString *)command
{
    if (_consoleDelegate && [_consoleDelegate respondsToSelector:@selector(handleCommand:)]) {
        NSString *value = [_consoleDelegate handleCommand:command];
        if (value) {
            [iConsole info:value, nil];
        }
    }
}



@end
