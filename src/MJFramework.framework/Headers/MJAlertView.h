//
//  MJAlertView.h
//  OC_MJFramework
//
//  Created by 郭明健 on 2020/3/23.
//  Copyright © 2020 GuoMingJian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 默认常量

/// 对话框距离屏幕的间距，默认：以4.7寸屏 50px为基准
static CGFloat kSpaceOfWindow = 50;
/// 内容文本与弹窗框的间距，默认：17px
static CGFloat kSpaceOfAlert = 17;
/// 标题距离顶部间距，默认：20px
static CGFloat kTitleTop = 20;
/// 标题高度，默认：20px
static CGFloat kTitleHeight = 20;
/// 内容距离标题间距，默认：20px
static CGFloat kContentTop = 20;
/// 内容距离底部按钮间距，默认：20px
static CGFloat kContentBottom = 20;
/// 线高度，默认：1px
static CGFloat kLineHeight = 1;
/// 按钮高度，默认：42px
static CGFloat kButtonHeight = 42;
/// 设置弹窗可滚动临界点，默认400px（整个弹窗的高度）
static CGFloat kmaxAlertHeight = 400;
/// 弹窗圆角，默认：5px
static CGFloat kAlertRadius = 5;

@interface MJAlertView : UIView

#pragma mark - 基本属性

/// 是否可点击灰色背景隐藏弹窗，默认 YES
@property (assign, nonatomic) BOOL isCanClickBackgroundView;
/// 单按钮样式，默认：YES
@property (assign, nonatomic) BOOL isOneButtonStyle;
/// 是否显示标题，默认：NO
@property (assign, nonatomic) BOOL isShowTitle;
/// 标题，默认："提示"
@property (copy, nonatomic) NSString * TitleString;
/// 内容，默认："这是一个有个性的弹窗！"
@property (copy, nonatomic) NSString * contentString;
/// 单按钮模式：按钮文本，默认："我知道了"
@property (copy, nonatomic) NSString * confirmBtnString;
/// 双按钮模式：按钮文本，默认："取消"
@property (copy, nonatomic) NSString * leftBtnString;
/// 双按钮模式：按钮文本，默认："确定"
@property (copy, nonatomic) NSString * rightBtnString;
// ********************************************* //
/// 对话框距离屏幕的间距，默认：以4.7寸屏 50px为基准
@property (assign, nonatomic) CGFloat spaceOfWindow;
/// 内容文本与弹窗框的间距，默认：17px
@property (assign, nonatomic) CGFloat spaceOfAlert;
/// 标题距离顶部间距，默认：20px
@property (assign, nonatomic) CGFloat titleTop;
/// 标题高度，默认：20px
@property (assign, nonatomic) CGFloat titleHeight;
/// 内容距离标题间距，默认：20px
@property (assign, nonatomic) CGFloat contentTop;
/// 内容距离底部按钮间距，默认：20px
@property (assign, nonatomic) CGFloat contentBottom;
/// 线高度，默认：1px
@property (assign, nonatomic) CGFloat lineHeight;
/// 按钮高度，默认：42px
@property (assign, nonatomic) CGFloat buttonHeight;
/// 设置弹窗可滚动临界点，默认400px（整个弹窗的高度）
@property (assign, nonatomic) CGFloat maxAlertHeight;
// ********************************************* //
/// 弹窗背景颜色
@property (strong, nonatomic) UIColor *alertBackgroundColor;
/// 弹窗圆角，默认：5px
@property (assign, nonatomic) CGFloat alertRadius;
/// 弹窗标题颜色
@property (strong, nonatomic) UIColor *alertTitleColor;
/// 弹窗标题字体
@property (strong, nonatomic) UIFont *alertTitleFont;
/// 弹窗内容颜色
@property (strong, nonatomic) UIColor *alertContentColor;
/// 弹窗内容字体
@property (strong, nonatomic) UIFont *alertContentFont;
/// 按钮颜色
@property (strong, nonatomic) UIColor *alertButtonColor;
/// 按钮字体
@property (strong, nonatomic) UIFont *alertButtonFont;
/// 线颜色
@property (strong, nonatomic) UIColor *alertLineColor;
// ********************************************* //

@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UITextView *contentTextView;
@property (strong, nonatomic) UIView *bottomView;
@property (strong, nonatomic) UIView *hLineView;
//
@property (strong, nonatomic) UIView *vLineView;
@property (strong, nonatomic) UIButton *leftButton;
@property (strong, nonatomic) UIButton *rightButton;
@property (strong, nonatomic) UIButton *confirmButton;

#pragma mark - 点击按钮 Block
typedef void(^ClickButtonCallback)(int btnIndex, UIButton *btn);
@property (copy, nonatomic) ClickButtonCallback clickButtonCallback;

#pragma mark - private

/// 更新弹窗布局
- (void)updateUI;

/// 展示弹窗 (传入view为nil时，则展示在keyWindow)
- (void)showAtView:(UIView *)view
        clickBlock:(ClickButtonCallback)clickBlock;

/// 移除弹窗
- (void)hidenView;

#pragma mark - public

/// 获取弹窗（无标题、单按钮、内容与顶部间距30px）
/// @param content 弹窗内容
+ (id)getAlertWithContent:(NSString *)content;

/// 获取弹窗（无标题、单按钮）
/// @param content 弹窗内容
/// @param topSpace 内容与顶部间距
+ (id)getAlertWithContent:(NSString *)content
                 topSpace:(CGFloat)topSpace;

/// 获取弹窗（可选显示标题、单按钮）
/// @param title 当title内容为空时，隐藏title
/// @param content 弹窗内容
/// @param confirmBtnText 按钮文本
+ (id)getAlertWithTitle:(NSString *)title
                content:(NSString *)content
         confirmBtnText:(NSString *)confirmBtnText;

/// 获取弹窗（可选显示标题、双按钮）
/// @param title 当title内容为空时，隐藏title
/// @param content 弹窗内容
/// @param leftBtnText 左按钮文本
/// @param rightBtnText 右按钮文本
+ (id)getAlertWithTitle:(NSString *)title
                content:(NSString *)content
            leftBtnText:(NSString *)leftBtnText
           rightBtnText:(NSString *)rightBtnText;

@end

NS_ASSUME_NONNULL_END
