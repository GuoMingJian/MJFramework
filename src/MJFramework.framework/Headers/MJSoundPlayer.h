//
//  MJSoundPlayer.h
//  MJFramework
//
//  Created by 郭明健 on 2018/6/2.
//  Copyright © 2018年 GuoMingJian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
 用法：
 //播放本地音频文件(test.caf)
 NSURL *mediaURL = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"caf"];
 [[MJSoundPlayer shareInstance] playAudioWithURL:mediaURL];

 //播放通知带过来的文字
 MJSoundPlayer *player = [MJSoundPlayer shareInstance];
 [player setDefaultWithVolume:-1.0 rate:0.4 pitchMultiplier:-1.0];
 [player play:@"通知：明天不用上班了！"];
 */

@interface MJSoundPlayer : NSObject

@property(nonatomic,assign)float volume;            //音量
@property(nonatomic,assign)float rate;              //语速
@property(nonatomic,assign)float pitchMultiplier;   //音调
@property(nonatomic,assign)BOOL  autoPlay;          //自动播放

+ (instancetype)shareInstance;

/**
 *  设置播放的声音参数 如果选择默认请传入 -1.0
 *
 *  @param aVolume          音量（0.0~1.0）默认为1.0
 *  @param aRate            语速（0.0~1.0）
 *  @param aPitchMultiplier 语调 (0.5-2.0)
 */
- (void)setDefaultWithVolume:(float)aVolume
                        rate:(CGFloat)aRate
             pitchMultiplier:(CGFloat)aPitchMultiplier;

/**
 开始播放文字
 */
- (void)play:(NSString *)string;

/**
 播放制定路径的音频文件
 */
- (void)playAudioWithURL:(NSURL *)fileURL;

@end
