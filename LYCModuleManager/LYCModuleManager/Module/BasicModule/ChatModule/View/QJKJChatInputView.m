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

#import "QJKJChatAudioInputView.h"

#pragma mark - 位置信息
//按钮宽度
#define CHAT_BUTTON_WIDTH 44.f
//左边空隙
#define CHAT_LEFT_SPACE 0.f
//右边空隙
#define CHAT_RIGHT_SPACE 0.f

//输入框距离顶部距离
#define CHAT_TEXTVIEW_TOP 10

//输入工具最小高度
#define CHAT_INPUT_HEIGHT_MIN 50.f
//输入工具最大高度
#define CHAT_INPUT_HEIGHT_MAX 90.f


//更多键盘高度
#define CHAT_MORE_INPUT_HEIGHT 190.f

#pragma mark - 图片
//语音图片
#define CHAT_AUDIO_IMAGE @"chat_audio"
//键盘图片
#define CHAT_KEYBOARD_IMAGE @"chat_keyboard"
//表情图片
#define CHAT_EMOJI_IMAGE @"chat_emoji"
//更多图片
#define CHAT_MORE_IMAGE @"chat_more"

#pragma mark - 提示信息
//输入框提示文字
#define CHAT_PLACEHOLDER_TEXT @"请输入聊天内容"

@interface QJKJChatInputView ()
<UITextViewDelegate,
QJKJChatFaceViewDelegate>


@end

