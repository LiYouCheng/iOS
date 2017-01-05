//
//  QJKJChatAudioInputView.m
//  LYCModuleManager
//
//  Created by YouchengLi on 2017/1/5.
//  Copyright © 2017年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import "QJKJChatAudioInputView.h"


#import "QJKJRecordAudio.h"

#pragma mark - 文本
//正常
#define CHAT_AUDIO_NORM_TEXT @"按住 说话"
//高亮
#define CHAT_AUDIO_HIGHLIGHTED_TEXT @"松开 结束"

#pragma mark - 位置信息

//屏幕高度
#define CHAT_SCREEN_HEIGTH [UIScreen mainScreen].bounds.size.height
//屏幕宽度
#define CHAT_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width


//提示背景图片高度
#define CHAT_AUDIO_TIP_BACKGROUN_HEIGHT 160.f
//提示音量图片高度
#define CHAT_AUDIO_TIP_VOLUME_HEIGHT 76.f
//提示音量图片宽度
#define CHAT_AUDIO_TIP_VOLUME_WIDTH 24.f

@interface QJKJChatAudioInputView ()
<QJKJRecordAudioDelegate>
@property (nonatomic, strong) QJKJRecordAudio *recordAudio;

@end

@implementation QJKJChatAudioInputView {
    QJKJButton *_audioInputButton;
    QJKJView *_alphaView;
    QJKJImageView *_contentImageView;
    QJKJImageView *_volumeImageView;
    QJKJView *_volumeView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _audioInputButton = [QJKJButton buttonWithType:UIButtonTypeCustom];
        _audioInputButton.frame = self.bounds;
        _audioInputButton.backgroundColor = self.backgroundColor;
        _audioInputButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _audioInputButton.layer.borderWidth = 0.5;
        _audioInputButton.layer.cornerRadius = 5;
        _audioInputButton.layer.masksToBounds = YES;
        _audioInputButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
        
        [_audioInputButton setTitle:CHAT_AUDIO_NORM_TEXT forState:UIControlStateNormal];
        [_audioInputButton setTitle:CHAT_AUDIO_HIGHLIGHTED_TEXT forState:UIControlStateHighlighted];
        [_audioInputButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        [_audioInputButton addTarget:self action:@selector(clickedDown) forControlEvents:UIControlEventTouchDown];//按下 开始录音
        [_audioInputButton addTarget:self action:@selector(clickedUpInside) forControlEvents:UIControlEventTouchUpInside];//松开 保存录音 并发送
        [_audioInputButton addTarget:self action:@selector(clickedDragOutside) forControlEvents:UIControlEventTouchDragOutside];// 滑出
        [_audioInputButton addTarget:self action:@selector(clickedUpOutside) forControlEvents:UIControlEventTouchUpOutside];// 滑出之后取消 取消录音
        [_audioInputButton addTarget:self action:@selector(clickedDragInside) forControlEvents:UIControlEventTouchDragInside]; //滑入 继续录音
        [self addSubview:_audioInputButton];
        
        [self creatAudioTipView];
    }
    return self;
}


#pragma mark - QJKJRecordAudioDelegate

- (void)recordAudioSound:(float)percentage {

    CGFloat height = CHAT_AUDIO_TIP_VOLUME_HEIGHT * percentage;
    DLog(@"height = %f",height);
    
    _volumeImageView.top = 30 + CHAT_AUDIO_TIP_VOLUME_HEIGHT - height;
    _volumeImageView.height = height;
    
}


/**
 创建语音提示view
 */
- (void)creatAudioTipView {
    _alphaView = [[QJKJView alloc] initWithFrame:CGRectMake((CHAT_SCREEN_WIDTH - CHAT_AUDIO_TIP_BACKGROUN_HEIGHT) / 2.0, (CHAT_SCREEN_HEIGTH - CHAT_AUDIO_TIP_BACKGROUN_HEIGHT) / 2.0, CHAT_AUDIO_TIP_BACKGROUN_HEIGHT, CHAT_AUDIO_TIP_BACKGROUN_HEIGHT)];
    _alphaView.backgroundColor = [UIColor blackColor];
    _alphaView.alpha = 0.3;
    
    _contentImageView = [[QJKJImageView alloc] initWithFrame:_alphaView.frame];
    
    _volumeImageView = [[QJKJImageView alloc] initWithFrame:CGRectMake(_contentImageView.width / 2.0 + 10, 30, CHAT_AUDIO_TIP_VOLUME_WIDTH, CHAT_AUDIO_TIP_VOLUME_HEIGHT)];
    _volumeImageView.image = [UIImage imageNamed:@"chat_audio_tip_volum"];
//    _volumeImageView.backgroundColor = [UIColor redColor];
    _volumeImageView.contentMode = UIViewContentModeBottom;
    _volumeImageView.clipsToBounds = YES;
    [_contentImageView addSubview:_volumeImageView];
}


/**
 按下
 */
- (void)clickedDown {
    DLog(@"按下");
    
    [[UIApplication sharedApplication].keyWindow addSubview:_alphaView];
    [[UIApplication sharedApplication].keyWindow addSubview:_contentImageView];
    
    _contentImageView.image = [UIImage imageNamed:@"chat_audio_tip_norm"];
    
    //开始录音
    [self.recordAudio startRecord];
}

/**
 松开
 */
- (void)clickedUpInside {
    DLog(@"松开");
    
    [_alphaView removeFromSuperview];
    [_contentImageView removeFromSuperview];
    
    
    NSDictionary *dict = [self.recordAudio finishRecord];
    DLog(@"dict = %@",dict);
    
}

/**
 滑出
 */
- (void)clickedDragOutside {
    DLog(@"滑出");
    
   _contentImageView.image = [UIImage imageNamed:@"chat_audio_tip_cancel"];
    

}

/**
 滑出后取消
 */
- (void)clickedUpOutside {
    DLog(@"滑出后取消");
    
    _contentImageView.image = [UIImage imageNamed:@"chat_audio_tip_short"];
    
    [UIView animateWithDuration:2 animations:^{
        
    } completion:^(BOOL finished) {
        [_alphaView removeFromSuperview];
        [_contentImageView removeFromSuperview];
        
        //取消录音
        [self.recordAudio cancelRecord];
    }];
}

/**
 滑入
 */
- (void)clickedDragInside {
    DLog(@"滑入");
    
    _contentImageView.image = [UIImage imageNamed:@"chat_audio_tip_norm"];

}

#pragma mark - getters or setters

- (QJKJRecordAudio *)recordAudio {
    if (!_recordAudio) {
        _recordAudio = [[QJKJRecordAudio alloc] init];
        _recordAudio.delegate = self;
    }
    return _recordAudio;
}


@end
