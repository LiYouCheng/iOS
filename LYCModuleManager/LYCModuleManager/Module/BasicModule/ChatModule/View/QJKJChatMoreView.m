//
//  QJKJChatMoreView.m
//  LYCModuleManager
//
//  Created by 史ios on 2017/1/4.
//  Copyright © 2017年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import "QJKJChatMoreView.h"


#pragma mark - 距离
//距离左边空隙
#define MORE_LEFT_SPACE 15
//距离上边空隙
#define MORE_TOP_SPACE 15
//按钮宽度
#define MORE_BUTTON_WIDTH 60
//按钮数量
#define MORE_BUTTON_COUNT 2

@implementation QJKJChatMoreView {
    QJKJScrollView *_moreScrollView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, MORE_BUTTON_WIDTH  + MORE_TOP_SPACE * 2);
        
        _moreScrollView = [[QJKJScrollView alloc] initWithFrame:self.bounds];
        _moreScrollView.backgroundColor = [UIColor redColor];
        _moreScrollView.bounces = NO;
        _moreScrollView.pagingEnabled = YES;
        [self addSubview:_moreScrollView];
        
        //暂时不考虑多行
        for (NSInteger i = 0; i < MORE_BUTTON_COUNT; i++) {
            QJKJButton *emoijButton = [QJKJButton buttonWithType:UIButtonTypeCustom];
            emoijButton.frame = CGRectMake(MORE_LEFT_SPACE + (MORE_LEFT_SPACE + MORE_BUTTON_WIDTH) * i, MORE_TOP_SPACE, MORE_BUTTON_WIDTH, MORE_BUTTON_WIDTH);
            emoijButton.backgroundColor = [UIColor colorWithRed:((arc4random()%255)/255.0) green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:1];
            [_moreScrollView addSubview:emoijButton];
        }

    }
    return self;
}

@end
