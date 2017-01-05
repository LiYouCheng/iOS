//
//  QJKJRecordAudio.h
//  weiGuanJia
//
//  Created by 城李 on 15/11/4.
//  Copyright © 2015年 深圳市齐家互联网科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol QJKJRecordAudioDelegate <NSObject>
@optional
/**
 *  录音过程声音变化
 *
 *  @param percentage 声音大小
 */
- (void)recordAudioSound:(float)percentage;

@end

@interface QJKJRecordAudio : NSObject

/**
 *  录音开始
 */
- (void)startRecord;
/**
 *  录音恢复
 */
- (void)resumeRecord;
/**
 *  录音暂停
 */
- (void)pauseRecord;
/**
 *  录音取消
 */
- (void)cancelRecord;
/**
 *  录音完成
 *
 *  @return 字典中有声音数据和时间
 */
- (NSDictionary *)finishRecord;

@property (nonatomic, weak) id<QJKJRecordAudioDelegate> delegate;

@end
