//
//  QJKJChatModuleVC.m
//  LYCModuleManager
//
//  Created by 史ios on 2017/1/4.
//  Copyright © 2017年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import "QJKJChatModuleVC.h"
#import "QJKJChatInfoModel.h"
#import "QJKJChatTimeCell.h"
#import "QJKJChatTextCell.h"
#import "QJKJChatImageCell.h"
#import "QJKJChatAudioCell.h"



#import "QJKJChatInputView.h"

#import "QJKJChatFaceView.h"
#import "QJKJChatMoreView.h"


//音频处理
#import "amrFileCodec.h"
#import "QJKJPlayAudio.h"

#import "QJKJNetworkingRequest.h"

//聊天数据
#import "QJKJDataBaseManager.h"
#import "QJKJDataBaseManager+QJKJChatRecord.h"

//图片
#import "QJKJImageLookView.h"

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


#pragma mark - 请求地址

#define CHAT_UNREAD_URL @"http://121.41.100.58/Baicheng/index.php/Manage/detail2"

@interface QJKJChatModuleVC ()
<UITableViewDelegate,
UITableViewDataSource,
QJKJChatInputViewDelegate,
QJKJPlayAudioDelegate>

@property (nonatomic, strong) QJKJTableView *chatTableView;
@property (nonatomic, strong) NSMutableArray *chatMArray;//数据源


@property (nonatomic, strong) QJKJChatInputView *chatInputView;

@property (nonatomic, strong) QJKJChatFaceView *faceView;
@property (nonatomic, strong) QJKJChatMoreView *moreView;

@property (nonatomic, assign) CGFloat inputViewHeight;

@property (nonatomic, assign) CGFloat currentKeyboardHeight;//当前键盘高度

@property (nonatomic, strong) QJKJPlayAudio *playAudio;

@property (nonatomic, strong) QJKJImageLookView *imageLookView;//查看图片

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
    
    [self dataHandler];
    
//    [self loadData];
    
    NSArray *array = [[QJKJDataBaseManager shareChatDBManage] searchChatRecordWithSend:8388815 receiver:1958 page:1];
    [self.chatMArray addObjectsFromArray:array];
    
    [self.chatTableView reloadData];
}


/**
 获取未读信息
 */
- (void)loadData {
    QJKJNetworkingRequest *request = [[QJKJNetworkingRequest alloc] initWithURLString:CHAT_UNREAD_URL];

//    [request setPostValue:_dicDataLast[@"f_id"] forKey:@"f_id"];
//    [request setPostValue:@"2" forKey:@"is_member"];
//    [request setPostValue:[[ChatDBManage shareChatDBManage] getLastIDWithID:[_dicDataLast[@"mid"] integerValue]] forKey:@"readid"];
//    [request setPostValue:_dicDataLast[@"unread"] forKey:@"unread"];
    
    [request setPostValue:@"10" forKey:@"f_id"];//f_id 父id
    [request setPostValue:@"2" forKey:@"is_member"];//is_member 未知
    [request setPostValue:@"0" forKey:@"readid"];//readid mid
    [request setPostValue:@"1" forKey:@"unread"];//unread 未读数
    
    [request startPostAsynchronousWithFinish:^(NSDictionary *dict) {
        
        if (dict && [dict[@"status"] integerValue] == 0) {
            
            if ([dict[@"volist"] isKindOfClass:[NSArray class]]) {
                //保存当前未读信息
                [[QJKJDataBaseManager shareChatDBManage] addChatRecordList:dict[@"volist"]];
                
                
                NSArray *array = [[QJKJDataBaseManager shareChatDBManage] searchChatRecordWithSend:8388815 receiver:1958 page:1];
                [self.chatMArray addObjectsFromArray:array];
                
            }
            
            
            
        }
        
        
    } failed:^(NSError *error) {
        
        
        
    } networkExist:^(NSError *error) {
        
        
        
    }];
}


/**
 数据处理
 */
