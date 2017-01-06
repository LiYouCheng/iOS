//
//  QJKJDataBaseManager+QJKJChatRecord.m
//  LYCModuleManager
//
//  Created by YouchengLi on 2017/1/6.
//  Copyright © 2017年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import "QJKJDataBaseManager+QJKJChatRecord.h"

#import "QJKJChatInfoModel.h"
#import <FMDatabase.h>
#import "amrFileCodec.h"

#import "QJKJPlayAudio.h"

@implementation QJKJDataBaseManager (QJKJChatRecord)

#define ROW_MAX 20

/**
 查询聊天记录
 
 @param sendID 发送者id
 @param receiverID 接受者id
 @param intPage 页码
 @return 聊天记录
 */
- (NSArray *)searchChatRecordWithSend:(NSInteger)sendID
                                    receiver:(NSInteger)receiverID
                                        page:(NSInteger)intPage {
    NSInteger intRowNum = [self getRowNumWithSend:sendID
                                   receiver:receiverID];
    
    NSInteger intRowStart = intRowNum - ROW_MAX * intPage;
    NSInteger intRowMax = ROW_MAX;
    
    if (intRowStart < 0)
    {
        intRowMax = intRowNum - ROW_MAX * (intPage - 1);
        if (intRowMax > 0)
        {
            intRowStart = 0;
        }
        else
        {
            return nil;
        }
    }
    
    NSMutableArray *arr = [NSMutableArray array];
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM ChatRecord WHERE SenderUserID=%d AND ReceiverUserID=%d LIMIT %d,%d",sendID,receiverID,intRowStart,intRowMax];
    
    FMResultSet *res = [self selectWithSQLStr:sql];
    NSInteger intTime = 0;
    while ([res next])
    {
        QJKJChatInfoModel *chatInfo = [[QJKJChatInfoModel alloc] init];
//        chatInfo.ID                     = [res stringForColumn:@"ID"];
        chatInfo.ciSenderId         = [res stringForColumn:@"SenderUserID"];
        chatInfo.ciSenderName       = [res stringForColumn:@"SenderUserName"];
        chatInfo.ciReceiverId       = [res stringForColumn:@"ReceiverUserID"];
        chatInfo.ciReceiverName     = [res stringForColumn:@"ReceiverUserName"];
        chatInfo.ciUpdateTime       = [res stringForColumn:@"Time"];
        chatInfo.ciUpdateContent    = [res stringForColumn:@"Content"];
        chatInfo.ciSmallPicture     = [res stringForColumn:@"SmallImage"];
        chatInfo.ciBigPicture       = [res stringForColumn:@"BigImage"];
        chatInfo.ciAudioContent     = [res stringForColumn:@"Audio"];
        chatInfo.ciAudioDuration    = [res stringForColumn:@"AudioDuration"];
        chatInfo.ciIsRead           = [res stringForColumn:@"IsRead"];
        chatInfo.ciMessageType      = [res stringForColumn:@"MessageType"];
        chatInfo.ciMessageId        = [res stringForColumn:@"ChatID"];
        chatInfo.ciUserType         = [res stringForColumn:@"State"];
        
        //为啥要这样？
        if (intTime + 300 < [chatInfo.ciUpdateTime integerValue])
        {
            intTime = [chatInfo.ciUpdateTime integerValue];
            QJKJChatInfoModel *chatInfo2 = [[QJKJChatInfoModel alloc] init];
            chatInfo2.ciMessageType      = @"4";
            chatInfo2.ciUpdateTime       = chatInfo.ciUpdateTime;
            [arr addObject:chatInfo2];
        }
        
        [arr addObject:chatInfo];
    }
    
    return arr;
}

/**
 添加一条聊天信息
 
 @param chatInfo 聊天信息
 */
- (void)addChatRecord:(QJKJChatInfoModel *)chatInfo {
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO ChatRecord (SenderUserID,SenderUserName,ReceiverUserID,ReceiverUserName,Time,Content,SmallImage,BigImage,Audio,AudioDuration,IsRead,MessageType,ChatID,State) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",chatInfo.ciSenderId,chatInfo.ciSenderName,chatInfo.ciReceiverId,chatInfo.ciReceiverName,chatInfo.ciUpdateTime,chatInfo.ciUpdateContent,chatInfo.ciSmallPicture,chatInfo.ciBigPicture,chatInfo.ciAudioContent,chatInfo.ciAudioDuration,chatInfo.ciIsRead,chatInfo.ciMessageType,chatInfo.ciMessageId,chatInfo.ciUserType];
    
    if ([self insertWithSQLStr:sql])
    {
        NSLog(@"插入成功");
    };
}

/**
 添加多条聊天信息
 
 @param arr 聊天信息数组
 */
