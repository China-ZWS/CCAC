//
//  DDScanVC.m
//  RetailClient
//
//  Created by Song on 16/12/28.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#import "DDScanVC.h"
#import <AVFoundation/AVFoundation.h>

#import "SystemFunctions.h"

// layer
#import "DDScanLayer.h"

@interface DDScanVC ()<AVCaptureMetadataOutputObjectsDelegate>//用于处理采集信息的代理

@property (nonatomic, strong) AVCaptureDeviceInput *deviceInput;            //!< 输入流
@property (nonatomic, strong) AVCaptureMetadataOutput *output;              //!< 输出流
@property (strong, nonatomic) AVCaptureSession *session;                    //!< 输入输出中间桥梁(会话)
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;     //!< 预览图层
@property (nonatomic, strong) UIButton *lampBtn;                            //!< 灯泡
@property (strong, nonatomic) AVAudioPlayer *beepPlayer;                    //!< 音频

// view
@property (nonatomic, strong) DDScanLayer *drawLayer;

@end

@implementation DDScanVC

- (instancetype)init
{
    if ((self = [super init])) {
        self.title = @"二维码/条形码";
    }
    return self;
}

- (void)dd_goBack{
    [CCACGo dismissToRootViewControllerWithCompletion:NULL];
}

//- (AVAudioPlayer *)beepPlayer
//{
//    return _beepPlayer = ({
//        AVAudioPlayer *player = nil;
//        if (_beepPlayer) {
//            player = _beepPlayer;
//        } else {
//
//
//            NSString * wavPath = [[NSBundle mainBundle] pathForResource:@"beep" ofType:@"wav"];
//            NSData* data = [[NSData alloc] initWithContentsOfFile:wavPath];
//            player = [[AVAudioPlayer alloc] initWithData:data error:nil];
//        }
//        player;
//    });
//}


#pragma mark - 创建输入流

- (AVCaptureDeviceInput *)deviceInput
{
    return _deviceInput = ({
        AVCaptureDeviceInput *input = nil;
        if (_deviceInput) {
            input = _deviceInput;
        } else {
            // 获取摄像设备
            AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
            input = [[AVCaptureDeviceInput alloc] initWithDevice:device error:nil];
        }
        input;
    });
}

#pragma mark - 创建输出流

- (AVCaptureMetadataOutput *)output
{
    return _output = ({
        AVCaptureMetadataOutput * op= nil;
        if (_output) {
            op = _output;
        } else {
            op = AVCaptureMetadataOutput.new;

        }
        op;
    });
    return _output;
}

#pragma mark - 会话层

- (AVCaptureSession *)session
{
    return _session = ({
        AVCaptureSession *ss = nil;
        if (_session) {
            ss = _session;
        } else {
            //初始化链接对象
            ss = AVCaptureSession.new;
            //高质量采集率
            [ss setSessionPreset:AVCaptureSessionPresetHigh];
        }
        ss;
    });
}

#pragma mark - 创建预览图层

- (AVCaptureVideoPreviewLayer *)previewLayer
{
    return _previewLayer = ({
        AVCaptureVideoPreviewLayer *layer = nil;
        if (_previewLayer) {
            layer = _previewLayer;
        } else {
            layer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
            layer.frame = [UIScreen mainScreen].bounds;
        }
        layer;
    });
}

#pragma mark - 创建用于绘制边线的图层

- (CALayer *)drawLayer
{
    return _drawLayer = ({
        DDScanLayer *layer = nil;
        if (_drawLayer) {
            layer = _drawLayer;
        } else {
            layer = DDScanLayer.new;
            layer.frame = self.view.bounds;
        }
        layer;
    });
}

