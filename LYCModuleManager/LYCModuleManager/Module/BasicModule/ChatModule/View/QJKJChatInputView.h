//
//  QJKJChatInputView.h
//  LYCModuleManager
//
//  Created by 史ios on 2017/1/4.
//  Copyright © 2017年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

// --输入

#import "QJKJView.h"

@class QJKJChatFaceView;
@class QJKJChatMoreView;

typedef enum : NSUInteger {
    QJKJChatInputSystem = 1,//系统
    QJKJChatInputEmoji,//表情
    QJKJChatInputMore,//更多
    QJKJChatInputNone,//无
} QJKJChatInputType;


typedef void(^QJKJChatInputViewSendAudioBlock)(NSString *audioString);
typedef void(^QJKJChatInputViewSendTextBlock)(NSString *text);
typedef void(^QJKJChatInputViewSendImageBlock)(UIImage *image);


@protocol QJKJChatInputViewDelegate <NSObject>

- (void)inputViewHeightChage:(CGFloat)height;

- (void)showChatHeight:(CGFloat)height
              withType:(QJKJChatInputType)type;

- (void)hiddenChatHeightType:(QJKJChatInputType)type;

@end

@interface QJKJChatInputView : QJKJView

@property (nonatomic, weak) id<QJKJChatInputViewDelegate> delegate;


/**
 发送文本块
 */
@property (nonatomic, copy) QJKJChatInputViewSendTextBlock sendTextBlock;

/**
 发送语音块
 */
@property (nonatomic, copy) QJKJChatInputViewSendAudioBlock sendAuidoBlock;

/**
 发送图片块
 */
@property (nonatomic, copy) QJKJChatInputViewSendImageBlock sendImageBlock;

/**
 表情键盘
 */
@property (nonatomic, strong) QJKJChatFaceView *faceView;
/**
 更多键盘
 */
@property (nonatomic, strong) QJKJChatMoreView *moreView;

/**
 隐藏键盘
 */
- (void)hiddenKeyboard;

@end
