//
//  QJKJTextView.m
//  LYCModuleManager
//
//  Created by 史ios on 16/12/19.
//  Copyright © 2016年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import "QJKJTextView.h"

@implementation QJKJTextView {
    QJKJLabel *_placeholderLabel;//占位文本
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _placeholderLabel = [[QJKJLabel alloc] init];
        _placeholderLabel.font = [UIFont boldFontFor28];
        _placeholderLabel.textColor = [UIColor grayColor];
    }
    return self;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholderLabel.text = placeholder;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _placeholderLabel.frame = CGRectMake(10, 5, 0, 20);
    
    DLog(@"执行");
    
}

@end
