//
//  MJSoundPlayer.m
//  ZXToolProjects
//
//  Created by 郭明健 on 2018/6/25.
//  Copyright © 2018年 GuoMingJian. All rights reserved.
//

#import "MJSoundPlayer.h"

@implementation MJSoundPlayer

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static MJSoundPlayer *player = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (player == nil) {
            player = [super allocWithZone:zone];
            //初始化配置
            [player setDefaultWithVolume:-1.0 rate:0.5 pitchMultiplier:-1.0];
        }
    });
    return player;
}

+ (instancetype)shareInstance
{
    return [[MJSoundPlayer alloc] init];
}

#pragma mark - TTS

/**
 *  设置播放的声音参数 如果选择默认请传入 -1.0
 *
 *  @param aVolume          音量（0.0~1.0）默认为1.0
 *  @param aRate            语速（0.0~1.0）
 *  @param aPitchMultiplier 语调 (0.5-2.0)
 */
- (void)setDefaultWithVolume:(float)aVolume
                        rate:(CGFloat)aRate
             pitchMultiplier:(CGFloat)aPitchMultiplier
{
    self.volume = (aVolume == -1.0) ? 1 : aVolume;
    self.rate = (aRate == -1.0) ? 1 : aRate;
    self.pitchMultiplier = (aPitchMultiplier == -1.0) ? 1 : aPitchMultiplier;
}

/**
 开始播放文字
 */
- (void)playMsg:(NSString *)string
{
    if(string && string.length > 0)
    {
        NSError *error;
        //后台继续播放
        [[AVAudioSession sharedInstance] setActive:YES error:&error];
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
        //
        _speechPlayer = [[AVSpeechSynthesizer alloc] init];
        AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:string];
        utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
        utterance.rate = self.rate;
        utterance.volume = self.volume;
        utterance.pitchMultiplier = self.pitchMultiplier;
        utterance.postUtteranceDelay = 1;
        [_speechPlayer speakUtterance:utterance];
    }
}

/**
 停止播放文字
 */
- (void)stopPlayMsg;
{
    [_speechPlayer pauseSpeakingAtBoundary:AVSpeechBoundaryWord];
    [_speechPlayer stopSpeakingAtBoundary:AVSpeechBoundaryWord];
    _speechPlayer = nil;
}

#pragma mark - AVAudioPlayer

/**
 播放制定路径的音频文件
 */
- (void)playAudioWithURL:(NSURL *)fileURL
{
    NSError *error;
    //后台继续播放
    [[AVAudioSession sharedInstance] setActive:YES error:&error];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
    //播放
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&error];
    if (!_audioPlayer) {
        NSError *playerIninError;
        NSData *audioData = [NSData dataWithContentsOfFile:fileURL.absoluteString];
        _audioPlayer = [[AVAudioPlayer alloc] initWithData:audioData fileTypeHint:AVFileTypeMPEGLayer3
                                                     error:&playerIninError];
    }
    [_audioPlayer play];
}

/**
 播放制定路径的音频文件
 */
- (void)playAudioWithPath:(NSString *)filePath
{
    NSError *error;
    //后台继续播放
    [[AVAudioSession sharedInstance] setActive:YES error:&error];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
    //播放
    NSData *audioData = [NSData dataWithContentsOfFile:filePath];
    _audioPlayer = [[AVAudioPlayer alloc] initWithData:audioData fileTypeHint:AVFileTypeMPEGLayer3
                                                 error:&error];
    [_audioPlayer play];
}

/**
 停止播放音频文件
 */
- (void)stopPlayAudio
{
    [_audioPlayer stop];
    _audioPlayer = nil;
}

@end
