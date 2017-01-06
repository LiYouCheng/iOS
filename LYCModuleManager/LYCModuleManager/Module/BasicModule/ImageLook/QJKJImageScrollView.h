//
//  QJKJImageScrollView.h
//  LYCModuleManager
//
//  Created by YouchengLi on 2017/1/6.
//  Copyright © 2017年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QJKJImageScrollViewDelegate <NSObject>

- (void) tapImageViewTappedWithObject:(id) sender;

@end

@interface QJKJImageScrollView : UIScrollView
<UIScrollViewDelegate>{
    UIImageView *imgView;
    
    //记录自己的位置
    CGRect scaleOriginRect;
    
    //图片的大小
    CGSize imgSize;
    
    //缩放前大小
    CGRect initRect;
}

@property (nonatomic, weak) id<QJKJImageScrollViewDelegate> i_delegate;
//内容宽度
- (void)setContentWithFrame:(CGRect) rect;
//当前图片
- (void)setImage:(UIImage *) image;
//动画frame
- (void)setAnimationRect;
//初始化
- (void)rechangeInitRdct;


@end
