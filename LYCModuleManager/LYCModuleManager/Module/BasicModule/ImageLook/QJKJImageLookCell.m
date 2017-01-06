//
//  QJKJImageLookCell.m
//  LYCModuleManager
//
//  Created by YouchengLi on 2017/1/6.
//  Copyright © 2017年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import "QJKJImageLookCell.h"


@implementation QJKJImageLookCell {
    QJKJImageScrollView *_imageScrollView;
    QJKJImageLookCellFinishBlock _finishBlock;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageScrollView = [[QJKJImageScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _imageScrollView.i_delegate = self;
        [self addSubview:_imageScrollView];
    }
    return self;
}

- (void)refreshUIWithImageView:(QJKJImageView *)imageView
               withFinishBlock:(QJKJImageLookCellFinishBlock)finishBlock {
    _finishBlock = finishBlock;
    
    CGRect newFrame = [[imageView superview] convertRect:imageView.frame toView:[UIApplication sharedApplication].keyWindow];
    
    [_imageScrollView setContentWithFrame:newFrame];
    //改变位置
    [_imageScrollView setImage:imageView.image];
    //动画大小
    [_imageScrollView setAnimationRect];

}

#pragma mark - QJKJImageScrollViewDelegate

- (void)tapImageViewTappedWithObject:(id)sender {
    QJKJImageScrollView *tmpImgView = sender;
    
    
    [UIView animateWithDuration:0.3 animations:^{
        [tmpImgView rechangeInitRdct];
    } completion:^(BOOL finished) {
        if (_finishBlock) {
            _finishBlock();
        }
    }];
}

@end
