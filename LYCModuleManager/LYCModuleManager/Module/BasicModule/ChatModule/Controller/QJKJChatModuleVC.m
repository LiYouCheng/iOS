//
//  QJKJChatModuleVC.m
//  LYCModuleManager
//
//  Created by 史ios on 2017/1/4.
//  Copyright © 2017年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import "QJKJChatModuleVC.h"

#import "QJKJChatInputView.h"

#import "QJKJChatFaceView.h"
#import "QJKJChatMoreView.h"

#pragma mark - 位置信息
//导航条高度
#define CHAT_NAIGATION_HEIGHT 64.f
////输入工具最小高度
#define CHAT_INPUT_HEIGHT 50.f
////输入工具最大高度
//#define CHAT_INPUT_HEIGHT_MAX 90.f
//屏幕高度
#define CHAT_SCREEN_HEIGTH [UIScreen mainScreen].bounds.size.height
//屏幕宽度
#define CHAT_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface QJKJChatModuleVC ()
<QJKJChatInputViewDelegate>

@property (nonatomic, strong) QJKJTableView *chatTableView;
@property (nonatomic, strong) QJKJChatInputView *chatInputView;

@property (nonatomic, strong) QJKJChatFaceView *faceView;
@property (nonatomic, strong) QJKJChatMoreView *moreView;

@property (nonatomic, assign) CGFloat inputViewHeight;

@property (nonatomic, assign) CGFloat currentKeyboardHeight;//当前键盘高度
@end

@implementation QJKJChatModuleVC

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.inputViewHeight = CHAT_INPUT_HEIGHT;
    self.currentKeyboardHeight = 0;
    
    [self.view addSubview:self.chatTableView];
    [self.view addSubview:self.chatInputView];
    [self.view addSubview:self.faceView];
    [self.view addSubview:self.moreView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.chatInputView hiddenKeyboard];
}

#pragma mark - QJKJChatInputViewDelegate

- (void)showChatHeight:(CGFloat)height withType:(QJKJChatInputType)type {
    DLog(@"弹出高度 %f",height);
    self.faceView.hidden = YES;
    self.moreView.hidden = YES;
    
    if (type == QJKJChatInputSystem) {
        
    }
    else if (type == QJKJChatInputMore) {
        self.moreView.hidden = NO;
    }
    else if (type == QJKJChatInputEmoji) {
        self.faceView.hidden = NO;
    }
    self.currentKeyboardHeight = height;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.chatTableView.height = CHAT_SCREEN_HEIGTH - CHAT_NAIGATION_HEIGHT - self.inputViewHeight - height;
        self.chatInputView.top = self.chatTableView.bottom;
        
        if (type == QJKJChatInputMore) {
            self.moreView.top = self.chatInputView.bottom;
            self.faceView.top = CHAT_SCREEN_HEIGTH - CHAT_NAIGATION_HEIGHT;
        }
        else if (type == QJKJChatInputEmoji) {
            self.faceView.top = self.chatInputView.bottom;
            self.moreView.top = CHAT_SCREEN_HEIGTH - CHAT_NAIGATION_HEIGHT;
        }
        else {
            self.faceView.top = CHAT_SCREEN_HEIGTH - CHAT_NAIGATION_HEIGHT;
            self.moreView.top = CHAT_SCREEN_HEIGTH - CHAT_NAIGATION_HEIGHT;
        }
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hiddenChatHeightType:(QJKJChatInputType)type {
    DLog(@"消失高度");
    self.currentKeyboardHeight = 0;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.chatTableView.height = CHAT_SCREEN_HEIGTH - CHAT_NAIGATION_HEIGHT - self.inputViewHeight;
        self.chatInputView.top = self.chatTableView.bottom;
        self.faceView.top = self.chatInputView.bottom;
        self.moreView.top = self.chatInputView.bottom;
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)inputViewHeightChage:(CGFloat)height {

    self.inputViewHeight = height;
    
    
    //刷新位置
    self.chatTableView.height = CHAT_SCREEN_HEIGTH - CHAT_NAIGATION_HEIGHT - self.inputViewHeight - self.currentKeyboardHeight;
    self.chatInputView.top = self.chatTableView.bottom;
    self.chatInputView.height = self.inputViewHeight;
}

#pragma mark - getters or setters

- (QJKJTableView *)chatTableView {
    if (!_chatTableView) {
        _chatTableView = [[QJKJTableView alloc] initWithFrame:CGRectMake(0, 0, CHAT_SCREEN_WIDTH, CHAT_SCREEN_HEIGTH - CHAT_NAIGATION_HEIGHT - self.inputViewHeight) style:UITableViewStyleGrouped];
        _chatTableView.backgroundColor = [UIColor greenColor];
    }
    return _chatTableView;
}

- (QJKJChatInputView *)chatInputView {
    if (!_chatInputView) {
        _chatInputView = [[QJKJChatInputView alloc] initWithFrame:CGRectMake(0, self.chatTableView.bottom, self.chatTableView.width, self.inputViewHeight)];
        _chatInputView.delegate = self;
        _chatInputView.faceView = self.faceView;
    }
    return _chatInputView;
}

- (QJKJChatFaceView *)faceView {
    if (!_faceView) {
        _faceView = [[QJKJChatFaceView alloc] init];
        _faceView.top = _chatInputView.bottom;
        _faceView.hidden = YES;
    }
    return _faceView;
}

- (QJKJChatMoreView *)moreView {
    if (!_moreView) {
        _moreView = [[QJKJChatMoreView alloc] init];
        _moreView.top = _chatInputView.bottom;
        _moreView.hidden = YES;
    }
    return _moreView;
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
