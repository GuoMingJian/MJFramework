//
//  UIView+Anim.h
//  MJFramework
//
//  Created by 郭明健 on 2018/6/2.
//  Copyright © 2018年 GuoMingJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Anim)

#pragma mark - Animation Funtions

/**
 跑马灯动画
 [当文本长度超出父视图的宽度才会开启动画]
 [一个手机屏幕长度的动画跑完需要的时间[默认10s]
 */
- (void)textRunningWithContent:(NSString *)content
                     textColor:(UIColor *)color
                     isTapStop:(BOOL)isTapStop;

/**
 跑马灯动画
 [当文本长度超出父视图的宽度才会开启动画]
 @param content 文本
 @param color 文本颜色
 @param isTapStop 是否可以点文本暂停动画
 @param oneScreenWidthDuration 一个手机屏幕长度的动画跑完需要的时间[默认10s]
 */
- (void)textRunningWithContent:(NSString *)content
                     textColor:(UIColor *)color
                     isTapStop:(BOOL)isTapStop
     runOneScreenWidthDuration:(CGFloat)oneScreenWidthDuration;

/**
 暂停跑马灯动画
 */
- (void)stopTextRunning;

/**
 继续跑马灯动画
 */
- (void)startTextRunning;

/**
 移除跑马灯动画
 */
- (void)removeTextRunning;

@end
