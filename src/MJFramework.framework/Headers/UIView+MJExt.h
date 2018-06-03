//
//  UIView+MJExt.h
//  MJFramework
//
//  Created by 郭明健 on 2018/6/2.
//  Copyright © 2018年 GuoMingJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MJExt)

CGPoint CGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);

@property CGPoint origin;
@property CGSize size;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topLeft;
@property (readonly) CGPoint topRight;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

- (void) moveBy: (CGPoint) delta;
- (void) scaleBy: (CGFloat) scaleFactor;
- (void) fitInSize: (CGSize) aSize;

#pragma mark - common methods

/**
 清空所有子控件
 */
- (void)removeAllSubviews;

/**
 设置圆角
 */
- (void)setCornerRadius:(NSInteger)value;

/**
 设置边框宽度、边框颜色
 */
- (void)setBorderWidth:(CGFloat)width borderColor:(UIColor *)color;

@end
