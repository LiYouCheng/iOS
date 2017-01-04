//
//  QJKJChatInputView.m
//  LYCModuleManager
//
//  Created by 史ios on 2017/1/4.
//  Copyright © 2017年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import "QJKJChatInputView.h"

#import "QJKJChatFaceView.h"
#import "QJKJChatMoreView.h"

#pragma mark - 位置信息
//按钮宽度
#define CHAT_BUTTON_WIDTH 44.f
//左边空隙
#define CHAT_LEFT_SPACE 10.f
//右边空隙
#define CHAT_RIGHT_SPACE 10.f

@interface QJKJChatInputView ()
<UITextViewDelegate>

@property (nonatomic, strong) QJKJChatFaceView *faceView;
@property (nonatomic, strong) QJKJChatMoreView *moreView;
@end

@implementation QJKJChatInputView {
    
    
    QJKJButton      *_audioButton;
    QJKJTextView    *_contentTextView;
    QJKJButton      *_contetnButton;
    QJKJButton      *_emoijButton;
    QJKJButton      *_moreButton;
 
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _audioButton = [QJKJButton buttonWithType:UIButtonTypeCustom];
        _audioButton.frame = CGRectMake(CHAT_LEFT_SPACE, (self.height - CHAT_BUTTON_WIDTH) / 2.0, CHAT_BUTTON_WIDTH, CHAT_BUTTON_WIDTH);
        _audioButton.backgroundColor = [UIColor greenColor];
        [_audioButton setTitle:@"语音" forState:UIControlStateNormal];
        [_audioButton setTitle:@"键盘" forState:UIControlStateSelected];
        [_audioButton addTarget:self action:@selector(clickedAudio:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_audioButton];
        
        _emoijButton = [QJKJButton buttonWithType:UIButtonTypeCustom];
        _emoijButton.frame = CGRectMake(self.width - (CHAT_RIGHT_SPACE + CHAT_BUTTON_WIDTH) - (CHAT_RIGHT_SPACE + CHAT_BUTTON_WIDTH), (self.height - CHAT_BUTTON_WIDTH) / 2.0, CHAT_BUTTON_WIDTH, CHAT_BUTTON_WIDTH);
        _emoijButton.backgroundColor = [UIColor greenColor];
        [_emoijButton setTitle:@"表情" forState:UIControlStateNormal];
        [_emoijButton setTitle:@"键盘" forState:UIControlStateSelected];
        [_emoijButton addTarget:self action:@selector(clickedEmoij:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_emoijButton];
        
        _moreButton = [QJKJButton buttonWithType:UIButtonTypeCustom];
        _moreButton.frame = CGRectMake(_emoijButton.right + CHAT_LEFT_SPACE, (self.height - CHAT_BUTTON_WIDTH) / 2.0, CHAT_BUTTON_WIDTH, CHAT_BUTTON_WIDTH);
        [_moreButton setTitle:@"更多" forState:UIControlStateNormal];
        [_moreButton setTitle:@"键盘" forState:UIControlStateSelected];
        _moreButton.backgroundColor = [UIColor greenColor];
        [_moreButton addTarget:self action:@selector(clickedMore:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_moreButton];
        
        _contentTextView = [[QJKJTextView alloc] initWithFrame:CGRectMake(_audioButton.right + CHAT_LEFT_SPACE, (self.height - CHAT_BUTTON_WIDTH) / 2.0, (_emoijButton.left - CHAT_LEFT_SPACE) - (_audioButton.right + CHAT_LEFT_SPACE), CHAT_BUTTON_WIDTH)];
        _contentTextView.backgroundColor = [UIColor purpleColor];
        _contentTextView.delegate = self;
        _contentTextView.placeholder = @"请输入聊天内容";
        _contentTextView.inputView = nil;
        [self addSubview:_contentTextView];
        
        _contetnButton = [QJKJButton buttonWithType:UIButtonTypeCustom];
        _contetnButton.frame = _contentTextView.frame;
        _contetnButton.backgroundColor = _contentTextView.backgroundColor;
        [_contetnButton addTarget:self action:@selector(clickedTextView) forControlEvents:UIControlEventTouchUpInside];
        _contetnButton.hidden = YES;
        [self addSubview:_contetnButton];
    }
    return self;
}

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    DLog(@"将开始编辑");
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    DLog(@"将结束编辑");
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    DLog(@"变化");
}

#pragma mark - 按钮事件

- (void)clickedAudio:(UIButton *)btn {
    
    btn.selected = !btn.selected;
    _emoijButton.selected = NO;
    _moreButton.selected = NO;
    
    
}

- (void)clickedEmoij:(UIButton *)btn {
    
    _contetnButton.hidden = NO;
    
    btn.selected = !btn.selected;
    _audioButton.selected = NO;
    _moreButton.selected = NO;
    
    [_contentTextView setInputView:self.faceView];
    [_contentTextView reloadInputViews];
}

- (void)clickedMore:(UIButton *)btn {
    
    _contetnButton.hidden = NO;
    
    btn.selected = !btn.selected;
    _audioButton.selected = NO;
    _emoijButton.selected = NO;
    
    [_contentTextView setInputView:self.moreView];
    [_contentTextView reloadInputViews];
}

- (void)clickedTextView {
    
    _audioButton.selected = NO;
    _emoijButton.selected = NO;
    _moreButton.selected = NO;
    
    [_contentTextView setInputView:nil];
    [_contentTextView reloadInputViews];
    
    _contetnButton.hidden = YES;
}

#pragma mark - getters or setters

- (QJKJChatFaceView *)faceView {
    if (!_faceView) {
        _faceView = [[QJKJChatFaceView alloc] init];
    }
    return _faceView;
}

- (QJKJChatMoreView *)moreView {
    if (!_moreView) {
        _moreView = [[QJKJChatMoreView alloc] init];
    }
    return _moreView;
}

@end
