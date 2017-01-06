//
//  QJKJChatInfoModel.m
//  LYCModuleManager
//
//  Created by YouchengLi on 2017/1/6.
//  Copyright © 2017年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import "QJKJChatInfoModel.h"

@implementation QJKJChatInfoModel

- (QJKJChatInfoModel *)init
{
    self = [super init];
    if (self)
    {
        self.ID                = @"";
        self.ciSenderId        = @"";
        self.ciSenderName      = @"";
        self.ciReceiverId      = @"";
        self.ciReceiverName    = @"";
        self.ciUpdateTime      = @"";
        self.ciUpdateContent   = @"";
        self.ciMessageType     = @"";
        self.ciUserType        = @"";
        self.ciIsRead          = @"";
        self.ciMessageId       = @"";
        self.ciSmallPicture    = @"";
        self.ciBigPicture      = @"";
        self.ciAudioContent    = @"";
        self.ciAudioDuration   = @"";
    }
    
    return self;
}

@end
