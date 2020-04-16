//
//  CALayer+Ext.h
//  OC_MJFramework
//
//  Created by 郭明健 on 2020/3/23.
//  Copyright © 2020 GuoMingJian. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (Ext)

/// 抖动动画
- (void)shake;

/// 抖动动画
- (void)shake:(CGFloat)width
     duration:(CGFloat)duration
  repeatCount:(int)repeatCount;

/// 旋转动画
- (void)startRotationAnimation;

/// 停止所有动画
- (void)stopAnimation;

@end

NS_ASSUME_NONNULL_END
