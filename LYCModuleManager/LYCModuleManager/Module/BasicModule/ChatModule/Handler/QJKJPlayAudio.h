//
//  QJKJPlayAudio.h
//  weiGuanJia
//
//  Created by 城李 on 15/11/4.
//  Copyright © 2015年 深圳市齐家互联网科技有限公司. All rights reserved.
//

// -- 播放音频
#import <Foundation/Foundation.h>

@protocol QJKJPlayAudioDelegate <NSObject>
/**
 *  播放完成
 */
- (void)playFinish;

@end

@interface QJKJPlayAudio : NSObject

@property (nonatomic, weak)id<QJKJPlayAudioDelegate> delegate;

/**
 *  开始播放
 *
 *  @param audioData 音频数据
 */
- (void)playWithData:(NSData *)audioData;
/**
 *  停止播放
 */
- (void)stopPlay;
//播放时间
- (NSTimeInterval)audioPlayTimeForData:(NSData *)data;
@end
