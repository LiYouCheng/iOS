//
//  UIColor+QJKJHelper.h
//  LYCModuleManager
//
//  Created by 史ios on 16/12/19.
//  Copyright © 2016年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (QJKJHelper)

/**
 *  16进制字符串转颜色
 *
 *  @param color 16进制字符串
 *
 *  @return 颜色
 */
+ (UIColor *)colorWithHexString: (NSString *)color;

/**
 *  透明状态
 *
 *  @return 透明
 */
+ (UIColor *)colorForClear;

@end
