//
//  LYCAppConfigMacro.h
//  LYCModuleManager
//
//  Created by YouchengLi on 2016/12/19.
//  Copyright © 2016年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#ifndef LYCAppConfigMacro_h
#define LYCAppConfigMacro_h

#pragma mark - 位置相关

//屏幕宽
#define QJKJ_WIDTH [UIScreen mainScreen].bounds.size.width

//屏幕高
#define QJKJ_HEIGHT [UIScreen mainScreen].bounds.size.height

//状态栏高度
#define QJKJ_STATUSBAR_HEIGHT 20.f

//导航条高度
#define QJKJ_NAVBAR_HEIGHT 44.f

//导航条和状态栏总共高度
#define QJKJ_STATUS_NAV_HEIGHT 64.f

//标签栏高度
#define QJKJ_TABBAR_HEIGHT 50.f

// 缩放
#define QJKJ_SCALE (DWIDTH == 375?(375.f/320):(DWIDTH == 414?414.f/320:1.0))

#pragma mark - 输出相关

//自定义输出信息
#ifndef __OPTIMIZE__
#   define DLog(fmt, ...) NSLog((@"%s [File %s: Line %d] " fmt), __PRETTY_FUNCTION__, __FILE__, __LINE__, ##__VA_ARGS__)
#   define ELog(err) {if(err) DLog(@"%@", err);}
#else
#   define DLog(...)
#endif

#pragma mark - 系统相关

//获取版本
#define VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//ios版本
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

#endif /* LYCAppConfigMacro_h */
