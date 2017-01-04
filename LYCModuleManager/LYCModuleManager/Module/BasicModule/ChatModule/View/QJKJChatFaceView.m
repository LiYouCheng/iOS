//
//  QJKJChatFaceView.m
//  LYCModuleManager
//
//  Created by 史ios on 2017/1/4.
//  Copyright © 2017年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import "QJKJChatFaceView.h"

#pragma mark - 距离
//表情宽度
#define EMOIJ_WIDTH 40
//表情当前数量
#define EMOIJ_CURRENT_COUNT 40
//表情一页最大列数
#define EMOIJ_COLUM 7
//表情一页最大行数
#define EMOIJ_ROW 3
//表情一页最大表情数量
#define EMOIJ_MAX_COUNT (EMOIJ_COLUM * EMOIJ_ROW)
//表情左边间隙
#define EMOIJ_LEFT_SPACE 15
//表情顶部间隙
#define EMOIJ_TOP_SPACE 15


@implementation QJKJChatFaceView {
    QJKJScrollView *_emoijScrollView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, EMOIJ_WIDTH * EMOIJ_ROW + EMOIJ_TOP_SPACE * 2);
        
        _emoijScrollView = [[QJKJScrollView alloc] initWithFrame:self.bounds];
        _emoijScrollView.backgroundColor = [UIColor redColor];
        _emoijScrollView.bounces = NO;
        _emoijScrollView.pagingEnabled = YES;
        [self addSubview:_emoijScrollView];
        
        CGFloat widthSpace = (self.width - EMOIJ_COLUM * EMOIJ_WIDTH - EMOIJ_LEFT_SPACE * 2) / (EMOIJ_COLUM - 1);
        
        for (NSInteger i = 0; i < EMOIJ_CURRENT_COUNT; i++) {
            QJKJButton *emoijButton = [QJKJButton buttonWithType:UIButtonTypeCustom];
            emoijButton.frame = CGRectMake(EMOIJ_LEFT_SPACE + (EMOIJ_WIDTH + widthSpace) * ((i % EMOIJ_MAX_COUNT) % EMOIJ_COLUM) + _emoijScrollView.width * (i / EMOIJ_MAX_COUNT), EMOIJ_TOP_SPACE + EMOIJ_WIDTH * ((i % EMOIJ_MAX_COUNT) / EMOIJ_COLUM), EMOIJ_WIDTH, EMOIJ_WIDTH);
            emoijButton.backgroundColor = [UIColor colorWithRed:((arc4random()%255)/255.0) green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:1];
            [_emoijScrollView addSubview:emoijButton];
        }
        
        _emoijScrollView.contentSize = CGSizeMake(_emoijScrollView.width * ((EMOIJ_CURRENT_COUNT + EMOIJ_MAX_COUNT - 1) / EMOIJ_MAX_COUNT), self.height);
    }
    return self;
}

@end
