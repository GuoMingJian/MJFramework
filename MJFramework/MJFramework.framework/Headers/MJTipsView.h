//
//  MJTipsView.h
//  OC_MJFramework
//
//  Created by 郭明健 on 2020/3/23.
//  Copyright © 2020 GuoMingJian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/*
 提示框显示的位置，默认居中
 */
typedef NS_ENUM(int, MJAlignment)
{
    Center = 0, // 居中
    Top,        // 上
    Bottom,     // 下
};

@interface MJTipsView : UIView

/// 提示框与屏幕的最小间距，默认：30
@property (nonatomic, assign) CGFloat spacOfWindow;
/// 文字与提示框间距最小间距，默认：15
@property (nonatomic, assign) CGFloat spacOfTipsView;
/// 文字字体
@property (nonatomic, strong) UIFont *textFont;
/// 是否开启文字左右对齐
@property (nonatomic, assign) BOOL isOpenTextLeftRightAlignment;

#pragma mark - 自定义提示框

/// 弹出提示框（默认居中，2s消失）
+ (void)showTipsView:(NSString *)text;

/// 弹出提示框（默认居中）
+ (void)showTipsView:(NSString *)text
            duration:(CGFloat)duration;

/// 弹出提示框（默认2s消失）
+ (void)showTipsView:(NSString *)text
           alignment:(MJAlignment)alignment;

/// 弹出提示框
+ (void)showTipsView:(NSString *)text
            duration:(CGFloat)duration
           alignment:(MJAlignment)alignment;

/// 弹窗提示框
- (void)showTipsView:(NSString *)text
            duration:(CGFloat)duration
           alignment:(MJAlignment)alignment;

@end

NS_ASSUME_NONNULL_END
