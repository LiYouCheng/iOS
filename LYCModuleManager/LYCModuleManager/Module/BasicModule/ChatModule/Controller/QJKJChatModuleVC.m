//
//  QJKJChatModuleVC.m
//  LYCModuleManager
//
//  Created by 史ios on 2017/1/4.
//  Copyright © 2017年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import "QJKJChatModuleVC.h"

#import "QJKJChatInputView.h"

#pragma mark - 位置信息
//导航条高度
#define CHAT_NAIGATION_HEIGHT 64.f
//输入工具高度
#define CHAT_INPUT_HEIGHT 50.f
//屏幕高度
#define CHAT_SCREEN_HEIGTH [UIScreen mainScreen].bounds.size.height
//屏幕宽度
#define CHAT_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface QJKJChatModuleVC ()

@property (nonatomic, strong) QJKJTableView *chatTableView;
@property (nonatomic, strong) QJKJChatInputView *chatInputView;


@end

@implementation QJKJChatModuleVC

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    [self.view addSubview:self.chatTableView];
    [self.view addSubview:self.chatInputView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    
}

#pragma mark - 键盘相关通知

- (void)keyboardWillShow:(NSNotification *)noti {

    NSDictionary *info = noti.userInfo;
    CGSize keyboardSize = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    DLog(@"弹出高度 %f",keyboardSize.height);
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.chatInputView.top = CHAT_SCREEN_HEIGTH - CHAT_NAIGATION_HEIGHT - CHAT_INPUT_HEIGHT - keyboardSize.height;
        
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)keyboardWillHidden:(NSNotification *)noti {
    
    NSDictionary *info = noti.userInfo;
    CGSize keyboardSize = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    
    DLog(@"消失高度 %f",keyboardSize.height);
    self.chatInputView.top = [UIScreen mainScreen].bounds.size.height - CHAT_NAIGATION_HEIGHT - self.chatInputView.height;
}


- (QJKJTableView *)chatTableView {
    if (!_chatTableView) {
        _chatTableView = [[QJKJTableView alloc] initWithFrame:CGRectMake(0, 0, CHAT_SCREEN_WIDTH, CHAT_SCREEN_HEIGTH - CHAT_NAIGATION_HEIGHT - CHAT_INPUT_HEIGHT) style:UITableViewStyleGrouped];
        _chatTableView.backgroundColor = [UIColor greenColor];
    }
    return _chatTableView;
}

- (QJKJChatInputView *)chatInputView {
    if (!_chatInputView) {
        _chatInputView = [[QJKJChatInputView alloc] initWithFrame:CGRectMake(0, self.chatTableView.bottom, self.chatTableView.width, CHAT_INPUT_HEIGHT)];
    }
    return _chatInputView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
