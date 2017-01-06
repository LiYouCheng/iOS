//
//  QJKJNetworkingRequest.m
//  weiGuanJia
//
//  Created by YouchengLi on 2016/12/12.
//  Copyright © 2016年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import "QJKJNetworkingRequest.h"

#import <AFNetworking.h>
#import <AFNetworkActivityIndicatorManager.h>

//是否存在网络
#import <netinet/in.h>

//是否打印相关信息
#define IS_SHOW_LOG_MESSAGE true

static NSString *networkErrorMessage = @"网络不给力";

@interface QJKJNetworkingRequest ()

@end

@implementation QJKJNetworkingRequest {
    NSString *_urlString;//url地址
    NSMutableDictionary *_postDataMDictionary;//普通参数字典
    NSMutableDictionary *_postFileMDictionary;//文件参数字典
    AFHTTPSessionManager *_requestManager;//请求
}

#pragma mark - CustomMethond

/**
  初始化

 @param urlStr url地址
 @return 对象
 */
- (QJKJNetworkingRequest *)initWithURLString:(NSString *)urlStr
{
    self = [super init];
    
    if (self) {
        _urlString = urlStr;
        _postDataMDictionary = [NSMutableDictionary dictionary];
        _postFileMDictionary = [NSMutableDictionary dictionary];
        _requestManager = [AFHTTPSessionManager manager];
        
        //设置必传参数
        [self mustPostParameters];
    }
    return self;
}

#pragma mark - 设置部分

/**
 设置必传参数
 */
- (void)mustPostParameters {
    //系统信息
//    NSString *devToken = [QJKJUserDefaults objectNormForKey:USER_UNIQUE_ID_SAVE];
//    [self setPostValue:devToken forKey:@"pid"];
//    [self setPostValue:@"ios" forKey:@"phonetype"];
//    [self setPostValue:VERSION forKey:@"appversion"];
//    
//    //必传参数
//    //小区id
//    if ([QJKJSharedUserInformation returnVillageId]) {
//        [self setPostValue:[QJKJSharedUserInformation returnVillageId] forKey:@"teid"];
//    }else{
//        [self setPostValue:@"0" forKey:@"teid"];
//    }
//    
//    //用户id
//    if ([QJKJSharedUserInformation returnMid]) {
//        [self setPostValue:[QJKJSharedUserInformation returnMid] forKey:@"mid2"];
//    }else{
//        [self setPostValue:@"0" forKey:@"mid2"];
//    }
//    
//    //其它参数
//    //用户id
//    if ([[QJKJSharedUserInformation returnMid] length] > 0) {
//        [self setPostValue:[QJKJSharedUserInformation returnMid] forKey:@"mid"];
//    }
//    else {
//        [self setPostValue:@"0" forKey:@"mid"];
//    }
//    
//    //小区id
//    if ([QJKJSharedUserInformation returnVillageId]) {
//        [self setPostValue:[QJKJSharedUserInformation returnVillageId] forKey:@"eid"];
//    }else{
//        [self setPostValue:@"0" forKey:@"eid"];
//    }
//    
//    //小区城市
//    if ([QJKJSharedUserInformation returnVillageCity]) {
//        [self setPostValue:[QJKJSharedUserInformation returnVillageCity] forKey:@"city"];
//    }else{
//        [self setPostValue:@"0" forKey:@"city"];
//    }
//    
//    //用户手机
//    if ([[QJKJSharedUserInformation returnUserid] length] > 0) {
//        [self setPostValue:[QJKJSharedUserInformation returnUserid] forKey:@"userid"];
//    }
//    else {
//        [self setPostValue:@"0" forKey:@"userid"];
//    }
}

/**
 普通参数设置

 @param value 值
 @param key 关键字
 */
- (void)setPostValue:(NSString *)value forKey:(NSString *)key
{
    if (!key) {
        return;
    }
    if (!value) {
        value = @"";
    }
    
    _postDataMDictionary[key] = value;
}


/**
 文件参数设置

 @param filePath 值
 @param key 关键字
 */
- (void)setFile:(NSString *)filePath forKey:(NSString *)key
{
    if (!key) {
        return;
    }
    if (!filePath) {
        return;
    }
    
    _postFileMDictionary[key] = filePath;
}


/**
 post请求设置
 */
