//
//  QJKJImageView.m
//  LYCModuleManager
//
//  Created by 史ios on 16/12/19.
//  Copyright © 2016年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import "QJKJImageView.h"

@implementation QJKJImageView {
    UITapGestureRecognizer *_tap;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickedImage)];
    }
    return self;
}

- (void)clickedImage {
    if (_clickBlock) {
        _clickBlock(self);
    }
}

- (void)setIsClick:(BOOL)isClick {
    if (isClick) {
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:_tap];
    }
    else {
        self.userInteractionEnabled = NO;
        [self removeGestureRecognizer:_tap];
    }
}

@end
