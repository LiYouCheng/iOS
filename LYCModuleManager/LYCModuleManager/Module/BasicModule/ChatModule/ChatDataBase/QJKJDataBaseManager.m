//
//  QJKJChatDataBaseManager.m
//  LYCModuleManager
//
//  Created by YouchengLi on 2017/1/6.
//  Copyright © 2017年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

// --聊天数据管理，后期优化

#import "QJKJDataBaseManager.h"

#import <FMDatabase.h>

static QJKJDataBaseManager *s = nil;
static dispatch_once_t predicate;
#define DEFAULT_DB_NAME @"chatDBName"

@implementation QJKJDataBaseManager {
    FMDatabase *_dataBase;
}


+ (QJKJDataBaseManager*)shareChatDBManage
{
    dispatch_once(&predicate, ^
                  {
                      s = [[self alloc] init];
                  });
    
    return s;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        NSString *docp = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
        NSString *DBPath = [docp stringByAppendingPathComponent:DEFAULT_DB_NAME];
        
        _dataBase = [[FMDatabase alloc] initWithPath:DBPath];
        [_dataBase open];
        
        // 聊天记录表
        NSString *sql = @"CREATE TABLE if not exists 'ChatRecord' ('ID' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'SenderUserID' TEXT, 'SenderUserName' TEXT, 'ReceiverUserID' TEXT, 'ReceiverUserName' TEXT, 'Time' TEXT, 'Content' TEXT, 'SmallImage' TEXT, 'BigImage' TEXT, 'Audio' TEXT, 'AudioDuration' TEXT, 'IsRead' TEXT, 'MessageType' TEXT, 'ChatID' TEXT, 'State' TEXT)";
        if ([_dataBase executeUpdate:sql])
        {
            NSLog(@"创建表 ChatRecord 成功");
        }
        else
        {
            NSLog(@"创建表 ChatRecord 失败");
        }
    }
    return self;
}

-(void)dbFail:(NSString *)sql
{
    NSLog(@"操作失败：%@",sql);
}

#pragma mark 公有方法

// 查询数据
- (FMResultSet *)selectWithSQLStr:(NSString *)sql
{
    FMResultSet *res = [_dataBase executeQuery:sql];
    if (res)
    {
        return res;
    }
    else
    {
        [self dbFail:sql];
        return nil;
    }
}

// 插入数据
- (BOOL)insertWithSQLStr:(NSString*)sql
{
    BOOL is = [_dataBase executeUpdate:sql];
    if (!is)
    {
        [self dbFail:sql];
    }
    
    return is;
}

// 修改数据
- (BOOL)updateWithSQLStr:(NSString*)sql
{
    BOOL is = [_dataBase executeUpdate:sql];
    if (!is)
    {
        [self dbFail:sql];
    }
    
    return is;
}

// 删除数据
- (BOOL)deleteWithSQLStr:(NSString*)sql
{
    BOOL is = [_dataBase executeUpdate:sql];
    if (!is)
    {
        [self dbFail:sql];
    }
    
    return is;
}

@end
