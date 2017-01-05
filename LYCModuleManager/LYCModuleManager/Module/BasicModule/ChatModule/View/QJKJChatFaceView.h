//
//  QJKJChatFaceView.h
//  LYCModuleManager
//
//  Created by 史ios on 2017/1/4.
//  Copyright © 2017年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

// --表情键盘

#import "QJKJView.h"

@protocol QJKJChatFaceViewDelegate <NSObject>

/**
 插入表情

 @param emoji 表情字符串
 */
- (void)insertEmoji:(NSString *)emoji;


/**
 删除表情
 */
- (void)deleteEmoji;


/**
 发送内容
 */
- (void)sendContent;

@end

@interface QJKJChatFaceView : QJKJView

@property (nonatomic, weak) id<QJKJChatFaceViewDelegate> delegate;

//表情键盘高度
#define CHAT_FACE_INPUT_HEIGHT 190.f

@end
