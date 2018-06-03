//
//  MJActivityView.h
//  MJFramework
//
//  Created by 郭明健 on 2018/6/2.
//  Copyright © 2018年 GuoMingJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJActivityView : UIView

@property (nonatomic, assign)BOOL isAnimating;

/**
 显示活动指示器
 */
+ (void)showMJActivity;

/**
 关闭活动指示器
 */
+ (void)hideMJActivity;

/**
 设置指示器颜色[默认红色]
 */
+ (void)setMJActivityColor:(UIColor *)color;

/**
 设置指示器宽度[范围30-90，不符合范围内,默认60]
 */
+ (void)setMJActivityWidth:(CGFloat)width;

/**
 设置指示器小圆点个数[范围 >=10，默认15个]
 */
+ (void)setMJActivityDotNumber:(NSInteger)dotNumber;

@end
