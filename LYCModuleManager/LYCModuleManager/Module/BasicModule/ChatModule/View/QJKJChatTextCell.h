//
//  QJKJChatTextCell.h
//  LYCModuleManager
//
//  Created by YouchengLi on 2017/1/6.
//  Copyright © 2017年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QJKJChatInfoModel;
@interface QJKJChatTextCell : UITableViewCell

/**
 刷新文本和表情显示
 
 @param model 数据
 */
- (void)refreshUIWithModel:(QJKJChatInfoModel *)model;

@end
