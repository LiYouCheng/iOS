//
//  QJKJDateShareHelper.m
//  weiGuanJia
//
//  Created by YouchengLi on 2016/11/30.
//  Copyright © 2016年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import "QJKJDateShareHelper.h"

static NSString *kDefaultFormat = @"yyyy-MM-dd HH:mm:ss";

@implementation QJKJDateShareHelper

+ (NSDateFormatter *)shareDate {
    static NSDateFormatter *dateShare = nil;
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        dateShare = [[NSDateFormatter alloc] init];
        [dateShare setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
        [dateShare setDateFormat:kDefaultFormat];
    });
    
    return dateShare;
}

#pragma mark - 字符串转时间

/**
 字符串转时间，且使用默认格式

 @param 时间字符串

 @return 字符串
 */
+ (NSDate *)qjkjDateFromString:(NSString *)string {
    return [QJKJDateShareHelper qjkjDateFromString:string withFormatString:nil];
}

/**
 字符串转时间

 @param string 字符串
 @param format 格式字符串

 @return 字符串
 */
+ (NSDate *)qjkjDateFromString:(NSString *)string
          withFormatString:(NSString *)format {
    if (!string) {
        return nil;
    }
    
    if (format) {
        [[QJKJDateShareHelper shareDate] setDateFormat:format];
    }
    
    return [[QJKJDateShareHelper shareDate] dateFromString:string];
}

#pragma mark - 时间转字符串

/**
 当前时间转字符串，且使用默认格式

 @return 字符串
 */
+ (NSString *)qjkjStringFromCurrentDate {
    return [QJKJDateShareHelper qjkjStringFromDate:[NSDate date] withFormatString:kDefaultFormat];
}

/**
 时间转字符串

 @param date   时间
 @param format 格式字符串

 @return 字符串
 */
+ (NSString *)qjkjStringFromDate:(NSDate *)date
            withFormatString:(NSString *)format {
    if (!date) {
        return @"";
    }
    
    if (format) {
        [[QJKJDateShareHelper shareDate] setDateFormat:format];
    }
    
    return [[QJKJDateShareHelper shareDate] stringFromDate:date];
}

@end
