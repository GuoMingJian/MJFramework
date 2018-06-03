//
//  UIColor+MJExt.h
//  MJFramework
//
//  Created by 郭明健 on 2018/6/2.
//  Copyright © 2018年 GuoMingJian. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define kRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]
#define kRandomColor kRGBColor(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256))

@interface UIColor (MJExt)

/**
 十六进制转Color
 */
+ (UIColor *)colorWithHex:(NSString *)hexStr;

/**
 十六进制转Color；alpha：透明度
 */
+ (UIColor *)colorWithHex:(NSString *)hexStr alpha:(CGFloat)alpha;

/**
 Color转十六进制
 */
+ (NSString *)hexStringFromUIColor:(UIColor *)color;

@end
