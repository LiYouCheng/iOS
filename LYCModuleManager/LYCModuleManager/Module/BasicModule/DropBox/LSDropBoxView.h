//
//  LSDropBoxView.h
//  LYCModuleManager
//
//  Created by 史ios on 16/12/19.
//  Copyright © 2016年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef int(^LSDropGBoxCountBlock)(void);
typedef NSString*(^LSDropGBoxImageBlock)(NSInteger row);
typedef NSString*(^LSDropGBoxNameBlock)(NSInteger row);
typedef void(^LSDropBoxSelect)(NSInteger row);

@interface LSDropBoxView : UIView

/**
 *  某行的图片名
 */
@property (nonatomic, strong) LSDropGBoxImageBlock imageBlock;
/**
 *  某行的名字
 */
@property (nonatomic, strong) LSDropGBoxNameBlock nameBlock;
/**
 *  多少行
 */
@property (nonatomic, strong) LSDropGBoxCountBlock countBlock;
/**
 *  选择某行
 */
@property (nonatomic, strong) LSDropBoxSelect selectBlock;


#pragma mark 方法

/**
 *  显示下拉框
 *
 */
- (void)showDropBox;

/**
 *  隐藏下拉框
 */
- (void)hiddenDropBox;

@end
