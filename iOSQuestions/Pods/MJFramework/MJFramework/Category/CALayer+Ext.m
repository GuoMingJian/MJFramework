//
//  CALayer+Ext.m
//  OC_MJFramework
//
//  Created by 郭明健 on 2020/3/23.
//  Copyright © 2020 GuoMingJian. All rights reserved.
//

#import "CALayer+Ext.h"

@implementation CALayer (Ext)

/// 抖动动画
- (void)shake {
    [self shake:8 duration:0.3 repeatCount:2];
}

/// 抖动动画
- (void)shake:(CGFloat)width
     duration:(CGFloat)duration
  repeatCount:(int)repeatCount {
    CAKeyframeAnimation *kfa = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    CGFloat s = width;
    kfa.values = @[@(-s),@(0),@(s),@(0),@(-s),@(0),@(s),@(0)];
    //时长
    kfa.duration = duration;
    //重复
    kfa.repeatCount = repeatCount;
    //移除
    kfa.removedOnCompletion = YES;
    [self addAnimation:kfa forKey:@"shake"];
}

/// 旋转动画
- (void)startRotationAnimation {
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2.0];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = ULLONG_MAX;
    [self addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

/// 停止所有动画
- (void)stopAnimation {
    [self removeAllAnimations];
}

@end