- (void)startScan
{
    // 1.判断是否能够将输入添加到会话中
    if (![self.session canAddInput:self.deviceInput]) {
        return;
    }

    // 2.判断是否能够将输出添加到会话中
    if (![self.session canAddOutput:self.output]) {
        return;
    }

    // 3.将输入和输出都添加到会话中
    [_session addInput:_deviceInput];
    [_session addOutput:_output];

    // 4 注意: 设置能够解析的数据类型, 一定要在输出对象添加到会员之后设置, 否则会报错
    _output.metadataObjectTypes = _output.availableMetadataObjectTypes;
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];

    // 5.添加预览图层
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];

    // 添加绘制图层
    [_previewLayer addSublayer:self.drawLayer];


    CGFloat ScreenHigh = CGRectGetHeight(_previewLayer.frame);
    CGFloat ScreenWidth = CGRectGetWidth(_previewLayer.frame);

    _output.rectOfInterest = CGRectMake(((self.view.dd_height - [DDScanLayer lineWidth]) / 2 - [DDScanLayer titleHeight]) / ScreenHigh,(self.view.dd_width - [DDScanLayer lineWidth]) / 2 / ScreenWidth , [DDScanLayer lineWidth] / ScreenHigh, [DDScanLayer lineWidth] / ScreenWidth);

    //开始捕获
    [_session startRunning];

}

- (UIButton *)lampBtn
{
    return _lampBtn = ({
        UIButton *btn = nil;
        if (_lampBtn) {
            btn = _lampBtn;
        } else {
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:DDImageName(@"DDScan.bundle/turn_on") forState:UIControlStateNormal];
            [btn setImage:DDImageName(@"DDScan.bundle/turn_off") forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(lampClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.frame = CGRectMake((self.view.dd_width - btn.currentImage.size.width) / 2, (self.view.dd_height - [DDScanLayer lineWidth]) / 2 + [DDScanLayer lineWidth], btn.currentImage.size.width, btn.currentImage.size.height);
        }
        btn;
    });
}

- (void)dd_viewWillAppearForTheFirstTime
{
    [super dd_viewWillAppearForTheFirstTime];

    [self.view addSubview:self.lampBtn];

    [self startScan];

    // 开始动画
    [_drawLayer startAnimation];
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    // 0.清空图层
    [_drawLayer clearCorners];

    if (metadataObjects.count == 0 || metadataObjects == nil) {
        return;
    }


    // 1.获取扫描到的数据
    // 注意: 要使用stringValue

    //判断是否有数据
        if (metadataObjects != nil && [metadataObjects count] > 0) {
            AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects lastObject];
            //判断回传的数据类型
//            [[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode] && 
            if ([metadataObj isKindOfClass:[AVMetadataMachineReadableCodeObject class]]) {

                // 扫描结果
                NSString *result = [metadataObjects.lastObject stringValue];
                // 停止扫描
                [self stopScan];

                [SystemFunctions openShake:YES Sound:YES];

                if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
                    if (_completionWithQRCodeBlock) {
                        [self dismissViewControllerAnimated:YES completion:^{
                            _completionWithQRCodeBlock(result);
                        }];
                    }
                } else {
                    if (_completionWithOtherCodeBlock) {
                        [self dismissViewControllerAnimated:YES completion:^{
                            _completionWithOtherCodeBlock(result);
                        }];
                    }
                }


    //            if (self.delegate && [self.delegate respondsToSelector:@selector(reader:didScanResult:)]) {
    //                [self.delegate reader:self didScanResult:result];
    //            }
                return;
            }
        }


    // 2.获取扫描到的二维码的位置
    // 2.1转换坐标
    for (AVMetadataObject *object in metadataObjects) {

        // 2.1.1判断当前获取到的数据, 是否是机器可识别的类型
        if ([object isKindOfClass:[AVMetadataMachineReadableCodeObject class]]) {
            // 2.1.2将坐标转换界面可识别的坐标
            AVMetadataMachineReadableCodeObject *codeObject = (AVMetadataMachineReadableCodeObject *)[_previewLayer transformedMetadataObjectForMetadataObject:object];
            // 2.1.3绘制图形
            [_drawLayer drawCorners:codeObject];
        }
    }
}

- (void)stopScan
{
    // 结束动画
    [_drawLayer stopAnimation];
    if (_session.running) {
        [_session stopRunning];
    }
}


-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self stopScan];
}

- (void)lampClick:(UIButton *)button
{
    button.selected = !button.selected;
    [SystemFunctions openLight:button.selected];
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
