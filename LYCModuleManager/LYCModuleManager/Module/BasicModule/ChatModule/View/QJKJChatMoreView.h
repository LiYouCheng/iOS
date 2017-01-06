//
//  QJKJChatMoreView.h
//  LYCModuleManager
//
//  Created by 史ios on 2017/1/4.
//  Copyright © 2017年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

// --更多键盘

#import "QJKJView.h"

@protocol QJKJChatMoreViewDelegate <NSObject>

/**
 选择图片完成

 @param image 图片
 */
- (void)selectImageFinish:(UIImage *)image;

@end

@interface QJKJChatMoreView : QJKJView

@property (nonatomic, weak) id<QJKJChatMoreViewDelegate> delegate;

@end
