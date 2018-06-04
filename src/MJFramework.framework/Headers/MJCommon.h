//
//  MJCommon.h
//  MJFramework
//
//  Created by 郭明健 on 2018/6/2.
//  Copyright © 2018年 GuoMingJian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
 提示框显示的位置，默认居中
 */
typedef NS_ENUM(NSInteger, MJ_Alignment)
{
    MJ_Center = 0,
    MJ_Top = 1,
    MJ_Bottom = 2,
};

#pragma mark -

@interface MJCommon : NSObject

#pragma mark - 手机设备相关方法

/**
 设置是否锁屏
 */
+ (void)setLockScreen:(BOOL)isLock;

/**
 更改iOS状态栏的颜色
 */
+ (void)setStatusBarBackgroundColor:(UIColor *)color;

/**
 设置手机灯开/关
 */
+ (void)turnTorchOn:(bool)on;

#pragma mark - NSUserDefault

/**
 插入数据[NSUserDefault]
 */
+ (void)setUserDefault:(NSString *)value
                   key:(NSString *)key;

/**
 获取数据[NSUserDefault]
 */
+ (NSString *)getUserDefault:(NSString *)key;

/**
 获取数据[NSUserDefault]如果该key不存在，设置初始值
 */
+ (NSString *)getUserDefaultByKey:(NSString *)key
             ifKeyNoExistSetValue:(NSString *)value;

#pragma mark -

/**
 计算文件夹下文件的总大小(单位M)
 */
- (float)fileSizeWithPath:(NSString*)path;

/**
 设置汉字左右对齐
 */
+ (NSAttributedString *)setTextString:(NSString *)text;

#pragma mark - 提示框

/**
 弹出提示框
 */
+ (void)showTipView:(NSString *)text;

/**
 弹出提示框；duration时间后消失
 */
+ (void)showTipView:(NSString *)text
           duration:(CGFloat)duration;

/**
 弹出提示框；alignment显示位置，MJ_Top上，MJ_Center 中, MJ_Bottom 下
 */
+ (void)showTipView:(NSString *)text
          alignment:(MJ_Alignment)alignment;

/**
 弹出提示框；时间，位置
 */
+ (void)showTipView:(NSString *)text
           duration:(CGFloat)duration
          alignment:(MJ_Alignment)alignment;

#pragma mark - 倒计时按钮

/**
 自定义倒计时按钮
 
 @param supButton 倒计时按钮
 @param totalTime 倒计时时间[60]
 @param textColor 文本颜色
 @param textFont  文本字体
 @param timeAfterText 秒数后拼接的字符串[@" 秒后重发"]
 */
+ (void)startCountdownAtButton:(UIButton *)supButton
                     totalTime:(NSInteger)totalTime
                     textColor:(UIColor *)textColor
                      textFont:(UIFont *)textFont
                 timeAfterText:(NSString *)timeAfterText;

#pragma mark - 根据文本计算CGSize CGRect

/**
 文本Size
 */
+ (CGSize)textSize:(NSString *)text
              font:(UIFont *)font;

/**
 文本Rect
 */
+ (CGRect)textRect:(NSString *)text
              font:(UIFont *)font
       displaySize:(CGSize)size;

/**
 文本宽度
 */
+ (CGFloat)textWidth:(NSString *)text
                font:(UIFont *)font;

/**
 文本宽度 字体大小
 */
+ (CGFloat)textWidth:(NSString *)text
            fontSize:(CGFloat)size;

/**
 单行文本高度[文字,字体]
 */
+ (CGFloat)textHeight:(NSString *)text
                 font:(UIFont *)font;

/**
 多行文本高度[文字,字体大小,文字最大显示宽度]
 */
+ (CGFloat)multableTextHeight:(NSString *)text
                         font:(UIFont *)font
                 displayWidth:(CGFloat)displayWidth;

#pragma mark - UITextField

/**
 设置TextField placeholder 颜色，字体大小
 */
+ (void)setPlaceholderColor:(UIColor *)color
                   fontSize:(CGFloat)fonSize
                  textField:(UITextField *)textField;

/**
 设置TextField placeholder 某部分字的颜色[string]
 */
+ (void)setPlaceholderColor:(UIColor *)color
                     string:(NSString *)str
                   fontSize:(CGFloat)fonSize
                  textField:(UITextField *)textField;

/**
 设置TextField placeholder 某部分字的颜色[NSRange]
 */
+ (void)setPlaceholderColor:(UIColor *)color
                      range:(NSRange)range
                   fontSize:(CGFloat)fonSize
                  textField:(UITextField *)textField;

@end

#pragma mark - ============自定义延时消失的提示框============

@interface MJTipView : UIView

/**
 提示框与屏幕的间距
 */
@property (nonatomic, assign)CGFloat spacOfWindow;

/**
 文字与提示框间距
 */
@property (nonatomic, assign)CGFloat spacOfTipView;

/**
 文字字体
 */
@property (nonatomic, strong) UIFont *font;

/**
 *  提示框弹出
 */
- (void)showTipView:(NSString *)text
           duration:(CGFloat)duration
          alignment:(MJ_Alignment)alignment;

@end

#pragma mark - ============自定义倒计时按钮============

@interface MJCountdownButton : UIButton

+ (void)startCountdownAtButton:(UIButton *)supButton
                     totalTime:(NSInteger)totalTime
                     textColor:(UIColor *)textColor
                      textFont:(UIFont *)textFont
                 timeAfterText:(NSString *)timeAfterText;

@end
