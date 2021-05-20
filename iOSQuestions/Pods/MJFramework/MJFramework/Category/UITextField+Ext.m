//
//  UITextField+Ext.m
//  OC_MJFramework
//
//  Created by 郭明健 on 2020/3/22.
//  Copyright © 2020 GuoMingJian. All rights reserved.
//

#import "UITextField+Ext.h"

@implementation UITextField (Ext)

/// 设置placeholder颜色
- (void)setPlaceholderColor:(UIColor *)color {
    NSString *subStr = self.placeholder;
    NSRange range = [subStr rangeOfString:subStr];
    UIFont *font = self.font;
    //
    [self setPlaceholderSubStr:range color:color font:font];
}

/// 设置placeholder颜色、字体
- (void)setPlaceholderColor:(UIColor *)color
                   fontSize:(CGFloat)fontSize {
    NSString *subStr = self.placeholder;
    NSRange range = [subStr rangeOfString:subStr];
    CGFloat tempSize = (fontSize < 5) ? self.font.pointSize : fontSize;
    UIFont *font = [UIFont systemFontOfSize:tempSize];
    //
    [self setPlaceholderSubStr:range color:color font:font];
}

/// 设置placeholder部分字符串的颜色、字体
- (void)setPlaceholderSubStr:(NSString *)subStr
                       color:(UIColor *)color
                    fontSize:(CGFloat)fontSize {
    NSRange range = [self.placeholder rangeOfString:subStr];
    CGFloat tempSize = (fontSize < 5) ? self.font.pointSize : fontSize;
    UIFont *font = [UIFont systemFontOfSize:tempSize];
    //
    [self setPlaceholderSubStr:range color:color font:font];
}

/// 设置placeholder部分字符串的颜色、字体
- (void)setPlaceholderSubStr:(NSRange)range
                       color:(UIColor *)color
                        font:(UIFont *)font {
    NSInteger placeholderLength = self.placeholder.length;
    if (range.location != NSNotFound && range.location < placeholderLength && (range.location + range.length <= placeholderLength))
    {
        //保留之前的attributedPlaceholder
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] init];
        [attStr appendAttributedString:self.attributedPlaceholder];
        [attStr setAttributes:@{NSForegroundColorAttributeName:color,
                                NSFontAttributeName:font} range:range];
        self.attributedPlaceholder = attStr;
    }
}

/// 设置Text左边间距
- (void)setTextLeftSpac:(CGFloat)spac {
    UIView *leftView = [[UIView alloc] init];
    leftView.frame = CGRectMake(0, 0, spac, 1);
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = leftView;
}

/// 设置字符间距
- (void)setTextSpac:(CGFloat)spac {
    NSDictionary *attrsDictionary = @{
        NSFontAttributeName: self.font,
        NSKernAttributeName:[NSNumber numberWithFloat:spac]
    };
    self.attributedText = [[NSAttributedString alloc] initWithString:self.text attributes:attrsDictionary];
}

@end
