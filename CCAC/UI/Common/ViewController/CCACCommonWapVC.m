//
//  CCACCommonWapVC.m
//  CCAC
//
//  Created by 周文松 on 2017/3/30.
//  Copyright © 2017年 周文松. All rights reserved.
//

#import "CCACCommonWapVC.h"
#import <WebKit/WebKit.h>

NSString *const kReload = @"reload";

/// 支付
#import "CCACWechatPayService.h"

@interface CCACCommonWapVC () <WKNavigationDelegate, WKUIDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) WKWebViewJavascriptBridge* bridge;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) WKUserContentController *userContentController;

@end

@implementation CCACCommonWapVC

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_webView removeObserver:self forKeyPath:@"title"];
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_userContentController removeAllUserScripts];
    [_webView stopLoading];
}

- (instancetype)init {
    if ((self = [super init])) {
    }
    return self;
}

- (WKUserContentController *)userContentController {
    return _userContentController = ({
        WKUserContentController *user = nil;
        if (_userContentController) {
            user = _userContentController;
        } else {
            NSString *jsCookie = [[AppServer server] readJSCookie];
            WKUserScript * cookieScript = [[WKUserScript alloc] initWithSource:jsCookie injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
            user = WKUserContentController.new;
            [user addUserScript:cookieScript];
        }
        user;
    });
}

- (WKWebView *)webView {
    return _webView = ({
        WKWebView *web = nil;
        if (_webView) {
            web = _webView;
        } else {
            
            WKWebViewConfiguration* webViewConfig = WKWebViewConfiguration.new;
            webViewConfig.userContentController = self.userContentController;
            webViewConfig.preferences.javaScriptCanOpenWindowsAutomatically = YES;
            
            NSString *url = nil;
            if ([_linkUrl rangeOfString:kCommentDomain].location == NSNotFound && [_linkUrl rangeOfString:@"http"].location == NSNotFound) {
                url = [kCommentDomain stringByAppendingPathComponent:_linkUrl];
            } else {
                url = _linkUrl;
            }
            NSString *urlStr = url;
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
            // 添加cookie
//            NSString *cookie = [[AppServer server] readCookie];
//            [request addValue:cookie forHTTPHeaderField:@"Cookie"];
            web = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:webViewConfig];
            web.backgroundColor = DDWhiteColor(1);
            web.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            web.allowsBackForwardNavigationGestures = YES;
            web.UIDelegate = self;
            web.navigationDelegate = self;
            // 添加title监听
            [web addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
            // 他添加progress监听
            [web addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
            [web loadRequest:request];
        }
        web;
    });
}

- (UIProgressView *)progressView {
    return _progressView = ({
        UIProgressView *layer = nil;
        if (_progressView) {
            layer = _progressView;
        } else {
            layer = UIProgressView.new;
            layer.frame = CGRectMake(0, 0, DD_ScreenWidth,0);
            layer.tintColor = DDRedColor_f65068;
            layer.trackTintColor = DDClearColor;
            CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 1.3f);
            layer.transform = transform;//设定宽高
        }
        layer;
    });
}

- (void)jsToNative {
    _bridge = [WKWebViewJavascriptBridge bridgeForWebView:_webView];
    [_bridge setWebViewDelegate:self];
    [_bridge registerHandler:@"go_uri" handler:^(id data, WVJBResponseCallback responseCallback) {
      
        if ([data[@"data"][@"url"] rangeOfString:@"index.html"].location == NSNotFound && [data[@"action"] isEqualToString:@"check"] ) {
            [CCACGo pushTestVC];
        } else if ([data[@"action"] isEqualToString:@"buy"]) {
            NSDictionary *dic = data[@"data"];
            CCACWechatPayModel *model = CCACWechatPayModel.new;
            model.partnerid = dic[@"partnerid"];
            model.prepayid = dic[@"prepayid"];
            model.package = @"Sign=WXPay";
            model.noncestr = dic[@"nonceStr"];
            model.timestamp = [dic[@"timeStamp"] intValue];
            model.sign = dic[@"sign"];
            [[CCACWechatPayService service] payOrderWithModel:model complete:^(CCACPayResult result, NSString *resultMessage) {
                if (result == CCACPayResultSuccess) {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [CCACGo popToRootViewController];
                        NSString *orderId = dic[@"orderId"];
                        NSString *linkUrl = [NSString stringWithFormat:@"index.html#orderDetail?orderId=%@",orderId];
                        [CCACGo pushWithParameter:@{@"linkUrl":linkUrl}];
                    });
                } else {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [CCACGo popToRootViewController];
                        [CCACGo pushWithParameter:@{@"linkUrl":@"index.html#orderList?status=0"}];
                    });
                }
            }];
        } else if ([data[@"action"] isEqualToString:@"goBack"]) {
            NSNotificationPost(kReload, nil, nil);
            [self dd_goBack];
        } else if ([data[@"action"] isEqualToString:@"changeFace"]) {
            NSNotificationPost(@"changeFace", nil, nil);
        } else {
            [CCACGo pushWapVCWithClassName:@"CCACCommonWapVC" parameter:@{@"linkUrl":data[@"data"][@"url"]} hidesBottomBarWhenPushed:YES];;
          }
        responseCallback(@"Success!");
    }];
}

- (void)dd_viewWillAppearForTheFirstTime {
    [super dd_viewWillAppearForTheFirstTime];
    NSNotificationAdd(self, reload, kReload, nil);
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    [self jsToNative];    
}

- (void)reload {
    [_webView reload];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"title"]) {
        self.navigationItem.title = _webView.title;
    } else if ([keyPath isEqualToString:@"estimatedProgress"]) {
        
        CGFloat newProgressValue = [change[NSKeyValueChangeNewKey] doubleValue];
        [_progressView setAlpha:1.0f];
        [_progressView setProgress:newProgressValue animated:YES];
        
        if (newProgressValue >= 1) {
            [UIView animateWithDuration:.3 delay:.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [_progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [_progressView setProgress:0.0f animated:NO];
            }];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    DDLog(@"失败 = %@",error);
}

//- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
//    NSString *jsCookie = [[AppServer server] readJSCookie];
//    [webView evaluateJavaScript:jsCookie completionHandler:^(id result, NSError *error) {
//        //...
//    }];
//}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSURL *url = navigationAction.request.URL;
    DDLog(@"%@",url);
    [DDKitHelperObj  consoleInfo:[NSString stringWithFormat:@"\nURL = %@",url]];
    decisionHandler(WKNavigationActionPolicyAllow);
}


- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler;
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:message message:nil delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
    [alert show];
    completionHandler();
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
