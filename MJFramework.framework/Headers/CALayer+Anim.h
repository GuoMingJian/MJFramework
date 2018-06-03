//
//  CALayer+Anim.h
//  MJFramework
//
//  Created by 郭明健 on 2018/6/2.
//  Copyright © 2018年 GuoMingJian. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (Anim)

/**
 抖动动画
 */
- (void)shake;

/**
 旋转动画
 */
- (void)startRotationAnimation;

/**
 停止旋转动画
 */
- (void)stopRotationAnimation;

@end
