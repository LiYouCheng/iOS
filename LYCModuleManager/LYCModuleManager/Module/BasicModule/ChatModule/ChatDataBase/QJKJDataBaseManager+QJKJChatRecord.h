//
//  QJKJDataBaseManager+QJKJChatRecord.h
//  LYCModuleManager
//
//  Created by YouchengLi on 2017/1/6.
//  Copyright © 2017年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

// --聊天记录管理

#import "QJKJDataBaseManager.h"

@class QJKJChatInfoModel;

@interface QJKJDataBaseManager (QJKJChatRecord)

/**
 查询聊天记录

 @param sendID 发送者id
 @param receiverID 接受者id
 @param intPage 页码
 @return 聊天记录
 */
- (NSArray *)searchChatRecordWithSend:(NSInteger)sendID
                                    receiver:(NSInteger)receiverID
                                        page:(NSInteger)intPage;

/**
 添加一条聊天信息

 @param chatInfo 聊天信息
 */
- (void)addChatRecord:(QJKJChatInfoModel *)chatInfo;

/**
 添加多条聊天信息

 @param arr 聊天信息数组
 */
- (void)addChatRecordList:(NSArray *)arr;


/**
 修改小图

 @param chatInfo 聊天信息
 */
- (void)modifySmallImg:(QJKJChatInfoModel *)chatInfo;

/**
 获取最后一条信息的 ID

 @param ID 当前用户id
 @return 信息id
 */
- (NSString *)getLastIDWithID:(NSInteger)ID;

/**
 显示所有数据
 */
- (void)showAllData;

/**
 获取数据数量

 @param sendID 发送者id
 @param receiverID 接受者id
 @return 消息数量
 */
- (NSInteger)getRowNumWithSend:(NSInteger)sendID
                      receiver:(NSInteger)receiverID;


@end
