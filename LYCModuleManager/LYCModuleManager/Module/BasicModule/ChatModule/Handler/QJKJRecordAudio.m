//
//  QJKJRecordAudio.m
//  weiGuanJia
//
//  Created by 城李 on 15/11/4.
//  Copyright © 2015年 深圳市齐家互联网科技有限公司. All rights reserved.
//

// --录音
#import "QJKJRecordAudio.h"

#import <AVFoundation/AVFoundation.h>

#import "amrFileCodec.h"

//录音最长时间
#define TimeLimit 60

@interface QJKJRecordAudio ()
<AVAudioRecorderDelegate>

@property (nonatomic, strong) AVAudioRecorder           *recorder;
@property (nonatomic, strong) NSURL                     *audioFileURL;
@property (nonatomic, assign) BOOL                      isRecording;
@property (nonatomic, strong) NSMutableDictionary       *recordSettingMutableDictionary;
@property (nonatomic, strong) NSTimer                   *timer;

@end

@implementation QJKJRecordAudio

- (void)dealloc {
    self.recorder                       = nil;
    self.audioFileURL                   = nil;
    self.recordSettingMutableDictionary = nil;
    self.timer                          = nil;
}

- (id)init
{
    self = [super init];
    if (self) {
        NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *cachePath = [cacPath objectAtIndex:0];
        self.audioFileURL = [NSURL fileURLWithPath:
                         [cachePath stringByAppendingPathComponent: [NSString stringWithFormat:@"%@.%@", @"record_cache", @"wav"]]];
        
        self.recordSettingMutableDictionary = [[NSMutableDictionary alloc] initWithCapacity:10];
        [self.recordSettingMutableDictionary setObject:[NSNumber numberWithInt: kAudioFormatLinearPCM] forKey: AVFormatIDKey];
        
        // 采样率
        [self.recordSettingMutableDictionary setObject:[NSNumber numberWithFloat:8000.0] forKey: AVSampleRateKey];
        
        // 通道的数目
        [self.recordSettingMutableDictionary setObject:[NSNumber numberWithInt:1]forKey:AVNumberOfChannelsKey];
        
        // 采样位数  默认 16
        [self.recordSettingMutableDictionary setObject:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
        
        self.recorder = [[AVAudioRecorder alloc] initWithURL:self.audioFileURL settings:self.recordSettingMutableDictionary error:nil];
        self.recorder.meteringEnabled = YES;
        self.recorder.delegate = self;
    }
    return self;
}

- (void)startRecord
{
    // 录音开始
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryRecord error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error: nil];
    
    if ([self.recorder prepareToRecord])
    {
        [self.recorder recordForDuration:TimeLimit];
        [self.recorder record];
        self.isRecording = YES;
        self.timer = [NSTimer scheduledTimerWithTimeInterval: 0.2 target: self
                                                selector: @selector(timerCallback:) userInfo: nil repeats: YES];
    }
    DLog(@"录音开始");
}

- (void)resumeRecord
{
    // 录音恢复
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryRecord error:nil];
    
    if (self.recorder && self.recorder.isRecording == NO)
    {
        self.isRecording = YES;
        [self.recorder record];
    }
    DLog(@"录音恢复");
}

- (void)pauseRecord
{
    // 录音暂停
    if (self.recorder && self.recorder.isRecording == YES)
    {
        self.isRecording = NO;
        [self.recorder pause];
    }
    DLog(@"录音暂停");
}

- (void)cancelRecord
{
    // 录音取消
    self.isRecording = NO;
    [self.recorder stop];
    if (self.timer && self.timer.isValid)
    {
        [self.timer invalidate];
    }
    DLog(@"录音取消");
}

//录音完成
- (NSDictionary *)finishRecord
{
    if (self.isRecording)
    {
        [self cancelRecord];
        
        AVURLAsset* audioAsset = [AVURLAsset URLAssetWithURL:self.audioFileURL options:nil];
        CMTime audioDuration = audioAsset.duration;
        float audioDurationSeconds = CMTimeGetSeconds(audioDuration);
        if (audioDurationSeconds < 1.0)
        {
            DLog(@"录制时间过短");
            return nil;
        }
        
        NSData *audioData = [NSData dataWithContentsOfURL:self.audioFileURL];
        
        //经过EncodeWAVToAMR转换
        audioData = EncodeWAVEToAMR(audioData, 1, 16);
        //然后在转换成string经base64处理
        NSString *audioString = [audioData base64EncodedStringWithOptions:0];
        
        //音频数据和音频时间
        NSDictionary *dic = @{ @"audioString":audioString
                               ,@"duration":[NSString stringWithFormat:@"%.0f",ceil(audioDurationSeconds)] };
        return dic;
    }
    DLog(@"录音完成");
    
    return nil;
}

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    if (self.isRecording)
    {
        AVURLAsset *audioAsset = [AVURLAsset URLAssetWithURL:self.audioFileURL options:nil];
        CMTime audioDuration = audioAsset.duration;
        float audioDurationSeconds = CMTimeGetSeconds(audioDuration);
        if (audioDurationSeconds >= TimeLimit)
        {
            DLog(@"录制时间过长");
        }
        
        [self cancelRecord];
    }
}

- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error
{
    DLog(@"录音失败");
}

// -160 表示完全安静，0 表示最大输入值
- (void)timerCallback:(NSTimer *)timer
{
    if (self.recorder)
    {
        [self.recorder updateMeters];
        //NSLog(@"------: %f ------: %f",[recorder_ averagePowerForChannel:0], [recorder_ peakPowerForChannel:0]);
        
        //        const float ALPHA = 0.05;
        //        float peakPowerForChannel = pow(10, (0.05 * [recorder_ peakPowerForChannel:0]));
        //        lowPassResults_ = ALPHA * peakPowerForChannel + (1.0 - ALPHA) * lowPassResults_;
        //        [_delegate recordSound:lowPassResults_];
        float s = 70+[self.recorder averagePowerForChannel:0];
        if (s < 0)
        {
            s = 0;
        }
        else if (s > 70)
        {
            s = 70;
        }
        
        if (_delegate && [_delegate respondsToSelector:@selector(recordAudioSound:)]) {
            [_delegate recordAudioSound:s/70];
        }
    }
}

@end
