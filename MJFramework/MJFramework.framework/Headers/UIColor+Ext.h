//
//  UIColor+Ext.h
//  OC_MJFramework
//
//  Created by 郭明健 on 2020/3/20.
//  Copyright © 2020 GuoMingJian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 默认主题颜色
#define kThemeColor @"#000000"

@interface UIColor (Ext)

/// 16进制字符串 转 UIColor
/// @param hexString 16进制字符串
+ (UIColor *)colorWithHexString:(NSString *)hexString;

/// 16进制字符串 转 UIColor
/// @param hexString 16进制字符串
/// @param alpha 透明度
+ (UIColor *)colorWithHexString:(NSString *)hexString
                          alpha:(CGFloat)alpha;

/// UIColor 转 16进制字符串
- (NSString *)hexString;

/// RGB UIColor
/// @param r rad
/// @param g green
/// @param b blue
+ (UIColor *)colorWithR:(CGFloat)r
                      G:(CGFloat)g
                      B:(CGFloat)b;

/// RGB UIColor
/// @param r rad
/// @param g green
/// @param b blue
/// @param alpha 透明度
+ (UIColor *)colorWithR:(CGFloat)r
                      G:(CGFloat)g
                      B:(CGFloat)b
                  alpha:(CGFloat)alpha;

/// 随机颜色
+ (UIColor *)colorWithRandom;

/// 主题颜色
+ (UIColor *)themeColor;

/// 根据当前（深色-浅色）模式，获取颜色
/// @param lightColor 浅色（默认）
/// @param darkColor 深色
+ (UIColor *)getDynamicColorWithLight:(UIColor *)lightColor
                                 dark:(UIColor *)darkColor;

@end

NS_ASSUME_NONNULL_END
