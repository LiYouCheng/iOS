//
//  QJKJChatImageCell.h
//  LYCModuleManager
//
//  Created by YouchengLi on 2017/1/6.
//  Copyright © 2017年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QJKJChatInfoModel;

typedef void(^QJKJChatImageCellClickBlock)(QJKJImageView *imageView);

@interface QJKJChatImageCell : UITableViewCell

/**
 刷新图片显示

 @param model 数据
 @param clickBlock 点击图片
 */
- (void)refreshUIWithModel:(QJKJChatInfoModel *)model
            withClickBlock:(QJKJChatImageCellClickBlock)clickBlock;


+ (CGSize)imageScaleShow:(UIImage *)image;
@end