- (void)addChatRecordList:(NSArray *)arr {
    for (NSDictionary *dic in arr)
    {
        QJKJChatInfoModel *chatInfo = [[QJKJChatInfoModel alloc] init];
        NSInteger intType = [dic[@"types"] intValue];
        
        chatInfo.ciSenderId             = dic[@"mid"] ? dic[@"mid"] : @"";
        chatInfo.ciSenderName           = @"";
        chatInfo.ciReceiverId           = dic[@"manage_id"] ? dic[@"manage_id"] : @"";
        chatInfo.ciReceiverName         = @"";
        chatInfo.ciUpdateTime           = dic[@"updatetime"] ? dic[@"updatetime"] : @"";
        chatInfo.ciUpdateContent        = dic[@"content"] ? dic[@"content"] : @"";
        chatInfo.ciSmallPicture         = @"";
        if (intType == 3)
        {
            chatInfo.ciBigPicture       = dic[@"vod"] ? dic[@"vod"] : @"";
        }
        if (intType == 2)
        {
  
            QJKJPlayAudio *audioPlayer  = [[QJKJPlayAudio alloc] init];
            chatInfo.ciAudioContent     = dic[@"vod"] ? dic[@"vod"] : @"";
            chatInfo.ciAudioDuration    = [NSString stringWithFormat:@"%.0f",[audioPlayer audioPlayTimeForString:chatInfo.ciAudioContent]];
        }
        chatInfo.ciIsRead               = @"";
        chatInfo.ciMessageType          = dic[@"types"] ? dic[@"types"] : @"";
        chatInfo.ciMessageId            = dic[@"id"] ? dic[@"id"] : @"";
        chatInfo.ciUserType             = dic[@"state"] ? dic[@"state"] : @"";
        
        [self addChatRecord:chatInfo];
    }
}


/**
 修改小图
 
 @param chatInfo 聊天信息
 */
- (void)modifySmallImg:(QJKJChatInfoModel *)chatInfo {
    NSString *sql = [NSString stringWithFormat:@"UPDATE ChatRecord SET SmallImage = '%@' WHERE ID = %@",chatInfo.ciSmallPicture,chatInfo.ID];
    
    [self updateWithSQLStr:sql];
}

/**
 获取最后一条信息的 ID
 
 @param ID 当前用户id
 @return 用户id
 */
- (NSString *)getLastIDWithID:(NSInteger)ID {
    NSString *sql = [NSString stringWithFormat:@"SELECT MAX(ChatID) AS lastID FROM ChatRecord WHERE SenderUserID=%d",ID];
    FMResultSet *res = [self selectWithSQLStr:sql];
    NSString *lastID = @"0";
    while ([res next])
    {
        lastID = [res stringForColumn:@"lastID"];
    }
    if(!lastID)
    {
        lastID = @"0";
    }
    
    return lastID;
}

/**
 显示所有数据
 */
- (void)showAllData {
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM ChatRecord"];
    
    FMResultSet *res = [self selectWithSQLStr:sql];
    while ([res next])
    {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        dic[@"ID"]                  = [res stringForColumn:@"ID"];
        dic[@"SenderUserID"]        = [res stringForColumn:@"SenderUserID"];
        dic[@"SenderUserName"]      = [res stringForColumn:@"SenderUserName"];
        dic[@"ReceiverUserID"]      = [res stringForColumn:@"ReceiverUserID"];
        dic[@"ReceiverUserName"]    = [res stringForColumn:@"ReceiverUserName"];
        dic[@"Time"]                = [res stringForColumn:@"Time"];
        dic[@"Content"]             = [res stringForColumn:@"Content"];
        //dic[@"SmallImage"]          = [res stringForColumn:@"SmallImage"];
        //dic[@"BigImage"]            = [res stringForColumn:@"BigImage"];
        //dic[@"Audio"]               = [res stringForColumn:@"Audio"];
        //dic[@"AudioDuration"]       = [res stringForColumn:@"AudioDuration"];
        dic[@"IsRead"]              = [res stringForColumn:@"IsRead"];
        dic[@"MessageType"]         = [res stringForColumn:@"MessageType"];
        dic[@"ChatID"]              = [res stringForColumn:@"ChatID"];
        NSLog(@"%@",dic);
    }
}

/**
 获取数据数量
 
 @param sendID 发送者id
 @param receiverID 接受者id
 @return 消息数量
 */
- (NSInteger)getRowNumWithSend:(NSInteger)sendID
                      receiver:(NSInteger)receiverID {
    NSString *sql = [NSString stringWithFormat:@"SELECT COUNT(ID) AS rowNum FROM ChatRecord WHERE SenderUserID=%d AND ReceiverUserID=%d",sendID,receiverID];
    FMResultSet *res = [self selectWithSQLStr:sql];
    NSInteger intRowNum = 0;
    while ([res next])
    {
        intRowNum = [res intForColumn:@"rowNum"];
    }
    
    return intRowNum;
}

@end
