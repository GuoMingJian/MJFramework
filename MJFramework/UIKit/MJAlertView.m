//
//  MJAlertView.m
//  OC_MJFramework
//
//  Created by 郭明健 on 2020/3/23.
//  Copyright © 2020 GuoMingJian. All rights reserved.
//

#import "MJAlertView.h"
//
#import "MJMacro.h"
#import "UIFont+Ext.h"
#import "UIColor+Ext.h"
#import "NSString+Ext.h"
#import "UIView+Ext.h"

@interface MJAlertView() <UIGestureRecognizerDelegate>

/// 动态技术传入内容所占高度
@property (assign, nonatomic) CGFloat contentHeight;

@end

@implementation MJAlertView

#pragma mark - private

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initData];
    }
    return self;
}

- (id)init {
    if (self = [super init]) {
        [self initData];
    }
    return self;
}

/// 初始化数据
- (void)initData {
    self.isCanClickBackgroundView = YES;
    self.isOneButtonStyle = YES;
    self.isShowTitle = NO;
    self.TitleString = @"提示";
    self.contentString = @"这是一个有个性的弹窗！";
    self.confirmBtnString = @"我知道了";
    self.leftBtnString = @"取消";
    self.rightBtnString = @"确定";
    //
    self.spaceOfWindow = kWidth(kSpaceOfWindow);
    self.spaceOfAlert = kSpaceOfAlert;
    self.titleTop = kTitleTop;
    self.titleHeight = kTitleHeight;
    self.contentTop = kContentTop;
    self.contentBottom = kContentBottom;
    self.lineHeight = kLineHeight;
    self.buttonHeight = kButtonHeight;
    self.maxAlertHeight = kmaxAlertHeight;
    self.alertRadius = kAlertRadius;
    //
    self.alertBackgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.3];
    self.alertTitleColor = [UIColor colorWithHexString:@"#030303"];
    self.alertTitleFont = [UIFont PFRegular:16];
    self.alertContentColor = [UIColor colorWithHexString:@"#1F2240"];
    self.alertContentFont = [UIFont PFRegular:13];
    self.alertButtonColor = [UIColor colorWithHexString:@"#007AFF"];
    self.alertButtonFont = [UIFont PFRegular:17];
    self.alertLineColor = [UIColor colorWithHexString:@"#EDEDF6"];
}

/// 更新弹窗布局
- (void)updateUI {
    // 清空子控件
    [self removeAllSubviews];
    // 灰色背景view
    self.backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    self.backgroundView.backgroundColor = self.alertBackgroundColor;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBgView:)];
    tapGesture.delegate = self;
    [self.backgroundView addGestureRecognizer:tapGesture];
    [self addSubview:self.backgroundView];
    // 计算内容文本高度
    CGFloat displayWidth = self.frame.size.width - (self.spaceOfWindow + self.spaceOfAlert) * 2;
    CGSize displaySize = CGSizeMake(displayWidth, MAXFLOAT);
    CGRect rect = [self.contentString textRect:self.alertContentFont displaySize:displaySize];
    //
    self.titleHeight = self.isShowTitle ? self.titleHeight : 0;
    self.titleTop = self.isShowTitle ? self.titleTop : 0;
    // 弹窗除去内容高度的高度。
    CGFloat tempHeight = self.titleTop + self.titleHeight + self.contentTop + self.contentBottom + self.lineHeight + self.buttonHeight;
    CGFloat height = tempHeight + rect.size.height;
    // 判断是否超出滚动临界
    BOOL isOverHeight = height > self.maxAlertHeight;
    height = isOverHeight ? self.maxAlertHeight : height;
    self.contentHeight = isOverHeight ? (height - tempHeight) : rect.size.height;
    //
    // 内容view
    CGFloat w = displayWidth + self.spaceOfAlert * 2;
    CGFloat x = (kScreenWidth - w) / 2.0;
    CGFloat y = (kScreenHeight - height) / 2.0;
    CGFloat h = height;
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    [self.contentView setCornerRadius:self.alertRadius];
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.backgroundView addSubview:self.contentView];
    // 标题
    x = self.spaceOfAlert;
    y = self.titleTop;
    w = w - x * 2;
    h = self.titleHeight;
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    self.titleLabel.text = self.TitleString;
    self.titleLabel.textColor = self.alertTitleColor;
    self.titleLabel.font = self.alertTitleFont;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];
    // 内容
    y = y + h + self.contentTop;
    h = self.contentHeight;
    self.contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    [self.contentTextView setScrollEnabled:isOverHeight];
    self.contentTextView.text = self.contentString;
    if (self.contentHeight > 20) {
        self.contentTextView.textAlignment = NSTextAlignmentLeft;
    } else {
        self.contentTextView.textAlignment = NSTextAlignmentCenter;
    }
    self.contentTextView.textColor = self.alertContentColor;
    self.contentTextView.font = self.alertContentFont;
    [self.contentTextView setEditable:NO];
    // 适配深色模式
    self.contentTextView.backgroundColor = [UIColor whiteColor];
    self.contentTextView.textColor = [UIColor getDynamicColorWithLight:[UIColor blackColor] dark:[UIColor blackColor]];
    // 去除内边距
    self.contentTextView.textContainer.lineFragmentPadding = 0;
    self.contentTextView.textContainerInset = UIEdgeInsetsZero;
    [self.contentView addSubview:self.contentTextView];
    // 底部view
    x = 0;
    y = y + h + self.contentBottom;
    w = self.contentView.width;
    h = self.lineHeight + self.buttonHeight;
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    [self.contentView addSubview:self.bottomView];
    // 线
    y = 0;
    h = self.lineHeight;
    self.hLineView = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    self.hLineView.backgroundColor = self.alertLineColor;
    [self.bottomView addSubview:self.hLineView];
    if (self.isOneButtonStyle) {
        // 单按钮模式
        self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        y = y + h;
        h = self.buttonHeight;
        self.confirmButton.frame = CGRectMake(x, y, w, h);
        [self.confirmButton setTitle:self.confirmBtnString forState:UIControlStateNormal];
        [self.confirmButton setTitleColor:self.alertButtonColor forState:UIControlStateNormal];
        self.confirmButton.titleLabel.font = self.alertButtonFont;
        self.confirmButton.tag = 100;
        [self.confirmButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:self.confirmButton];
    } else {
        // 双按钮模式
        // 线
        y = y + h;
        w = self.lineHeight;
        h = self.buttonHeight;
        x = (self.contentView.width - w) / 2.0;
        self.vLineView = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        self.vLineView.backgroundColor = self.alertLineColor;
        [self.bottomView addSubview:self.vLineView];
        // 左按钮
        w = x;
        x = 0;
        self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftButton.frame = CGRectMake(x, y, w, h);
        [self.leftButton setTitle:self.leftBtnString forState:UIControlStateNormal];
        [self.leftButton setTitleColor:self.alertButtonColor forState:UIControlStateNormal];
        self.leftButton.titleLabel.font = self.alertButtonFont;
        self.leftButton.tag = 100;
        [self.leftButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:self.leftButton];
        // 右按钮
        x = self.vLineView.origin.x + self.vLineView.width;
        self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightButton.frame = CGRectMake(x, y, w, h);
        [self.rightButton setTitle:self.rightBtnString forState:UIControlStateNormal];
        [self.rightButton setTitleColor:self.alertButtonColor forState:UIControlStateNormal];
        self.rightButton.titleLabel.font = self.alertButtonFont;
        self.rightButton.tag = 100 + 1;
        [self.rightButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:self.rightButton];
    }
}

