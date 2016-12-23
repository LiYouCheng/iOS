//
//  LSDateSelectView.h
//  LYCModuleManager
//
//  Created by YouchengLi on 2016/12/22.
//  Copyright © 2016年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^QJKJDateSelectViewFinishBlock)(NSInteger timeInterval);

@interface LSDateSelectView : UIView

#pragma mark - 配置相关

/**
 点击确定获取返回值
 */
@property (nonatomic, copy) QJKJDateSelectViewFinishBlock sureBlock;

/**
 最小时间限制 格式2016-01-01
 */
@property (nonatomic, copy) NSString *minDateString;

/**
 最大时间限制 格式2016-01-01
 */
@property (nonatomic, copy) NSString *maxDateString;

#pragma mark - 显示相关

/**
 显示时间
 */
- (void)showDate;

/**
 隐藏时间
 */
- (void)hiddenDate;

@end
