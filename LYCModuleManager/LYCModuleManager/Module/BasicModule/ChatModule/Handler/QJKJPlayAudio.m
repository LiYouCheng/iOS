//
//  QJKJPlayAudio.m
//  weiGuanJia
//
//  Created by 城李 on 15/11/4.
//  Copyright © 2015年 深圳市齐家互联网科技有限公司. All rights reserved.
//

#import "QJKJPlayAudio.h"

#import <AVFoundation/AVFoundation.h>

@interface QJKJPlayAudio ()
<AVAudioPlayerDelegate>

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@end

@implementation QJKJPlayAudio

- (void)playWithData:(NSData *)audioData
{
    if ([audioData isEqualToData:self.audioPlayer.data])
    {
        [self stopPlay];
        return;
    }
    
    [self stopPlay];
    
    NSError *error;
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error: nil];
    
    self.audioPlayer = [[AVAudioPlayer alloc] initWithData:audioData error:&error];
    [self.audioPlayer setVolume:1.0f];;
    [self.audioPlayer setDelegate:self];
    if (error)
    {
        NSLog(@"error:%@",[error description]);
        return;
    }
    //准备播放
    [self.audioPlayer prepareToPlay];
    //播放
    [self.audioPlayer play];
}

//播放时间
- (NSTimeInterval)audioPlayTimeForData:(NSData *)data
{
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithData:data error:nil];
    
    return audioPlayer.duration;
}

- (void)stopPlay
{
    if (self.audioPlayer && self.audioPlayer.isPlaying == YES)
    {
        [self.audioPlayer stop];
        self.audioPlayer.delegate = nil;
        self.audioPlayer = nil;
    }
}

#pragma mark - AVAudioPlayerDelegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    DLog(@"播放完成---");
    [self.audioPlayer stop];
    self.audioPlayer.delegate = nil;
    self.audioPlayer = nil;
    
    if (_delegate && [_delegate respondsToSelector:@selector(playFinish)]) {
        [_delegate playFinish];
    }
}

@end
