//
//  UIColor+Ext.m
//  OC_MJFramework
//
//  Created by 郭明健 on 2020/3/20.
//  Copyright © 2020 GuoMingJian. All rights reserved.
//

#import "UIColor+Ext.h"

@implementation UIColor (Ext)

/// 16进制字符串 转 UIColor
/// @param hexString 16进制字符串
+ (UIColor *)colorWithHexString:(NSString *)hexString {
    return [UIColor colorWithHexString:hexString alpha:1.0f];
}

/// 16进制字符串 转 UIColor
/// @param hexString 16进制字符串
/// @param alpha 透明度
+ (UIColor *)colorWithHexString:(NSString *)hexString
                          alpha:(CGFloat)alpha {
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // 判断前缀并剪切掉
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    // R、G、B
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}

/// UIColor 转 16进制字符串
- (NSString *)hexString {
    CGFloat r, g, b, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    int rgb = (int) (r * 255.0f)<<16 | (int) (g * 255.0f)<<8 | (int) (b * 255.0f)<<0;
    NSString *result = [NSString stringWithFormat:@"#%06x", rgb];
    return [result uppercaseString];
}

/// RGB UIColor
/// @param r rad
/// @param g green
/// @param b blue
+ (UIColor *)colorWithR:(CGFloat)r
                      G:(CGFloat)g
                      B:(CGFloat)b {
    return [UIColor colorWithR:r G:g B:b alpha:1.0f];
}

/// RGB UIColor
/// @param r rad
/// @param g green
/// @param b blue
/// @param alpha 透明度
+ (UIColor *)colorWithR:(CGFloat)r
                      G:(CGFloat)g
                      B:(CGFloat)b
                  alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0];
}

/// 随机颜色
+ (UIColor *)colorWithRandom {
    return [UIColor colorWithR:arc4random_uniform(256) G:arc4random_uniform(256) B:arc4random_uniform(256)];
}

/// 主题颜色
+ (UIColor *)themeColor {
    return [UIColor colorWithHexString:kThemeColor];
}

/// 根据当前（深色-浅色）模式，获取颜色
/// @param lightColor 浅色（默认）
/// @param darkColor 深色
+ (UIColor *)getDynamicColorWithLight:(UIColor *)lightColor
                                 dark:(UIColor *)darkColor {
    if (@available(iOS 13.0, *)) {
        UIColor *dyColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trainCollection) {
            if ([trainCollection userInterfaceStyle] == UIUserInterfaceStyleLight) {
                // 浅色
                if (lightColor == nil) {
                    return [UIColor whiteColor];
                } else {
                    return lightColor;
                }
            } else {
                // 深色
                if (darkColor == nil) {
                    return [UIColor blackColor];
                } else {
                    return darkColor;
                }
            }
        }];
        return dyColor;
    } else {
        // 默认-浅色
        if (lightColor == nil) {
            return [UIColor whiteColor];
        } else {
            return lightColor;
        }
    }
}

@end
