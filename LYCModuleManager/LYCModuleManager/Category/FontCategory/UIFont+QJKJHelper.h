//
//  UIFont+QJKJHelper.h
//  LYCModuleManager
//
//  Created by 史ios on 16/12/19.
//  Copyright © 2016年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (QJKJHelper)

#pragma mark - 正常字体

/**
 *  28号正常字体对应UI的56
 *
 *  @return 字体
 */
+ (UIFont *)fontFor56;

/**
 *  26号正常字体对应UI的52
 *
 *  @return 字体
 */
+ (UIFont *)fontFor52;

/**
 *  24号正常字体对应UI的48
 *
 *  @return 字体
 */
+ (UIFont *)fontFor48;

/**
 *  22号正常字体对应UI的44
 *
 *  @return 字体
 */
+ (UIFont *)fontFor44;

/**
 *  20号正常字体对应UI的40
 *
 *  @return 字体
 */
+ (UIFont *)fontFor40;

/**
 *  18号正常字体对应UI的36
 *
 *  @return 字体
 */
+ (UIFont *)fontFor36;

/**
 *  16号正常字体对应UI的32
 *
 *  @return 字体
 */
+ (UIFont *)fontFor32;

/**
 *  15号正常字体对应UI的30
 *
 *  @return 字体
 */
+ (UIFont *)fontFor30;

/**
 *  14号正常字体对应UI的28
 *
 *  @return 字体
 */
+ (UIFont *)fontFor28;

/**
 *  15号正常字体对应UI的26
 *
 *  @return 字体
 */
+ (UIFont *)fontFor26;

/**
 *  12号正常字体对应UI的24
 *
 *  @return 字体
 */
+ (UIFont *)fontFor24;

/**
 *  10号正常字体对应UI的20
 *
 *  @return 字体
 */
+ (UIFont *)fontFor20;

#pragma mark - 加粗字体

/**
 *  28号加粗字体对应UI的56
 *
 *  @return 字体
 */
+ (UIFont *)boldFontFor56;

/**
 *  26号加粗字体对应UI的52
 *
 *  @return 字体
 */
+ (UIFont *)boldFontFor52;

/**
 *  24号加粗字体对应UI的48
 *
 *  @return 字体
 */
+ (UIFont *)boldFontFor48;

/**
 *  22号加粗字体对应UI的44
 *
 *  @return 字体
 */
+ (UIFont *)boldFontFor44;

/**
 *  20号加粗字体对应UI的40
 *
 *  @return 字体
 */
+ (UIFont *)boldFontFor40;

/**
 *  18号加粗字体对应UI的36
 *
 *  @return 字体
 */
+ (UIFont *)boldFontFor36;
/**
 *  16号加粗字体对应UI的32
 *
 *  @return 字体
 */
+ (UIFont *)boldFontFor32;

/**
 *  15号加粗字体对应UI的30
 *
 *  @return 字体
 */
+ (UIFont *)boldFontFor30;

/**
 *  14号加粗字体对应UI的28
 *
 *  @return 字体
 */
+ (UIFont *)boldFontFor28;

/**
 *  15号加粗字体对应UI的26
 *
 *  @return 字体
 */
+ (UIFont *)boldFontFor26;

/**
 *  12号加粗字体对应UI的24
 *
 *  @return 字体
 */
+ (UIFont *)boldFontFor24;

/**
 *  10号加粗字体对应UI的20
 *
 *  @return 字体
 */
+ (UIFont *)boldFontFor20;

#pragma mark - 基础

/**
 *  正常字体
 *
 *  @param fontSize 字体大小
 *
 *  @return 字体
 */
+ (UIFont *)qjkjNormFontOfSize:(CGFloat)fontSize;

/**
 *  加粗字体
 *
 *  @param fontSize 字体大小
 *
 *  @return 字体
 */
+ (UIFont *)qjkjBoldFontOfSize:(CGFloat)fontSize;

@end
