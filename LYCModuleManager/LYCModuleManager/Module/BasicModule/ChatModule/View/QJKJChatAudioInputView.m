//
//  QJKJChatAudioInputView.m
//  LYCModuleManager
//
//  Created by YouchengLi on 2017/1/5.
//  Copyright © 2017年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import "QJKJChatAudioInputView.h"

#pragma mark - 文本
//正常
#define CHAT_AUDIO_NORM_TEXT @"按住 说话"
//高亮
#define CHAT_AUDIO_HIGHLIGHTED_TEXT @"松开 结束"

@implementation QJKJChatAudioInputView {
    QJKJButton *_audioInputButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _audioInputButton = [QJKJButton buttonWithType:UIButtonTypeCustom];
        _audioInputButton.frame = self.bounds;
        _audioInputButton.backgroundColor = self.backgroundColor;
        _audioInputButton.layer.borderColor = [UIColor blackColor].CGColor;
        _audioInputButton.layer.borderWidth = 0.5;
        
        [_audioInputButton setTitle:CHAT_AUDIO_NORM_TEXT forState:UIControlStateNormal];
        [_audioInputButton setTitle:CHAT_AUDIO_HIGHLIGHTED_TEXT forState:UIControlStateHighlighted];
        [_audioInputButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_audioInputButton addTarget:self action:@selector(clickedDown) forControlEvents:UIControlEventTouchDown];//按下 开始录音
        [_audioInputButton addTarget:self action:@selector(clickedUpInside) forControlEvents:UIControlEventTouchUpInside];//松开 保存录音 并发送
        [_audioInputButton addTarget:self action:@selector(clickedDragOutside) forControlEvents:UIControlEventTouchDragOutside];// 滑出
        [_audioInputButton addTarget:self action:@selector(clickedUpOutside) forControlEvents:UIControlEventTouchUpOutside];// 滑出之后取消 取消录音
        [_audioInputButton addTarget:self action:@selector(clickedDragInside) forControlEvents:UIControlEventTouchDragInside]; //滑入 继续录音
        [self addSubview:_audioInputButton];
    }
    return self;
}


/**
 按下
 */
- (void)clickedDown {
    DLog(@"按下");
}

/**
 松开
 */
- (void)clickedUpInside {
    DLog(@"松开");
}

/**
 滑出
 */
- (void)clickedDragOutside {
    DLog(@"滑出");
}

/**
 滑出后取消
 */
- (void)clickedUpOutside {
    DLog(@"滑出后取消");
}


/**
 滑入
 */
- (void)clickedDragInside {
    DLog(@"滑入");
}




@end