- (void)postRequestSet {

    //设置请求证书，暂设置无
    _requestManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    _requestManager.securityPolicy.allowInvalidCertificates = YES;
    
    //设置网络超时 60秒
    [_requestManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    _requestManager.requestSerializer.timeoutInterval = 60.f;
    [_requestManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    //设置接收类型
    [_requestManager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", nil]];
    _requestManager.responseSerializer = [AFHTTPResponseSerializer serializer];
}

/**
 get请求设置
 */
- (void)getRequestSet {

    //接收类型
    _requestManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", nil];
    _requestManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //设置网络超时
    [_requestManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    _requestManager.requestSerializer.timeoutInterval = 10.f;
    [_requestManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
}

#pragma mark - 请求部分

/**
 开始Post请求
 
 @param finish 完成
 @param fail 失败
 @param netWorkStatus 网络异常
 */
- (void)startPostAsynchronousWithFinish:(QJKJFinishBlock)finish
                                 failed:(QJKJFailedBlock)fail
                           networkExist:(QJKJExitNetwork)netWorkStatus {
    [self postRequestSet];
    
    if (![QJKJNetworkingRequest checkNetworkConnection])
    {
//        [QJKJProgressHUD_SV showInfoWithStatus:networkErrorMessage];
        if (netWorkStatus)
        {
            NSError *error = [NSError errorWithDomain:networkErrorMessage code:-10000 userInfo:nil];
            netWorkStatus(error);
            return;
        }
    } else {
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
        [[AFNetworkActivityIndicatorManager sharedManager] incrementActivityCount];
    }
    
    //开始网络请求
    
    [_requestManager POST:_urlString parameters:_postDataMDictionary constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (_postFileMDictionary.count > 0)
        {
            NSArray *keyArray = [_postFileMDictionary allKeys];
            for (int i = 0; i < keyArray.count; i++)
            {
                NSString *strFileName = [_postFileMDictionary[keyArray[i]] lastPathComponent];
                
                [formData appendPartWithFileData:[NSData dataWithContentsOfFile:_postFileMDictionary[keyArray[i]]] name:keyArray[i] fileName:strFileName mimeType:@"image/png"];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:NO];
        
        if (![dic isKindOfClass:[NSDictionary class]])
        {
            dic = nil;
            NSString *errorStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            DLog(@"非 NSDictionary 类型 %@",errorStr);
        }
        finish(dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:NO];
        
        if (IS_SHOW_LOG_MESSAGE)
        {
            NSLog(@"-请求地址------:%@",_urlString);
            NSLog(@"-参数------:%@",_postDataMDictionary);
            NSLog(@"-参数File------:%@",_postFileMDictionary);
        }
        fail(error);
    }];

}

/**
 开始Get请求

 @param finish 成功
 @param fail 失败
 @param netWorkStatus 网络异常
 */
- (void)startGetAsynchronousWithFinish:(QJKJFinishBlock)finish
                                failed:(QJKJFailedBlock)fail
                          networkExist:(QJKJExitNetwork)netWorkStatus {

    //网络监测
    if (![QJKJNetworkingRequest checkNetworkConnection])
    {
//        [QJKJProgressHUD_SV showInfoWithStatus:networkErrorMessage];
        if (netWorkStatus)
        {
            NSError *error = [NSError errorWithDomain:networkErrorMessage code:-10000 userInfo:nil];
            netWorkStatus(error);
            return;
        }
    } else {
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
        [[AFNetworkActivityIndicatorManager sharedManager] incrementActivityCount];
    }
    
    //开始网络请求
    [_requestManager GET:_urlString parameters:_postDataMDictionary success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:NO];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (![dic isKindOfClass:[NSDictionary class]])
        {
            dic = nil;
            NSString *errorStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            DLog(@"非 NSDictionary 类型 %@",errorStr);
        }
        finish(dic);
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:NO];
        
        if (IS_SHOW_LOG_MESSAGE)
        {
            NSLog(@"-请求地址------:%@",_urlString);
            NSLog(@"-参数------:%@",_postDataMDictionary);
            NSLog(@"-参数File------:%@",_postFileMDictionary);
        }
        fail(error);
    }];
}


/**
 取消网络网络请求
 */
- (void)cancelAllOperations {
    [_requestManager.operationQueue cancelAllOperations];
}

/**
 监测网络状态

 @return 成功yes
 */
+ (BOOL)checkNetworkConnection
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags) {
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

@end
