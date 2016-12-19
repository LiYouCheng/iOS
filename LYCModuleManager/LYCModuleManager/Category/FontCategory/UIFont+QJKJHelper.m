//
//  UIFont+QJKJHelper.m
//  LYCModuleManager
//
//  Created by 史ios on 16/12/19.
//  Copyright © 2016年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import "UIFont+QJKJHelper.h"

static CGFloat font56 = 28.f;
static CGFloat font52 = 26.f;
static CGFloat font48 = 24.f;
static CGFloat font44 = 22.f;
static CGFloat font40 = 20.f;
static CGFloat font36 = 18.f;
static CGFloat font32 = 16.f;
static CGFloat font30 = 15.f;
static CGFloat font28 = 14.f;
static CGFloat font26 = 13.f;
static CGFloat font24 = 12.f;
static CGFloat font20 = 10.f;

@implementation UIFont (QJKJHelper)

#pragma mark - 正常字体

/**
 *  28号正常字体对应UI的56
 *
 *  @return 字体
 */
+ (UIFont *)fontFor56 {
    return [UIFont qjkjNormFontOfSize:font56];
}

/**
 *  26号正常字体对应UI的52
 *
 *  @return 字体
 */
+ (UIFont *)fontFor52 {
    return [UIFont qjkjNormFontOfSize:font52];
}

/**
 *  24号正常字体对应UI的48
 *
 *  @return 字体
 */
+ (UIFont *)fontFor48 {
    return [UIFont qjkjNormFontOfSize:font48];
}

/**
 *  22号正常字体对应UI的44
 *
 *  @return 字体
 */
+ (UIFont *)fontFor44 {
    return [UIFont qjkjNormFontOfSize:font44];
}

/**
 *  20号正常字体对应UI的40
 *
 *  @return 字体
 */
+ (UIFont *)fontFor40 {
    return [UIFont qjkjNormFontOfSize:font40];
}

/**
 *  18号正常字体对应UI的36
 *
 *  @return 字体
 */
+ (UIFont *)fontFor36 {
    return [UIFont qjkjNormFontOfSize:font36];
}

/**
 *  16号正常字体对应UI的32
 *
 *  @return 字体
 */
+ (UIFont *)fontFor32 {
    return [UIFont qjkjNormFontOfSize:font32];
}

/**
 *  15号正常字体对应UI的30
 *
 *  @return 字体
 */
+ (UIFont *)fontFor30 {
    return [UIFont qjkjNormFontOfSize:font30];
}

/**
 *  14号正常字体对应UI的28
 *
 *  @return 字体
 */
+ (UIFont *)fontFor28 {
    return [UIFont qjkjNormFontOfSize:font28];
}

/**
 *  15号正常字体对应UI的26
 *
 *  @return 字体
 */
+ (UIFont *)fontFor26 {
    return [UIFont qjkjNormFontOfSize:font26];
}

/**
 *  12号正常字体对应UI的24
 *
 *  @return 字体
 */
+ (UIFont *)fontFor24 {
    return [UIFont qjkjNormFontOfSize:font24];
}

/**
 *  10号正常字体对应UI的20
 *
 *  @return 字体
 */
+ (UIFont *)fontFor20 {
    return [UIFont qjkjNormFontOfSize:font20];
}

#pragma mark - 加粗字体

/**
 *  28号加粗字体对应UI的56
 *
 *  @return 字体
 */
+ (UIFont *)boldFontFor56 {
    return [UIFont qjkjBoldFontOfSize:font56];
}

/**
 *  26号加粗字体对应UI的52
 *
 *  @return 字体
 */
+ (UIFont *)boldFontFor52 {
    return [UIFont qjkjBoldFontOfSize:font52];
}

/**
 *  24号加粗字体对应UI的48
 *
 *  @return 字体
 */
+ (UIFont *)boldFontFor48 {
    return [UIFont qjkjBoldFontOfSize:font48];
}

/**
 *  22号加粗字体对应UI的44
 *
 *  @return 字体
 */
+ (UIFont *)boldFontFor44 {
    return [UIFont qjkjBoldFontOfSize:font44];
}

/**
 *  20号加粗字体对应UI的40
 *
 *  @return 字体
 */
+ (UIFont *)boldFontFor40 {
    return [UIFont qjkjBoldFontOfSize:font40];
}

/**
 *  18号加粗字体对应UI的36
 *
 *  @return 字体
 */
+ (UIFont *)boldFontFor36 {
    return [UIFont qjkjBoldFontOfSize:font36];
}

/**
 *  16号加粗字体对应UI的32
 *
 *  @return 字体
 */
+ (UIFont *)boldFontFor32 {
    return [UIFont qjkjBoldFontOfSize:font32];
}

/**
 *  15号加粗字体对应UI的30
 *
 *  @return 字体
 */
+ (UIFont *)boldFontFor30 {
    return [UIFont qjkjBoldFontOfSize:font30];
}

/**
 *  14号加粗字体对应UI的28
 *
 *  @return 字体
 */
+ (UIFont *)boldFontFor28 {
    return [UIFont qjkjBoldFontOfSize:font28];
}

/**
 *  15号加粗字体对应UI的26
 *
 *  @return 字体
 */
+ (UIFont *)boldFontFor26 {
    return [UIFont qjkjBoldFontOfSize:font26];
}

/**
 *  12号加粗字体对应UI的24
 *
 *  @return 字体
 */
+ (UIFont *)boldFontFor24 {
    return [UIFont qjkjBoldFontOfSize:font24];
}

/**
 *  10号加粗字体对应UI的20
 *
 *  @return 字体
 */
+ (UIFont *)boldFontFor20 {
    return [UIFont qjkjBoldFontOfSize:font20];
}

#pragma mark - 基础

/**
 *  正常字体
 *
 *  @param fontSize 字体大小
 *
 *  @return 字体
 */
+ (UIFont *)qjkjNormFontOfSize:(CGFloat)fontSize {
    UIFont *font = [UIFont fontWithName:@".SFUIText-Regular" size:fontSize];
    return font;
}

/**
 *  加粗字体
 *
 *  @param fontSize 字体大小
 *
 *  @return 字体
 */
+ (UIFont *)qjkjBoldFontOfSize:(CGFloat)fontSize {
    UIFont *font = [UIFont fontWithName:@".SFUIText-Semibold" size:fontSize];
    return font;
}

//font-family: ".SFUIText-Semibold"; font-weight: bold; font-style: normal; font-size: 14.00pt

//font-family: ".SFUIText-Regular"; font-weight: normal; font-style: normal; font-size: 14.00pt


@end
