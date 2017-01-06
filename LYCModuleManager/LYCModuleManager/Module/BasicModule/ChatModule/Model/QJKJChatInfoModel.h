//
//  QJKJChatInfoModel.h
//  LYCModuleManager
//
//  Created by YouchengLi on 2017/1/6.
//  Copyright © 2017年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

// --聊天信息
#import <Foundation/Foundation.h>

@interface QJKJChatInfoModel : NSObject

/**
 发送者id -- strSenderUserID mid
 */
@property (nonatomic, copy) NSString *ciSenderId;

/**
 发送者用户名 -- strSenderUserName
 */
@property (nonatomic, copy) NSString *ciSenderName;

/**
 接收者id -- strReceiverUserID  manage_id
 */
@property (nonatomic, copy) NSString *ciReceiverId;

/**
 接收者用户名 -- strReceiverUserName
 */
@property (nonatomic, copy) NSString *ciReceiverName;

/**
 更新时间 -- strTime updatetime
 */
@property (nonatomic, copy) NSString *ciUpdateTime;

/**
 更新内容 -- strContent content
 */
@property (nonatomic, copy) NSString *ciUpdateContent;

/**
 消息类型 1 文字 2 语音 3 图片 4 时间  --strMessageType types
 */
@property (nonatomic, copy) NSString *ciMessageType;

/**
 用户类型 1 表示左边 对方 2 则右边 我方  --strState state
 */
@property (nonatomic, copy) NSString *ciUserType;

/**
 消息是否已经阅读  --strIsRead
 */
@property (nonatomic, copy) NSString *ciIsRead;

/**
 消息id -- strChatID id
 */
@property (nonatomic, copy) NSString *ciMessageId;

/**
 小图 -- strSmallImage
 */
@property (nonatomic, copy) NSString *ciSmallPicture;

/**
 大图 -- strBigImage vod
 */
@property (nonatomic, copy) NSString *ciBigPicture;

/**
 语音内容 -- strAudio vod
 */
@property (nonatomic, copy) NSString *ciAudioContent;

/**
 语音时长 -- strAudioDuration
 */
@property (nonatomic, copy) NSString *ciAudioDuration;



@property(nonatomic, strong)NSString *ID;





@end