/// 展示弹窗 (传入view为nil时，则展示在keyWindow)
- (void)showAtView:(UIView *)view
        clickBlock:(ClickButtonCallback)clickBlock {
    if (view == nil || ![view isKindOfClass:[UIView class]]) {
        [kKeyWindow addSubview:self];
    } else {
        [view addSubview:self];
    }
    self.clickButtonCallback = clickBlock;
}

/// 移除弹窗
- (void)hidenView {
    [self removeFromSuperview];
}

#pragma mark - actions

/// 灰色view点击手势
- (void)tapBgView:(UITapGestureRecognizer *)gesture {
    if (self.isCanClickBackgroundView) {
        [self hidenView];
    }
}

/// 按钮点击事件
- (void)clickButton:(UIButton *)btn {
    if (self.clickButtonCallback) {
        int index = (int)(btn.tag - 100);
        self.clickButtonCallback(index, btn);
    }
    [self hidenView];
}


#pragma mark - public

/// 获取弹窗（无标题、单按钮、内容与顶部间距30px）
/// @param content 弹窗内容
+ (id)getAlertWithContent:(NSString *)content {
    return [self getAlertWithContent:content topSpace:30];
}

/// 获取弹窗（无标题、单按钮）
/// @param content 弹窗内容
/// @param topSpace 内容与顶部间距
+ (id)getAlertWithContent:(NSString *)content
                 topSpace:(CGFloat)topSpace {
    MJAlertView *alertView = [[MJAlertView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    alertView.isShowTitle = NO;
    alertView.contentString = content;
    alertView.isOneButtonStyle = YES;
    alertView.contentTop = topSpace;
    alertView.contentBottom = topSpace;
    //
    [alertView updateUI];
    return alertView;
}

/// 获取弹窗（可选显示标题、单按钮）
/// @param title 当title内容为空时，隐藏title
/// @param content 弹窗内容
/// @param confirmBtnText 按钮文本
+ (id)getAlertWithTitle:(NSString *)title
                content:(NSString *)content
         confirmBtnText:(NSString *)confirmBtnText {
    MJAlertView *alertView = [[MJAlertView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    if (title.length > 0) {
        alertView.isShowTitle = YES;
        alertView.TitleString = title;
    }
    alertView.contentString = content;
    alertView.isOneButtonStyle = YES;
    if (confirmBtnText.length > 0) {
        alertView.confirmBtnString = confirmBtnText;
    }
    //
    [alertView updateUI];
    return alertView;
}

/// 获取弹窗（可选显示标题、双按钮）
/// @param title 当title内容为空时，隐藏title
/// @param content 弹窗内容
/// @param leftBtnText 左按钮文本
/// @param rightBtnText 右按钮文本
+ (id)getAlertWithTitle:(NSString *)title
                content:(NSString *)content
            leftBtnText:(NSString *)leftBtnText
           rightBtnText:(NSString *)rightBtnText {
    MJAlertView *alertView = [[MJAlertView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    if (title.length > 0) {
        alertView.isShowTitle = YES;
        alertView.TitleString = title;
    }
    alertView.contentString = content;
    alertView.isOneButtonStyle = NO;
    //
    alertView.leftBtnString = leftBtnText;
    alertView.rightBtnString = rightBtnText;
    //
    [alertView updateUI];
    return alertView;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.contentView]) {
        return NO; // 点击 contentView时，不透传点击事件
    }
    return YES;
}

@end