@implementation QJKJChatInputView {
    
    
    QJKJButton      *_audioButton;//语音
    QJKJTextView    *_contentTextView;//输入框
    QJKJButton      *_contentButton;//输入框按钮
    QJKJButton      *_emojiButton;//表情
    QJKJButton      *_moreButton;//更多
    QJKJChatAudioInputView *_audioInputView;//语音输入
    
    QJKJChatInputType _currentInputType;//当前输入类型
    
    NSArray *_emojiArray;//表情源
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        

        _audioButton = [QJKJButton buttonWithType:UIButtonTypeCustom];
        _audioButton.frame = CGRectMake(CHAT_LEFT_SPACE, (self.height - CHAT_BUTTON_WIDTH) / 2.0, CHAT_BUTTON_WIDTH, CHAT_BUTTON_WIDTH);
        [_audioButton setImage:[UIImage imageNamed:CHAT_AUDIO_IMAGE] forState:UIControlStateNormal];
        [_audioButton setImage:[UIImage imageNamed:CHAT_KEYBOARD_IMAGE] forState:UIControlStateSelected];
        [_audioButton addTarget:self action:@selector(clickedAudio:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_audioButton];
        
        _emojiButton = [QJKJButton buttonWithType:UIButtonTypeCustom];
        _emojiButton.frame = CGRectMake(self.width - (CHAT_RIGHT_SPACE + CHAT_BUTTON_WIDTH) - (CHAT_RIGHT_SPACE + CHAT_BUTTON_WIDTH), (self.height - CHAT_BUTTON_WIDTH) / 2.0, CHAT_BUTTON_WIDTH, CHAT_BUTTON_WIDTH);
        [_emojiButton setImage:[UIImage imageNamed:CHAT_EMOJI_IMAGE] forState:UIControlStateNormal];
        [_emojiButton setImage:[UIImage imageNamed:CHAT_KEYBOARD_IMAGE] forState:UIControlStateSelected];
        [_emojiButton addTarget:self action:@selector(clickedEmoij:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_emojiButton];
        
        _moreButton = [QJKJButton buttonWithType:UIButtonTypeCustom];
        _moreButton.frame = CGRectMake(_emojiButton.right + CHAT_LEFT_SPACE, (self.height - CHAT_BUTTON_WIDTH) / 2.0, CHAT_BUTTON_WIDTH, CHAT_BUTTON_WIDTH);
        [_moreButton setImage:[UIImage imageNamed:CHAT_MORE_IMAGE] forState:UIControlStateNormal];
        [_moreButton setImage:[UIImage imageNamed:CHAT_KEYBOARD_IMAGE] forState:UIControlStateSelected];
        [_moreButton addTarget:self action:@selector(clickedMore:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_moreButton];
        
        _contentTextView = [[QJKJTextView alloc] initWithFrame:CGRectMake(_audioButton.right + CHAT_LEFT_SPACE, CHAT_TEXTVIEW_TOP, (_emojiButton.left - CHAT_LEFT_SPACE) - (_audioButton.right + CHAT_LEFT_SPACE), self.height - CHAT_TEXTVIEW_TOP * 2)];
        _contentTextView.backgroundColor = [UIColor whiteColor];
        _contentTextView.delegate = self;
        _contentTextView.font = [UIFont systemFontOfSize:14];
        _contentTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _contentTextView.layer.borderWidth = 0.5;
        _contentTextView.layer.cornerRadius = 5;
        _contentTextView.layer.masksToBounds = YES;
        [self addSubview:_contentTextView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
  
        _audioInputView = [[QJKJChatAudioInputView alloc] initWithFrame:_contentTextView.frame];
        _audioInputView.backgroundColor = [UIColor whiteColor];
        _audioInputView.hidden = YES;
        [self addSubview:_audioInputView];
        
        _currentInputType = QJKJChatInputNone;
        
        [self emjjiArray];
    }
    return self;
}

- (void)setFaceView:(QJKJChatFaceView *)faceView {
    faceView.delegate = self;
}

#pragma mark - 键盘相关通知

- (void)keyboardWillShow:(NSNotification *)noti {
    
    NSDictionary *info = noti.userInfo;
    CGSize keyboardSize = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    //语音、表情、更多恢复正常
    _audioButton.selected = NO;
    _emojiButton.selected = NO;
    _moreButton.selected = NO;
    
    _audioInputView.hidden = YES;
    
    //隐藏上一个类型
    [self hiddenHeightType:_currentInputType];
    
    //显示当前类型
    _currentInputType = QJKJChatInputSystem;
    [self showHeight:keyboardSize.height
            withType:QJKJChatInputSystem];
}

- (void)keyboardWillHidden:(NSNotification *)noti {
    [self hiddenHeightType:QJKJChatInputSystem];
}


#pragma mark - CustomMethond

- (void)emjjiArray {
    NSArray *array = @[ @"开心",@"害羞",@"飞吻",@"亲亲",@"吃惊",@"呲牙",@"大哭",@"鬼脸",@"害怕",@"阴险",@"惊恐",@"纠结",@"苦脸",@"冷汗",@"脸红",@"难过",@"失望",@"喜欢",@"想想",@"糟糕",@"眨眼" ];
    _emojiArray = array;
}

/**
 显示

 @param height 高度
 @param inputType 类型
 */
- (void)showHeight:(CGFloat)height
          withType:(QJKJChatInputType)inputType {
    if (_delegate && [_delegate respondsToSelector:@selector(showChatHeight:withType:)]) {
        
        [_delegate showChatHeight:height withType:inputType];

    }
}

/**
 隐藏

 @param inputType 类型
 */
- (void)hiddenHeightType:(QJKJChatInputType)inputType {
    if (_delegate && [_delegate respondsToSelector:@selector(hiddenChatHeightType:)]) {
        [_delegate hiddenChatHeightType:inputType];
    }
}

/**
 隐藏键盘
 */
- (void)hiddenKeyboard{
    //语音、表情、更多恢复正常
    _audioButton.selected = NO;
    _emojiButton.selected = NO;
    _moreButton.selected = NO;

    _audioInputView.hidden = YES;
    
    if (_currentInputType == QJKJChatInputSystem) {
        [_contentTextView resignFirstResponder];
    }
    else {
        
        [self hiddenHeightType:_currentInputType];
    }
    
    _currentInputType = QJKJChatInputNone;
}

#pragma mark - QJKJChatFaceViewDelegate

//插入表情
- (void)insertEmoji:(NSString *)emoji {
    NSString *str = _contentTextView.text;
    str = [str stringByAppendingString:emoji];
    _contentTextView.text = str;
    
    [self textViewDidChange:_contentTextView];
    
    [_contentTextView scrollRangeToVisible:NSMakeRange(_contentTextView.text.length, 1)];
    _contentTextView.layoutManager.allowsNonContiguousLayout = NO;
}

//删除表情
- (void)deleteEmoji {
    NSString *str = _contentTextView.text;
    
    if (str.length >= 4) {
        NSString *emojiStr = [str substringFromIndex:[str length] - 1 - 3];
        if ([emojiStr hasPrefix:@"["] && [emojiStr hasSuffix:@"]"]) {
            NSString *tempStr = [emojiStr substringWithRange:NSMakeRange(1, 2)];
            BOOL isEmoij = NO;
            for (NSString *tStr in _emojiArray) {
                if ([tempStr isEqualToString:tStr]) {
                    //找到相等的，说明是表情
                    isEmoij = YES;
                    break;
                }
            }
            
            if (isEmoij) {
                str = [str substringToIndex:str.length - 1 - 3];
            }
            else {
                if ([str length] >= 1) {
                    str = [str substringToIndex:str.length - 1];
                }
            }
        }
        else {
            if ([str length] >= 1) {
                str = [str substringToIndex:str.length - 1];
            }
        }
    }
    else {
        if ([str length] >= 1) {
            str = [str substringToIndex:str.length - 1];
        }
    }

    _contentTextView.text = str;
    
    [self textViewDidChange:_contentTextView];
}

//发送数据
- (void)sendContent {
    
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
//    DLog(@"变化 %@",textView.text);
    
    CGSize size = [QJKJChatInputView sizeForString:textView.text
                               withNSLineBreakMode:NSLineBreakByCharWrapping
                                          withFont:textView.font
                                      withSizeMake:CGSizeMake(textView.width - 8 * 2, CGFLOAT_MAX)];
    CGFloat height = size.height;
    
    if (height <= CHAT_INPUT_HEIGHT_MIN - CHAT_TEXTVIEW_TOP * 2) {
        height = CHAT_INPUT_HEIGHT_MIN;
    }
    else if (height >= CHAT_INPUT_HEIGHT_MAX - CHAT_TEXTVIEW_TOP * 2) {
        height = CHAT_INPUT_HEIGHT_MAX;
    }
    else {
        height += CHAT_TEXTVIEW_TOP * 2;
    }
    
    _contentTextView.height = height - CHAT_TEXTVIEW_TOP * 2;
    _audioButton.top = height - _audioButton.height;
    _emojiButton.top = height - _audioButton.height;
    _moreButton.top = height - _audioButton.height;
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(inputViewHeightChage:)]) {
        [_delegate inputViewHeightChage:height];
    }
    
    DLog(@"文本高度 %f",height);
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    DLog(@"text = %@",text);
    if ([text isEqualToString:@""]) {
        //点击删除
        
        [self deleteEmoji];
        return NO;
        
    }
    
    return YES;
}

#pragma mark - 按钮事件

/**
 点击语音按钮

 @param btn btn description
 */
- (void)clickedAudio:(UIButton *)btn {
    
    btn.selected = !btn.selected;
    
    //更多和表情恢复到正常状态
    _emojiButton.selected = NO;
    _moreButton.selected = NO;

    
    if (btn.selected) {
        _audioInputView.hidden = NO;
        
        if (_currentInputType == QJKJChatInputSystem) {
            [_contentTextView resignFirstResponder];
        }
        else {

            [self hiddenHeightType:_currentInputType];
        }
        
        _currentInputType = QJKJChatInputNone;
 
    }
    else {
        //键盘状态
        _audioInputView.hidden = YES;
        [_contentTextView becomeFirstResponder];
    }
}


/**
 点击表情按钮

 @param btn btn description
 */
- (void)clickedEmoij:(UIButton *)btn {
    
    btn.selected = !btn.selected;
    
    //语音和更多恢复到正常状态
    _audioButton.selected = NO;
    _moreButton.selected = NO;
    
    _audioInputView.hidden = YES;
    
    if (btn.selected) {
        
        if (_currentInputType == QJKJChatInputSystem) {
            [_contentTextView resignFirstResponder];
        }
        else {
            
            [self hiddenHeightType:_currentInputType];
        }
        _currentInputType = QJKJChatInputEmoji;
        
        [self showHeight:CHAT_FACE_INPUT_HEIGHT
                withType:QJKJChatInputEmoji];
    }
    else {
        //键盘状态
        
        [_contentTextView becomeFirstResponder];
        
    }
}


/**
 点击更多按钮

 @param btn btn description
 */
- (void)clickedMore:(UIButton *)btn {
    
    btn.selected = !btn.selected;
    
    //语音和表情恢复到正常状态
    _audioButton.selected = NO;
    _emojiButton.selected = NO;
    
    _audioInputView.hidden = YES;
    
    if (btn.selected) {
        if (_currentInputType == QJKJChatInputSystem) {
            [_contentTextView resignFirstResponder];
        }
        else {
            
            [self hiddenHeightType:_currentInputType];
        }
        _currentInputType = QJKJChatInputMore;
        
        [self showHeight:CHAT_MORE_INPUT_HEIGHT
                withType:QJKJChatInputMore];
    }
    else {
        //键盘状态
        
        [_contentTextView becomeFirstResponder];
        
    }
}


/**
 点击输入框按钮
 */
- (void)clickedTextView {
    
    //语音、表情、更多恢复正常
    _audioButton.selected = NO;
    _emojiButton.selected = NO;
    _moreButton.selected = NO;
    
    _contentButton.hidden = YES;
    _audioInputView.hidden = YES;

    //设置输入键盘
    [_contentTextView setInputView:nil];
    
    if (!_contentTextView.isFirstResponder) {
        [_contentTextView becomeFirstResponder];
    }
    else {
        [_contentTextView reloadInputViews];
    }
}

/**
 *  计算文本的size
 *
 *  @param string 所需计算文本
 *  @param model  模式
 *  @param font   字体大小
 *  @param size   容量
 *
 *  @return 计算出的容量
 */
+ (CGSize)sizeForString:(NSString *)string
    withNSLineBreakMode:(NSLineBreakMode)model
               withFont:(UIFont *)font
           withSizeMake:(CGSize)size {
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    
    paragraphStyle.lineBreakMode = model;
    
    NSDictionary* attributes =@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    return labelSize;
}

//
//#pragma mark - getters or setters
//
//- (QJKJChatFaceView *)faceView {
//    if (!_faceView) {
//        _faceView = [[QJKJChatFaceView alloc] init];
//    }
//    return _faceView;
//}
//
//- (QJKJChatMoreView *)moreView {
//    if (!_moreView) {
//        _moreView = [[QJKJChatMoreView alloc] init];
//    }
//    return _moreView;
//}

@end
