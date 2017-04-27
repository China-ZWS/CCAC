//
//  DDCommonDefine.h
//  DDKit
//
//  Created by Song on 16/8/12.
//  Copyright © 2016年 https://github.com/China-ZWS. All rights reserved.
//

#ifndef DDCommonDefine_h
#define DDCommonDefine_h

/**
 * Macro For APP
 */
#pragma mark - APP

#define DD_BUNDLE_OBJFORKEY(_key) [[NSBundle mainBundle] objectForInfoDictionaryKey:_key]
#define DD_APP_NAME DD_BUNDLE_OBJFORKEY(@"CFBundleDisplayName")
#define DD_APP_VERSION DD_BUNDLE_OBJFORKEY(@"CFBundleShortVersionString")
#define DD_APP_BUILD DD_BUNDLE_OBJFORKEY(@"CFBundleVersion")
#define DD_Bundle_PATHFORRESOURCE(_resource,_type) [[NSBundle mainBundle] pathForResource:_resource ofType:_type]
#define DD_Bundle_URLFORRESOURCE(_resource,_type) [[NSBundle mainBundle] URLForResource:_resource withExtension:_type]
#define DD_DirectoryPath(_searchPathDirectory) NSSearchPathForDirectoriesInDomains(_searchPathDirectory, NSUserDomainMask, YES).firstObject
#define DD_Document_Path DD_DirectoryPath(NSDocumentDirectory)
#define DD_Caches_Path DD_DirectoryPath(NSCachesDirectory)
#define DD_Temp_Path NSTemporaryDirectory()
#define DD_URL_Comment(_appId) [NSString stringWithFormat:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&pageNumber=0&sortOrdering=1&type=Purple+Software&mt=8", _appId]

/**
 * Macro For Log
 */
#if DEBUG
#define DDLog(format, ...)do {\
fprintf(stderr, "\n***********************************\n");\
(NSLog)((@"\n"@"输出："format),##__VA_ARGS__);\
fprintf(stderr, "定位：<%s : %d> %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent]UTF8String],__LINE__, __func__);\
fprintf(stderr, "***********************************\n\n");\
} while (0)
#else
#define DDLog(...)
#endif

#define DD_Assert(condition) NSAssert(condition, ([NSString stringWithFormat:@"file name = %s ---> function name = %s at line: %d", __FILE__, __FUNCTION__, __LINE__]));


#pragma mark - Memory Manager

#define DD_Weakify(oriInstance, weakInstance) __weak typeof(oriInstance) weakInstance = oriInstance
#define DD_Strongify(weakInstance, strongInstance) __strong typeof(weakInstance) strongInstance = weakInstance

/**
 *  Macro For Device Info
 */
#pragma mark - Device Info
#define DD_ScreenWidth [UIScreen mainScreen].bounds.size.width
#define DD_ScreenHeight [UIScreen mainScreen].bounds.size.height
#define DD_ScreenScale (1 / [[UIScreen mainScreen] scale])                       //  划 0.5 宽度的线条使用
#define DD_ScreenRatioOfBase DD_ScreenWidth / 320.f
#define DD_isIPad   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define DD_isIPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define DD_isRetinaDevice ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]&&[[UIScreen mainScreen] scale]== 2)
#define DD_isMultiTaskingSupported ([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)] && [[UIDevice currentDevice] isMultitaskingSupported])
#define DD_Device_Name [UIDevice currentDevice].name
#define DD_Device_Model [UIDevice currentDevice].model
#define DD_Device_LocalizedModel [UIDevice currentDevice].localizedModel
#define DD_Device_SystemName [UIDevice currentDevice].systemName
#define DD_Device_SystemVersion [UIDevice currentDevice].systemVersion
#define DD_Device_Type error
#define DD_UDID error

/**
 *  Macro For System Versioning
 */
#pragma mark - System Versioning
#define DD_SYSTEM_VERSION_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define DD_SYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define DD_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define DD_SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define DD_SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#define DD_isiOS8OrAbove DD_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")
#define DD_SYSTEM_VERSION [[UIDevice currentDevice] systemVersion]

/**
 *  UI
 */
#define DD_ApplicationWindow [UIApplication sharedApplication].delegate.window

/**
 * Macro For Color
 */
#pragma mark - Color
#define DDBlackColor(alpha) [[UIColor blackColor] colorWithAlphaComponent:alpha]
#define DDWhiteColor(alpha) [[UIColor whiteColor] colorWithAlphaComponent:alpha]
#define DDClearColor [UIColor clearColor]
#define DDColorName(colorName, alpha) [[UIColor colorName] colorWithAlphaComponent:alpha]
#define DDColorAlpha(color, alpha) [color colorWithAlphaComponent:alpha]
#define DDColorRGB(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define DDColorHex(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:((c)&0xFF)/255.0 alpha:1.0]
#define DDHexColorAlpha(c, a) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:((c)&0xFF)/255.0 alpha:(a)]

#define DDRedColor DDColorHex(0xff3d26)               //!<默认色红颜色
#define DDTextColor DDColorHex(0x333333)              //!<默认正文颜色
#define DDDetailColor DDColorHex(0x606060)            //!<默认辅助文字颜色
#define DDLineColor DDColorHex(0xdedfe0)              //!<默认线条颜色
#define DDAddressTextColor DDColorHex(0xadc0cd)       //!<默认地址文字颜色
#define DDBKColor DDColorHex(0xf3f4f6)                //!<默认背景颜色
#define DDSelectBKColor DDColorRGB(247,248,249)       //!<默认选中背景颜色
#define DDSelectLayerBKColor DDColorAlpha(DDColorRGB(207,208,209),.3)     //!<默认选中背景颜色


#define DDRedColor_f65068 DDColorHex(0xf65068)
/*
  通知
 **/
#define NSNotificationAdd(Server,Sel,Name,Object) [[NSNotificationCenter defaultCenter] addObserver:Server selector:@selector(Sel) name:Name object:Object]
#define NSNotificationPost(name,Object,info) [[NSNotificationCenter defaultCenter] postNotificationName:name object:Object userInfo:info]


/**
 * Macro For Image
 */
#pragma mark - Image
#define DDImageName(imageName) [UIImage imageNamed:imageName]
#define DDLoadImage(file, ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

/**
 * Macro For Font
 */
#pragma mark - Font
#define DDFont(size) [UIFont systemFontOfSize:size]
#define DDBoldFont(size) [UIFont boldSystemFontOfSize:size]
#define DDNameFont(fontName,fontSize) [UIFont fontWithName:fontName size:fontSize]


#endif /* DDCommonDefine_h */