- (void)dataHandler {
    
    __weak QJKJChatModuleVC *weakSelf = self;
    self.chatInputView.sendTextBlock = ^(NSString *text){
        DLog(@"发送文字==>%@",text);
    };
    self.chatInputView.sendAuidoBlock = ^(NSString *aduioString){
        __strong QJKJChatModuleVC *strongSelf = weakSelf;
        [strongSelf.playAudio playWithString:aduioString];
        
        
        DLog(@"播放时间 %.0f",[strongSelf.playAudio audioPlayTimeForString:aduioString]);

        
    };
    self.chatInputView.sendImageBlock = ^(UIImage *image){
        DLog(@"发送图片==>%@",image);
    };

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.chatInputView hiddenKeyboard];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    QJKJChatInfoModel *chatInfo = self.chatMArray[indexPath.row];
    NSInteger messageType = chatInfo.ciMessageType.integerValue;
    
    if (messageType == 4) {
        //时间
        return 40;
    }
    else if (messageType == 3) {
        //图片
        NSData *dataImg = [[NSData alloc] initWithBase64EncodedString:chatInfo.ciBigPicture options:0];
        UIImage *image = [UIImage imageWithData:dataImg];
        
        CGSize size = [QJKJChatImageCell imageScaleShow:image];

        return size.height + 30 > 60 ? size.height + 30 : 60;
        
    }
    else {
        return 40;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.chatMArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifierNormCell = NSStringFromClass([self class]);
    NSString *identifierTimeCell = NSStringFromClass([QJKJChatTimeCell class]);
    NSString *identifierImageCell = NSStringFromClass([QJKJChatImageCell class]);
    
    QJKJChatInfoModel *chatInfo = self.chatMArray[indexPath.row];
    NSInteger messageType = chatInfo.ciMessageType.integerValue;
    if (messageType == 4) {
        //时间
        QJKJChatTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierTimeCell];
        if (!cell) {
            cell = [[QJKJChatTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierTimeCell];
        }
        
        [cell refreshUIWithModel:chatInfo];
        
        return cell;
    }
    else if (messageType == 3) {
        //图片
        QJKJChatImageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierImageCell];
        if (!cell) {
            cell = [[QJKJChatImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierImageCell];
        }
        
        __weak QJKJChatModuleVC *weakSelf = self;
        [cell refreshUIWithModel:chatInfo withClickBlock:^(QJKJImageView *imageView) {
            __weak QJKJChatModuleVC *strongSelf = weakSelf;
            
            [strongSelf.imageLookView showImageLookView:@[ imageView ]];
            DLog(@"刷新图片");
        }];
        
        return cell;
    }
    else {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierNormCell];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierNormCell];
        }
        
        cell.textLabel.text = @"开发中...";
        return cell;
    }
}

#pragma mark - QJKJPlayAudioDelegate

- (void)playFinish {
    DLog(@"播放完成");
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
        _chatTableView = [[QJKJTableView alloc] initWithFrame:CGRectMake(0, 0, CHAT_SCREEN_WIDTH, CHAT_SCREEN_HEIGTH - CHAT_NAIGATION_HEIGHT - self.inputViewHeight) style:UITableViewStylePlain];
        _chatTableView.backgroundColor = [UIColor greenColor];
        _chatTableView.delegate = self;
        _chatTableView.dataSource = self;
        _chatTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _chatTableView;
}

- (NSMutableArray *)chatMArray {
    if (!_chatMArray) {
        _chatMArray = [NSMutableArray array];
    }
    return _chatMArray;
}

- (QJKJChatInputView *)chatInputView {
    if (!_chatInputView) {
        _chatInputView = [[QJKJChatInputView alloc] initWithFrame:CGRectMake(0, self.chatTableView.bottom, self.chatTableView.width, self.inputViewHeight)];
        _chatInputView.delegate = self;
        _chatInputView.faceView = self.faceView;
        _chatInputView.moreView = self.moreView;
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

- (QJKJPlayAudio *)playAudio {
    if (!_playAudio) {
        _playAudio = [[QJKJPlayAudio alloc] init];
        _playAudio.delegate = self;
    }
    return _playAudio;
}

- (QJKJImageLookView *)imageLookView {
    if (!_imageLookView) {
        _imageLookView = [[QJKJImageLookView alloc] init];
    }
    return _imageLookView;
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
