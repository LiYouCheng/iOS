//
//  QJKJNetworkingRequest.h
//  weiGuanJia
//
//  Created by YouchengLi on 2016/12/12.
//  Copyright © 2016年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AFNetworking.h>

//请求成功
typedef void (^QJKJFinishBlock)(NSDictionary *dict);
//请求失败
typedef void (^QJKJFailedBlock)(NSError *error);
//网络失败
typedef void (^QJKJExitNetwork)(NSError *error);

@interface QJKJNetworkingRequest : NSObject

/**
 初始化
 
 @param urlStr url地址
 @return 对象
 */
- (QJKJNetworkingRequest *)initWithURLString:(NSString *)urlStr;

#pragma mark - 设置部分

/**
 普通参数设置
 
 @param value 值
 @param key 关键字
 */
- (void)setPostValue:(NSString *)value forKey:(NSString *)key;


/**
 文件参数设置
 
 @param filePath 值
 @param key 关键字
 */
- (void)setFile:(NSString *)filePath forKey:(NSString *)key;

#pragma mark - 请求部分

/**
 开始Post请求
 
 @param finish 完成
 @param fail 失败
 @param netWorkStatus 网络异常
 */
- (void)startPostAsynchronousWithFinish:(QJKJFinishBlock)finish
                                 failed:(QJKJFailedBlock)fail
                           networkExist:(QJKJExitNetwork)netWorkStatus;

/**
 开始Get请求
 
 @param finish 成功
 @param fail 失败
 @param netWorkStatus 网络异常
 */
- (void)startGetAsynchronousWithFinish:(QJKJFinishBlock)finish
                                failed:(QJKJFailedBlock)fail
                          networkExist:(QJKJExitNetwork)netWorkStatus;

/**
 取消网络网络请求
 */
- (void)cancelAllOperations;

/**
 监测网络状态
 
 @return 成功yes
 */
+ (BOOL)checkNetworkConnection;

@end
