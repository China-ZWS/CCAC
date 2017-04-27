//
//  CCACTestVC.m
//  CCAC
//
//  Created by 周文松 on 2017/3/31.
//  Copyright © 2017年 周文松. All rights reserved.
//

#import "CCACTestVC.h"


#define kBack_title_topLb_textFontSize     DDLayoutIphone6Pixels(20.f)
#define kBack_title_bottomLb_textFontSize  DDLayoutIphone6Pixels(15.f)
#define kSubmitBtnHeight                   DDLayoutIphone6Pixels(50.f)
#define kSubmitBtnTextFontSize             DDLayoutIphone6Pixels(17.f)

@interface CCACTestVC ()

@property (nonatomic, strong) UIImageView *backView;
@property (nonatomic, strong) UILabel *back_title_topLb;
@property (nonatomic, strong) UILabel *back_title_bottomLb;
@property (nonatomic, strong) UIImageView *back_iconView;
@property (nonatomic, strong) UIButton *submitBtn;

@end

@implementation CCACTestVC

- (instancetype)init {
    if ((self = [super init])) {
        self.title = NSLocalizedString(@"CCACTestVC.title",nil);
    }
    return self;
}

#pragma mark - init UI

- (UIImageView *)backView {
    return _backView = ({
        UIImageView *view = nil;
        if (_backView) {
            view = _backView;
        } else {
            view = UIImageView.new;
            view.contentMode = UIViewContentModeScaleAspectFit;
            view.image = DDImageName(@"test_back");
            view.frame = CGRectMake(0, 0, DDLayoutIphone6Pixels(view.image.size.width), DDLayoutIphone6Pixels(view.image.size.height));
        }
        view;
    });
}

- (UILabel *)back_title_topLb {
    return _back_title_topLb = ({
        UILabel *lb = nil;
        if (_back_title_topLb) {
            lb = _back_title_topLb;
        } else {
            lb = UILabel.new;
            lb.frame = CGRectMake(DDLayoutIphone6Pixels(20), DDLayoutIphone6Pixels(20), self.view.dd_width - DDLayoutIphone6Pixels(40), 0);
            lb.numberOfLines = 0;
            lb.font = DDBoldFont(kBack_title_topLb_textFontSize);
            lb.text = NSLocalizedString(@"CCACTestVC.back_title_top",nil);
            lb.textColor = DDWhiteColor(1);
            [lb sizeToFit];
        }
        lb;
    });
}

- (UILabel *)back_title_bottomLb {
    return _back_title_bottomLb = ({
        UILabel *lb = nil;
        if (_back_title_bottomLb) {
            lb = _back_title_bottomLb;
        } else {
            lb = UILabel.new;
            lb.frame = CGRectMake(_back_title_topLb.dd_left, _back_title_topLb.dd_bottom + DDLayoutIphone6Pixels(20), self.view.dd_width - DDLayoutIphone6Pixels(40), 0);
            lb.numberOfLines = 0;
            lb.font = DDFont(kBack_title_bottomLb_textFontSize);
            lb.text = NSLocalizedString(@"CCACTestVC.back_title_bottom",nil);
            lb.textColor = DDWhiteColor(1);
            [lb sizeToFit];
        }
        lb;
    });
}

- (UIButton *)submitBtn {
    return _submitBtn = ({
        UIButton *btn = nil;
        if (_submitBtn) {
            btn = _submitBtn;
        } else {
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, self.view.dd_height - kSubmitBtnHeight, self.view.dd_width, kSubmitBtnHeight);
            btn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
            [btn setTitle:NSLocalizedString(@"CCACTestVC.testText",nil) forState:UIControlStateNormal];
            [btn setTitleColor:DDTextColor forState:UIControlStateNormal];
            btn.titleLabel.font = DDFont(kSubmitBtnTextFontSize);
            [btn addTarget:self action:@selector(onclickWithSubmit) forControlEvents:UIControlEventTouchUpInside];
            btn.backgroundColor = DDWhiteColor(1);
        }
        btn;
    });
}

- (void)dd_viewWillAppearForTheFirstTime {
    [super dd_viewWillAppearForTheFirstTime];
    [self.view addSubview:self.backView];
    [self.view addSubview:self.back_title_topLb];
    [self.view addSubview:self.back_title_bottomLb];
    [self.view addSubview:self.submitBtn];
}

- (void)onclickWithSubmit {
    [CCACGo gotoScanWithCompletionWithQRCodeBlock:^(NSString *result) {
        [CCACGo pushWapVCWithClassName:@"CCACCommonWapVC" parameter:@{@"linkUrl":result} hidesBottomBarWhenPushed:YES];;
    } completionWithOtherCodeBlock:^(NSString *result) {
        
    }];
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
