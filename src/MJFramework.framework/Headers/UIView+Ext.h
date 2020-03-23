//
//  UIView+Ext.h
//  OC_MJFramework
//
//  Created by 郭明健 on 2020/3/22.
//  Copyright © 2020 GuoMingJian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Ext)

CGPoint CGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);

@property CGPoint origin;
@property CGSize size;
@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat bottom;
@property CGFloat left;
@property CGFloat right;

@property (readonly) CGPoint topLeft;
@property (readonly) CGPoint topRight;
@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;

- (void)moveBy:(CGPoint)delta;
- (void)scaleBy:(CGFloat)scaleFactor;
- (void)fitInSize:(CGSize)aSize;

#pragma mark - 常用方法

/// 获取控件截图
- (UIImage *)screenshotsImage;

/// 清空所有子控件
- (void)removeAllSubviews;

/// 设置圆角
- (void)setCornerRadius:(NSInteger)value;

/// 自定义设置圆角(如：[view setCornerRadius:UIRectCornerTopLeft|UIRectCornerTopRight value:10];)
- (void)setCornerRadius:(UIRectCorner)rectCorner
                  value:(NSInteger)value;

/// 设置边框宽度、边框颜色
- (void)setBorderWidth:(CGFloat)width
           borderColor:(UIColor *)color;

/// 设置渐变色（UIColor）
- (void)setGradientLayer:(UIColor *)startColor
                endColor:(UIColor *)endColor;

/// 设置渐变色（UIColor）
- (void)setGradientLayer:(UIColor *)startColor
                endColor:(UIColor *)endColor
              startPoint:(CGPoint)startPoint
                endPoint:(CGPoint)endPoint;

/// 添加阴影
- (void)addShadow:(UIColor *)shadowColor
    shadowOpacity:(CGFloat)shadowOpacity
     shadowRadius:(CGFloat)shadowRadius
     shadowOffset:(CGSize)shadowOffset
     cornerRadius:(CGFloat)cornerRadius;

/// 旋转角度
- (void)Rotate:(float)degrees;

#pragma mark - 验证码倒计时

/// 验证码倒计时
- (void)countDown:(int)timeOut;

/// 验证码倒计时
- (void)countDown:(int)timeOut
       runBGColor:(UIColor *)bgColor
    runTitleColor:(UIColor *)titleColor
       runLeftStr:(NSString *)leftStr
      runRightStr:(NSString *)rightStr
          runFont:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
