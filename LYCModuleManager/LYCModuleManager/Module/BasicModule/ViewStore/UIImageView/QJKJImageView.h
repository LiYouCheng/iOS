//
//  QJKJImageView.h
//  LYCModuleManager
//
//  Created by 史ios on 16/12/19.
//  Copyright © 2016年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QJKJImageView;
typedef void(^QJKJImageViewClickBlock)(QJKJImageView *imageView);

@interface QJKJImageView : UIImageView

@property (nonatomic, copy) QJKJImageViewClickBlock clickBlock;
@property (nonatomic, assign) BOOL isClick;//是否能够点击


@end
