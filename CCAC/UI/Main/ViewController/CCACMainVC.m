//
//  CCACMainVC.m
//  CCAC
//
//  Created by 周文松 on 2017/3/29.
//  Copyright © 2017年 周文松. All rights reserved.
//

#import "CCACMainVC.h"

// moreView
#import "CCACMainMoreManger.h"
#import "CCACMainMoreView.h"

// banner
#import "DDBanner.h"

// view
#import "CCACMainContentView.h"

// task
#import "CCACBannerTask.h"
#import "CCACUserInfoTask.h"

#define kBannerHeight   DDLayoutIphone6Pixels(530/2.f)

@interface CCACMainVC () <DDBannerDelegate>

@property (nonatomic, strong) CCACMainMoreView *moreListView;
@property (nonatomic, strong) DDBanner *banner;
@property (nonatomic, strong) CCACMainContentView *contentView;
@property (nonatomic, strong) NSArray *bannerDatas;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation CCACMainVC

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype) init {
    if ((self = [super init])) {
        [self.navigationItem dd_addBarButtonWithType:DDNavigationBarItemType_Left target:self action:@selector(onclickWithMore) normalImage:DDImageName(@"nav_more_icon") highlightedImage:DDImageName(@"nav_more_icon") needsClear:YES];
        [self.navigationItem dd_addBarButtonWithType:DDNavigationBarItemType_Right target:self action:@selector(onclickWithSearch) normalImage:DDImageName(@"nav_search_icon") highlightedImage:DDImageName(@"nav_search_icon") needsClear:YES];
        UIImageView *titleView = UIImageView.new;
        titleView.image = DDImageName(@"nav_ccac_logo");
        titleView.dd_size = titleView.image.size;
        self.navigationItem.titleView = titleView;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)dd_viewWillAppearForTheFirstTime {
    [super dd_viewWillAppearForTheFirstTime];
    NSNotificationAdd(self, changeFace, @"changeFace", nil);
    [self.view addSubview:self.banner];
    [self.view addSubview:self.contentView];
    [self startRequest];
}

- (void)startRequest {
    
    NSArray *langs = [[NSUserDefaults standardUserDefaults] valueForKey:@"AppleLanguages"];
    NSString *language = [langs.firstObject componentsSeparatedByString:@"-"].firstObject;
    [CCACBannerTask taskWithLang:language block:^(CCACBannerResponse *response) {
        _pageControl.numberOfPages = [response.data count];
        _pageControl.currentPage = 0;
        self.bannerDatas = response.data;
        [_banner configBanner:response.data];
    }];
    
    
    [CCACUserInfoTask taskWithToken:kUserToken() menber_id:[NSString stringWithFormat:@"%zd",[AppServer server].menberModel.id] block:^(CCACUserInfoResponse *response) {
        CCACSignInModel *model = CCACSignInModel.new;
        model.token = kUserToken();
        model.member = response.data;
        [[AppServer server] configSignInModel:model];
    }];
}

- (void)changeFace {
    [CCACUserInfoTask taskWithToken:kUserToken() menber_id:[NSString stringWithFormat:@"%zd",[AppServer server].menberModel.id] block:^(CCACUserInfoResponse *response) {
        CCACSignInModel *model = CCACSignInModel.new;
        model.token = kUserToken();
        model.member = response.data;
        [[AppServer server] configSignInModel:model];
        [self.moreListView  moreViewRefreshHeadImg];
    }];
}

#pragma mark - initUI

- (UITableView *)moreListView {
    return _moreListView = ({
        CCACMainMoreView *tab = nil;
        if (_moreListView) {
            tab = _moreListView;
        } else {
            DD_Weakify(self, safeSelf);
            tab = [[CCACMainMoreView alloc] initWithFrame:CGRectMake(0, 0, 0, self.view.dd_height)];
            tab.selected = ^(NSInteger row, NSString *linkUrl){
                if (row == 5) {
                    [CCACGo pushLanguageVC];
                } else if (row == 6) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",kServicePhone]]];
                } else if (row == 7) {
                    [safeSelf eventWithSignOut];
                } else if (row != 8){
                    [CCACGo pushWithParameter:@{@"linkUrl":linkUrl}];
                }
            };
        }
        tab;
    });
}

- (UIPageControl *)pageControl {
    return _pageControl = ({
        UIPageControl *page = nil;
        if (_pageControl) {
            page = _pageControl;
        } else {
            page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, kBannerHeight - 25, DD_ScreenWidth, 20)];
        }
        page;
    });
}

- (DDBanner *)banner {
    return _banner = ({
        DDBanner *view = nil;
        if (_banner) {
            view = _banner;
        } else {
            view = [[DDBanner alloc] initWithFrame:CGRectMake(0, 0, DD_ScreenWidth, kBannerHeight) canLoop:YES duration:3.f];
            view.delegate = self;
            view.scrollDirection = DDBannerScrollDirectionHorizontal;
            view.addPageControl(self.pageControl);
        }
        view;
    });
}

- (CCACMainContentView *)contentView {
    return _contentView = ({
        CCACMainContentView *view = nil;
        if (_contentView) {
            view = _contentView;
        } else {
            view = CCACMainContentView.new;
            view.frame = CGRectMake(0, _banner.dd_bottom, self.view.dd_width, self.view.dd_height - _banner.dd_bottom);
            view.selected = ^(NSInteger index){
                if (index == 0) {
                    [CCACGo pushTestVC];
                } else if (index == 1) {
                    [CCACGo pushWithParameter:@{@"linkUrl":@"index.html#index"}];
                } else if (index == 2) {
                    [CCACGo pushWithParameter:@{@"linkUrl":@"index.html#argentina"}];
                } else {
                    [CCACGo pushWithParameter:@{@"linkUrl":@"index.html#aboutUs"}];
                }
            };
        }
        view;
    });
}

#pragma mark - event

- (void)onclickWithMore {
    [CCACMainMoreManger showMenuAddSubView:self.moreListView toView:self.view];
}

- (void)onclickWithSearch {
    [CCACGo pushWithParameter:@{@"linkUrl":@"index.html#search"}];
}

- (void)eventWithSignOut {
    
    [[AppServer server] clearType];
    CATransition *transition = [CATransition animation];
    transition.duration =0.4;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    [DD_ApplicationWindow.layer addAnimation:transition forKey:nil];
    DD_ApplicationWindow.rootViewController = [[UINavigationController alloc] initWithRootViewController:[NSClassFromString(@"CCACSignInVC") new]];
}

#pragma mark - bannerDelegate

- (void)imageView:(UIImageView *)imageView loadImageForData:(id)data {
    if ([data isKindOfClass:[CCACBannerModel class]]) {
        CCACBannerModel *model = (CCACBannerModel *)data;
        [imageView dd_setImageWithUrl:model.url placeholder:DDImageName(@"rc_h_placeholder")];
    }
}

- (void)bannerView:(DDBanner *)bannerView didSelectAtIndex:(NSUInteger)index {
    CCACBannerModel *model = self.bannerDatas[index];
    [CCACGo pushWithParameter:@{@"linkUrl":[NSString stringWithFormat:@"index.html#article?articleId=%zd",model.article_id]}];
}

- (void)bannerView:(DDBanner *)bannerView currentPageAtIndex:(NSInteger)currentPageAtIndex {
    _pageControl.currentPage = currentPageAtIndex;
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
