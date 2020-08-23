//
//  MJTipsView.m
//  OC_MJFramework
//
//  Created by 郭明健 on 2020/3/23.
//  Copyright © 2020 GuoMingJian. All rights reserved.
//

#import "MJTipsView.h"

@interface MJTipsView()
//
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, assign) CGFloat timeInterval;
@property (nonatomic, assign) MJAlignment currentAlignment;
@property (nonatomic, copy) NSString *currentContent;

@end

@implementation MJTipsView

#pragma mark - 自定义提示框

/// 弹出提示框（默认居中，2s消失）
+ (void)showTipsView:(NSString *)text {
    [self showTipsView:text duration:2.0f alignment:Center];
}

/// 弹出提示框（默认居中）
+ (void)showTipsView:(NSString *)text
            duration:(CGFloat)duration {
    [self showTipsView:text duration:duration alignment:Center];
}

/// 弹出提示框（默认2s消失）
+ (void)showTipsView:(NSString *)text
           alignment:(MJAlignment)alignment {
    [self showTipsView:text duration:2.0 alignment:alignment];
}

/// 弹出提示框
+ (void)showTipsView:(NSString *)text
            duration:(CGFloat)duration
           alignment:(MJAlignment)alignment {
    MJTipsView *tipsView = [[MJTipsView alloc] init];
    [tipsView showTipsView:text duration:duration alignment:alignment];
}

#pragma mark - private Functions

- (id)init {
    if (self = [super init]) {
        [self initData];
    }
    return self;
}

/// 初始化数据
- (void)initData {
    self.spacOfWindow = 30;
    self.spacOfTipsView = 15;
    self.textFont = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    self.isOpenTextLeftRightAlignment = YES;
    self.currentAlignment = Center;
    self.currentContent = @"";
    //
    self.label = [[UILabel alloc] init];
    self.label.font = self.textFont;
    self.label.numberOfLines = 0;
    self.label.textColor = [UIColor whiteColor];
    [self addSubview:self.label];
    //
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    //
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    self.clipsToBounds = YES;

    //监听横竖屏切换
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientChange) name:UIDeviceOrientationDidChangeNotification object:nil];
}

/// 弹窗提示框
- (void)showTipsView:(NSString *)text
            duration:(CGFloat)duration
           alignment:(MJAlignment)alignment {
    self.currentAlignment = alignment;
    self.currentContent = text;
    self.timeInterval = (duration <= 0) ? 2.0f : duration;
    [self updateUI];
    UIWindow *window = [self getKeyWindow];
    [window addSubview:self];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.timeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeTipsView];
    });
}

/// 更新UI
- (void)updateUI {
    // 汉字左右对齐
    if (self.isOpenTextLeftRightAlignment) {
        NSAttributedString *attStr = [self leftRightAlignment:self.currentContent];
        self.label.attributedText = attStr;
    }
    //
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    CGFloat navigationBarH = [self getStatusBarHeight] + [[UINavigationController alloc] init].navigationBar.frame.size.height;
    CGFloat tabBarH = [[UITabBarController alloc] init].tabBar.frame.size.height;
    //
    UIWindow *keyWindow = [self getKeyWindow];
    CGRect supFrame = keyWindow.frame;
    //
    CGFloat space = (self.spacOfWindow + self.spacOfTipsView) * 2;
    CGFloat x = self.spacOfWindow;
    // 计算单行长、宽
    CGSize txtSize = [self.currentContent sizeWithAttributes:@{NSFontAttributeName:self.textFont}];
    CGFloat txtH = txtSize.height;
    if (txtSize.width > supFrame.size.width - space) {
        // 多行高度
        CGSize size = CGSizeMake(supFrame.size.width - space, screenH - space);
        CGRect rect = [self textRect:self.textFont displaySize:size text:self.currentContent];
        txtH = rect.size.height;
    } else {
        x = (supFrame.size.width - (txtSize.width + self.spacOfTipsView * 2)) / 2.0;
    }
    //
    CGFloat y = (supFrame.size.height - (txtH + self.spacOfTipsView * 2)) / 2.0; // 默认居中
    //
    switch (self.currentAlignment) {
        case 0:
            break;
        case 1:
            y = navigationBarH + self.spacOfWindow;
            break;
        case 2:
            y = supFrame.size.height - tabBarH - self.spacOfWindow - (txtH + self.spacOfTipsView * 2);
            break;
            
        default:
            break;
    }
    //
    self.frame = CGRectMake(x, y, supFrame.size.width - x * 2, txtH + self.spacOfTipsView * 2);
    //
    self.label.text = self.currentContent;
    self.label.frame = CGRectMake(self.spacOfTipsView, self.spacOfTipsView, self.frame.size.width - self.spacOfTipsView * 2, self.frame.size.height - self.spacOfTipsView * 2);
}

/// 移除TipsView
- (void)removeTipsView {
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

/// 屏幕旋转监听事件
- (void)orientChange {
    [self updateUI];
}

/// 获取KeyWindow
- (UIWindow *)getKeyWindow {
    UIWindow *window = [[UIWindow alloc] init];
    if (@available(iOS 13.0, *)) {
        window = [UIApplication sharedApplication].windows.firstObject;
    } else {
        window = [UIApplication sharedApplication].keyWindow;
    }
    return window;
}

/// 获取状态栏高度
- (CGFloat)getStatusBarHeight {
    if (@available(iOS 13.0, *)) {
        UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
        CGFloat h = statusBarManager.statusBarFrame.size.height;
        return h;
    } else {
        return [UIApplication sharedApplication].statusBarFrame.size.height;
    }
    
}

/// 字符串左右对齐
- (NSAttributedString *)leftRightAlignment:(NSString *)text {
    NSMutableAttributedString *mAbStr = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *npgStyle = [[NSMutableParagraphStyle alloc] init];
    npgStyle.alignment = NSTextAlignmentJustified;
    npgStyle.paragraphSpacing = 11.0;
    npgStyle.paragraphSpacingBefore = 10.0;
    npgStyle.firstLineHeadIndent = 0.0;
    npgStyle.headIndent = 0.0;
    NSDictionary *dic = @{
        NSParagraphStyleAttributeName :npgStyle,
        NSUnderlineStyleAttributeName :[NSNumber numberWithInteger:NSUnderlineStyleNone]
    };
    [mAbStr setAttributes:dic range:NSMakeRange(0, mAbStr.length)];
    NSAttributedString *attrString = [mAbStr copy];
    return attrString;
}

/// 文本Rect
- (CGRect)textRect:(UIFont *)font
       displaySize:(CGSize)displaySize
              text:(NSString *)text {
    NSDictionary *attributes = @{NSFontAttributeName: font};
    CGRect rect = [text boundingRectWithSize:displaySize
                                     options:NSStringDrawingTruncatesLastVisibleLine
                   |NSStringDrawingUsesLineFragmentOrigin
                   |NSStringDrawingUsesFontLeading
                                  attributes:attributes context:nil];
    return rect;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
