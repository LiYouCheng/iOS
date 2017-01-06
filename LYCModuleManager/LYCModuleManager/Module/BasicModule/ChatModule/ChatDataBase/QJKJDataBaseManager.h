//
//  QJKJChatDataBaseManager.h
//  LYCModuleManager
//
//  Created by YouchengLi on 2017/1/6.
//  Copyright © 2017年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMResultSet;

typedef enum : NSUInteger {
    QJKJSendMessageText = 1,//文本
    QJKJSendMessageSound,//声音
    QJKJSendMessageImage,//图片
} QJKJSendMessageType; //消息发送类型


@interface QJKJDataBaseManager : NSObject

+ (QJKJDataBaseManager*)shareChatDBManage;

// 查询数据
- (FMResultSet*)selectWithSQLStr:(NSString*)sql;

// 插入数据
- (BOOL)insertWithSQLStr:(NSString*)sql;

// 修改数据
- (BOOL)updateWithSQLStr:(NSString*)sql;

// 删除数据
- (BOOL)deleteWithSQLStr:(NSString*)sql;

@end
