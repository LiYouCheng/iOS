//
//  QJKJChatAudioInputView.h
//  LYCModuleManager
//
//  Created by YouchengLi on 2017/1/5.
//  Copyright © 2017年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

// --语音输入

#import <UIKit/UIKit.h>

@protocol QJKJChatAudioInputViewDelegate <NSObject>

/**
 录音完成数据

 @param aduioString 数据
 */
- (void)selectAudioFinish:(NSString *)aduioString;

@end

@interface QJKJChatAudioInputView : UIView

@property (nonatomic, weak) id<QJKJChatAudioInputViewDelegate> delegate;

@end
