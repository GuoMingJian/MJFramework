//
//  UITextField+Ext.h
//  OC_MJFramework
//
//  Created by 郭明健 on 2020/3/22.
//  Copyright © 2020 GuoMingJian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (Ext)

/// 设置placeholder颜色
- (void)setPlaceholderColor:(UIColor *)color;

/// 设置placeholder颜色、字体
- (void)setPlaceholderColor:(UIColor *)color
                   fontSize:(CGFloat)fontSize;

/// 设置placeholder部分字符串的颜色、字体
- (void)setPlaceholderSubStr:(NSString *)subStr
                       color:(UIColor *)color
                    fontSize:(CGFloat)fontSize;

/// 设置placeholder部分字符串的颜色、字体
- (void)setPlaceholderSubStr:(NSRange)range
                       color:(UIColor *)color
                        font:(UIFont *)font;

/// 设置Text左边间距
- (void)setTextLeftSpac:(CGFloat)spac;

/// 设置字符间距
- (void)setTextSpac:(CGFloat)spac;

@end

NS_ASSUME_NONNULL_END
