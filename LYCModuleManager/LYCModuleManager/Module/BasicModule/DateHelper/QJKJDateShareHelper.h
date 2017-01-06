//
//  QJKJDateShareHelper.h
//  weiGuanJia
//
//  Created by YouchengLi on 2016/11/30.
//  Copyright © 2016年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QJKJDateShareHelper : NSObject

+ (NSDateFormatter *)shareDate;

#pragma mark - 字符串转时间

/**
 字符串转时间，且使用默认格式
 
 @param 时间字符串
 
 @return 字符串
 */
+ (NSDate *)qjkjDateFromString:(NSString *)string;

/**
 字符串转时间
 
 @param string 字符串
 @param format 格式字符串
 
 @return 字符串
 */
+ (NSDate *)qjkjDateFromString:(NSString *)string
              withFormatString:(NSString *)format;

#pragma mark - 时间转字符串

/**
 当前时间转字符串，且使用默认格式
 
 @return 字符串
 */
+ (NSString *)qjkjStringFromCurrentDate;

/**
 时间转字符串
 
 @param date   时间
 @param format 格式字符串
 
 @return 字符串
 */
+ (NSString *)qjkjStringFromDate:(NSDate *)date
                withFormatString:(NSString *)format;

@end
