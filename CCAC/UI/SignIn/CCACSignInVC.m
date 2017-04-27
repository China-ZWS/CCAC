//
//  CCACSignInVC.m
//  CCAC
//
//  Created by 周文松 on 2017/3/28.
//  Copyright © 2017年 周文松. All rights reserved.
//

#import "CCACSignInVC.h"

// task
#import "CCACSignInTask.h"

#import "CCACSocialHelper.h"


#define btnHeight     DDLayoutIphone6Pixels(40)
#define btnTitleFont  DDLayoutIphone6Pixels(17)

@interface CCACSignInVC ()

@property (nonatomic, strong) UIImageView *logoImgView;
@property (nonatomic, strong) UIButton *wechatLoginBtn;
@property (nonatomic, strong) UIButton *visitorLoginBtn;

@end

@implementation CCACSignInVC

- (void)dealloc {

}

- (BOOL)dd_isNaviBarHidden {return YES;}

- (UIImageView *)logoImgView {
    return _logoImgView = ({
        UIImageView *view = nil;
        if (_logoImgView) {
            view = _logoImgView;
        } else {
            view = UIImageView.new;
            view.image = DDImageName(@"home_icon_ccac_logo");
            view.translatesAutoresizingMaskIntoConstraints = NO;
            view.dd_size = CGSizeMake(DDLayoutIphone6Pixels(view.image.size.width), DDLayoutIphone6Pixels(view.image.size.height));
            view.dd_centerX = DD_ScreenWidth / 2;
            view.dd_centerY = DD_ScreenHeight / 2 - view.image.size.height * 1 / 3;
        }
        view;
    });
}

- (UIButton *)visitorLoginBtn {
    return _visitorLoginBtn = ({
        UIButton *btn = nil;
        if (_visitorLoginBtn) {
            btn = _visitorLoginBtn;
        } else {
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake((DD_ScreenWidth - self.view.dd_width * 3 / 4) / 2, DD_ScreenHeight - DDLayoutIphone6Pixels(50) -  btnHeight, self.view.dd_width * 3 / 4, btnHeight);
            btn.layer.cornerRadius = btn.dd_height / 2;
            btn.backgroundColor = CCACRedColor;
            [btn setTitle:NSLocalizedString(@"CCACSignInVC.visitorLoginBtnTitle",nil) forState:UIControlStateNormal];
            btn.titleLabel.font = DDFont(btnTitleFont);
            [btn addTarget:self action:@selector(onClickWithVisitorLogin) forControlEvents:UIControlEventTouchUpInside];
            UIImageView *icon = UIImageView.new;
            icon.image = DDImageName(@"main_more_personal_icon");
            icon.frame = CGRectMake( btn.dd_height / 4, (btn.dd_height - DDLayoutIphone6Pixels(icon.image.size.height)) / 2, DDLayoutIphone6Pixels(icon.image.size.width), DDLayoutIphone6Pixels(icon.image.size.height));
            [btn addSubview:icon];
        }
        btn;
    });
}

- (UIButton *)wechatLoginBtn {
    return _wechatLoginBtn = ({
        UIButton *btn = nil;
        if (_wechatLoginBtn) {
            btn = _wechatLoginBtn;
        } else {
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(_visitorLoginBtn.dd_left, _visitorLoginBtn.dd_top - DDLayoutIphone6Pixels(30) - _visitorLoginBtn.dd_height, _visitorLoginBtn.dd_width, _visitorLoginBtn.dd_height);
            btn.layer.cornerRadius = btn.dd_height / 2;
            btn.backgroundColor = CCACRedColor;
            [btn setTitle:NSLocalizedString(@"CCACSignInVC.wechatLoginBtnTitle",nil) forState:UIControlStateNormal];
            btn.titleLabel.font = DDFont(btnTitleFont);
            [btn addTarget:self action:@selector(onClickWithWechatLogin) forControlEvents:UIControlEventTouchUpInside];
            UIImageView *icon = UIImageView.new;
            icon.image = DDImageName(@"wechat_icon");
            icon.frame = CGRectMake( btn.dd_height / 4, (btn.dd_height - DDLayoutIphone6Pixels(icon.image.size.height)) / 2, DDLayoutIphone6Pixels(icon.image.size.width), DDLayoutIphone6Pixels(icon.image.size.height));
            [btn addSubview:icon];

        }
        btn;
    });
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.logoImgView];
    [self.view addSubview:self.visitorLoginBtn];
    [self.view addSubview:self.wechatLoginBtn];
    // Do any additional setup after loading the view.
    
}

- (void)onClickWithVisitorLogin {
    [self.view progressWithText:NSLocalizedString(@"progress.logging",nil)];
    NSMutableDictionary *datas = NSMutableDictionary.new;
    datas[@"type"] = @"visitor";
    datas[@"unionid"] = kVisitorUniqid();
    [CCACSignInTask taskWithParameters:datas block:^(CCACSignInResponse *response) {
        if (DDValidResponse(response)) {
            [[AppServer server] configSignInModel:response.data];
            [[AppServer server] setCookies];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.view successWithText:NSLocalizedString(@"loginSuccess.title",nil)];
                [self close];
            });
        } else if (response.msg.length > 0) {
            [self.view errorWithText:response.msg];
        } else {
            [self.view errorWithText:kUnknownErrorTips];
        }
    }];
}

- (void)onClickWithWechatLogin {
    [CCACSocialHelper loginWithType:LoginWeixin presentingController:self block:^(NSError *error, CCACSocialModel *model){
        if (error) {
            [self.view errorWithText:@"登录失败"];
        } else {
            [self.view progressWithText:NSLocalizedString(@"progress.logging",nil)];
            NSDictionary *data = [model yy_modelToJSONObject];
            [CCACSignInTask taskWithParameters:data block:^(CCACSignInResponse *response) {
                if (DDValidResponse(response)) {
                    [[AppServer server] configSignInModel:response.data];
                    [[AppServer server] setCookies];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.view successWithText:NSLocalizedString(@"loginSuccess.title",nil)];
                        [self close];
                    });
                } else if (response.msg.length > 0) {
                    [self.view errorWithText:response.msg];
                } else {
                    [self.view errorWithText:kUnknownErrorTips];
                }
            }];
        }
    }];
}

- (void)close {
    CATransition *transition = [CATransition animation];
    transition.duration =0.4;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromBottom;
    [DD_ApplicationWindow.layer addAnimation:transition forKey:nil];
    DD_ApplicationWindow.rootViewController = [[NSClassFromString(@"CCACNavigationVC") alloc] initWithRootViewController:[NSClassFromString(@"CCACMainVC") new]];
}

- (void)dd_viewWillAppearForTheFirstTime {
    [super dd_viewWillAppearForTheFirstTime];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
