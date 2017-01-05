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

//发送按钮高度
#define EMOIJ_SEND_BUTTON_HEIGHT 40



#pragma mark - 

//tag
#define EMOIJ_TAG 2000


@implementation QJKJChatFaceView {
    QJKJScrollView *_emoijScrollView;
    QJKJButton *_sendButton;
    NSMutableArray *_emojiMArray;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, CHAT_FACE_INPUT_HEIGHT);
        
        NSArray *array = @[ @"开心",@"害羞",@"飞吻",@"亲亲",@"吃惊",@"呲牙",@"大哭",@"鬼脸",@"害怕",@"阴险",@"惊恐",@"纠结",@"苦脸",@"冷汗",@"脸红",@"难过",@"失望",@"喜欢",@"想想",@"糟糕",@"眨眼" ];
        _emojiMArray = [NSMutableArray arrayWithArray:array];
 
        //写死
        [_emojiMArray insertObject:@"chat_delete" atIndex:EMOIJ_MAX_COUNT - 1];
        [_emojiMArray addObject:@"chat_delete"];
        
        _emoijScrollView = [[QJKJScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, EMOIJ_LEFT_SPACE * 2 + EMOIJ_ROW * EMOIJ_WIDTH)];
        _emoijScrollView.backgroundColor = [UIColor whiteColor];
        _emoijScrollView.bounces = NO;
        _emoijScrollView.pagingEnabled = YES;
        [self addSubview:_emoijScrollView];
        
        CGFloat widthSpace = (self.width - EMOIJ_COLUM * EMOIJ_WIDTH - EMOIJ_LEFT_SPACE * 2) / (EMOIJ_COLUM - 1);
        
        for (NSInteger i = 0; i < _emojiMArray.count; i++) {
            QJKJButton *emojiButton = [QJKJButton buttonWithType:UIButtonTypeCustom];
            emojiButton.frame = CGRectMake(EMOIJ_LEFT_SPACE + (EMOIJ_WIDTH + widthSpace) * ((i % EMOIJ_MAX_COUNT) % EMOIJ_COLUM) + _emoijScrollView.width * (i / EMOIJ_MAX_COUNT), EMOIJ_TOP_SPACE + EMOIJ_WIDTH * ((i % EMOIJ_MAX_COUNT) / EMOIJ_COLUM), EMOIJ_WIDTH, EMOIJ_WIDTH);
            emojiButton.tag = EMOIJ_TAG + i;
            [emojiButton setImage:[UIImage imageNamed:_emojiMArray[i]] forState:UIControlStateNormal];
            [emojiButton addTarget:self action:@selector(clickedEmoij:) forControlEvents:UIControlEventTouchUpInside];
            [_emoijScrollView addSubview:emojiButton];
        }
        
        _sendButton = [QJKJButton buttonWithType:UIButtonTypeCustom];
        _sendButton.frame = CGRectMake(_emoijScrollView.left, _emoijScrollView.bottom, _emoijScrollView.width, self.height - _emoijScrollView.height);
        _sendButton.backgroundColor = [UIColor blueColor];
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [_sendButton addTarget:self action:@selector(clickedSend) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_sendButton];
        
        _emoijScrollView.contentSize = CGSizeMake(_emoijScrollView.width * ((_emojiMArray.count + EMOIJ_MAX_COUNT - 1) / EMOIJ_MAX_COUNT), self.height);
    }
    return self;
}

- (void)clickedEmoij:(UIButton *)btn {
    
    
    NSString *str = _emojiMArray[btn.tag - EMOIJ_TAG];
    if ([str isEqualToString:@"chat_delete"]) {
        DLog(@"删除");
        if (_delegate && [_delegate respondsToSelector:@selector(deleteEmoji)]) {
            [_delegate deleteEmoji];
        }
    }
    else {
        DLog(@"表情 - %@",str);
        if (_delegate && [_delegate respondsToSelector:@selector(insertEmoji:)]) {
            [_delegate insertEmoji:[NSString stringWithFormat:@"[%@]",str]];
        }
    }
    
}

- (void)clickedSend {
    DLog(@"发送");
    if (_delegate && [_delegate respondsToSelector:@selector(sendContent)]) {
        [_delegate sendContent];
    }
}


@end
