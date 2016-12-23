//
//  QJKJTextView.m
//  LYCModuleManager
//
//  Created by LiYouCheng on 16/12/19.
//  Copyright © 2016年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import "QJKJTextView.h"

@interface QJKJTextView() {
    UILabel *_placeholderLabel;//占位文本
}

@end

@implementation QJKJTextView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 创建label
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.numberOfLines = 0;
        [self addSubview:placeholderLabel];
        _placeholderLabel = placeholderLabel;
        
        // 设置默认字体
        self.font = [UIFont fontFor28];
        
        // 设置默认颜色
        self.placeholderColor = [UIColor grayColor];
        
        // 使用通知监听文字改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)textDidChange:(NSNotification *)note {
    _placeholderLabel.hidden = self.hasText;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _placeholderLabel.left = 5;
    _placeholderLabel.top = 8;
    _placeholderLabel.width = self.width - 2 * _placeholderLabel.left;
    [_placeholderLabel sizeToFit];
}

#pragma mark - setter
- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = [placeholder copy];
    
    _placeholderLabel.text = placeholder;
    [_placeholderLabel sizeToFit];
    
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    
    _placeholderLabel.textColor = placeholderColor;
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    
    _placeholderLabel.font = font;
    [_placeholderLabel sizeToFit];
    
}

- (void)setText:(NSString *)text {
    [super setText:text];
    
    _placeholderLabel.hidden = self.hasText;
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    
    _placeholderLabel.hidden = self.hasText;
}


@end
