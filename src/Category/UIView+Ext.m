//
//  UIView+Ext.m
//  OC_MJFramework
//
//  Created by 郭明健 on 2020/3/22.
//  Copyright © 2020 GuoMingJian. All rights reserved.
//

#import "UIView+Ext.h"

CGPoint CGRectGetCenter(CGRect rect)
{
    CGPoint pt;
    pt.x = CGRectGetMidX(rect);
    pt.y = CGRectGetMidY(rect);
    return pt;
}

CGRect CGRectMoveToCenter(CGRect rect, CGPoint center)
{
    CGRect newrect = CGRectZero;
    newrect.origin.x = center.x - CGRectGetMidX(rect);
    newrect.origin.y = center.y - CGRectGetMidY(rect);
    newrect.size = rect.size;
    return newrect;
}

@implementation UIView (Ext)

/// orgin
- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)aPoint
{
    CGRect newframe = self.frame;
    newframe.origin = aPoint;
    self.frame = newframe;
}

/// size
- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)aSize
{
    CGRect newframe = self.frame;
    newframe.size = aSize;
    self.frame = newframe;
}

/// 高
- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)newheight
{
    CGRect newframe = self.frame;
    newframe.size.height = newheight;
    self.frame = newframe;
}

/// 宽
- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)newwidth
{
    CGRect newframe = self.frame;
    newframe.size.width = newwidth;
    self.frame = newframe;
}

/// 上
- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)newtop
{
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}

/// 下
- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)newbottom
{
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}

/// 左
- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat) newleft
{
    CGRect newframe = self.frame;
    newframe.origin.x = newleft;
    self.frame = newframe;
}

/// 右
- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat) newright
{
    CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}

/// 左上
- (CGPoint)topLeft
{
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(x, y);
}

/// 右上
- (CGPoint)topRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(x, y);
}

/// 左下
- (CGPoint)bottomLeft
{
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

/// 右下
- (CGPoint)bottomRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

/// 移动
- (void)moveBy:(CGPoint)delta
{
    CGPoint newcenter = self.center;
    newcenter.x += delta.x;
    newcenter.y += delta.y;
    self.center = newcenter;
}

/// 缩放
- (void)scaleBy:(CGFloat)scaleFactor
{
    CGRect newframe = self.frame;
    newframe.size.width *= scaleFactor;
    newframe.size.height *= scaleFactor;
    self.frame = newframe;
}

/// 自适应变小
- (void)fitInSize:(CGSize)aSize
{
    CGFloat scale;
    CGRect newframe = self.frame;
    
    if (newframe.size.height && (newframe.size.height > aSize.height))
    {
        scale = aSize.height / newframe.size.height;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    if (newframe.size.width && (newframe.size.width >= aSize.width))
    {
        scale = aSize.width / newframe.size.width;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    self.frame = newframe;
}

#pragma mark - common methods

/// 获取当前view所在的控制器
- (UIViewController *)viewController {
    //获取当前view的superView对应的控制器
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;

}

/// 获取当前正在显示的ViewController
+ (UIViewController *)findCurrentViewController
{
    UIWindow *window = [[UIWindow alloc] init];
    if (@available(iOS 13.0, *)) {
        window = [UIApplication sharedApplication].windows.firstObject;
    } else {
        window = [UIApplication sharedApplication].keyWindow;
    }
    UIViewController *topViewController = [window rootViewController];
    //
    while (true) {
        if (topViewController.presentedViewController) {
            topViewController = topViewController.presentedViewController;
        } else if ([topViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)topViewController topViewController]) {
            topViewController = [(UINavigationController *)topViewController topViewController];
        } else if ([topViewController isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tab = (UITabBarController *)topViewController;
            topViewController = tab.selectedViewController;
        } else {
            break;
        }
    }
    return topViewController;
}

/// 获取控件截图
- (UIImage *)screenshotsImage {
    //创建一个画布
    UIGraphicsBeginImageContext(self.bounds.size);
    //把控件内容渲染到画布中
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    //把图片从画布中取出
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //结束
    UIGraphicsEndImageContext();
    return image;
}

/// 清空所有子控件
- (void)removeAllSubviews
{
    for (UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
}

/// 设置圆角
- (void)setCornerRadius:(NSInteger)value
{
    self.layer.cornerRadius = value;
    self.layer.masksToBounds = YES;
    self.clipsToBounds = YES;
}

/// 自定义设置圆角（上、下）
- (void)setCornerRadius:(UIRectCorner)rectCorner
                  value:(NSInteger)value {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(value, value)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

/// 设置边框宽度、边框颜色
- (void)setBorderWidth:(CGFloat)width
           borderColor:(UIColor *)color
{
    self.layer.borderWidth = width;
    self.layer.borderColor = [color CGColor];
}

/// 设置渐变色（UIColor）
- (void)setGradientLayer:(UIColor *)startColor
                endColor:(UIColor *)endColor {
    CGPoint startPoint = CGPointMake(0, 0);
    CGPoint endPoint = CGPointMake(1, 0);
    [self setGradientLayer:startColor endColor:endColor startPoint:startPoint endPoint:endPoint];
}

/// 设置渐变色（UIColor）
- (void)setGradientLayer:(UIColor *)startColor
                endColor:(UIColor *)endColor
              startPoint:(CGPoint)startPoint
                endPoint:(CGPoint)endPoint {
    NSMutableArray *arrM = [NSMutableArray array];
    [arrM addObject:startColor.CGColor];
    [arrM addObject:endColor.CGColor];
    CAGradientLayer *layer = [[CAGradientLayer alloc] init];
    layer.colors = arrM;
    layer.startPoint = startPoint;
    layer.endPoint = endPoint;
    layer.frame = self.bounds;
    [self.layer insertSublayer:layer atIndex:0];
}

/// 添加阴影
- (void)addShadow:(UIColor *)shadowColor
    shadowOpacity:(CGFloat)shadowOpacity
     shadowRadius:(CGFloat)shadowRadius
     shadowOffset:(CGSize)shadowOffset
     cornerRadius:(CGFloat)cornerRadius {
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOpacity = shadowOpacity;
    self.layer.shadowRadius = shadowRadius;
    self.layer.shadowOffset = shadowOffset;
    self.layer.cornerRadius = cornerRadius;
}

/// 旋转角度
- (void)Rotate:(float)degrees {
    float degree = degrees * M_PI / 180.0;
    self.transform = CGAffineTransformMakeRotation(degree);
}

#pragma mark - 验证码倒计时

/// 验证码倒计时
- (void)countDown:(int)timeOut {
    if (![self isKindOfClass:[UIButton class]]) {
        return;
    } else {
        UIButton *button = (UIButton *)self;
        //
        UIColor *bgColor = button.backgroundColor;
        UIColor *titleColor = button.titleLabel.textColor;
        UIFont *font = button.titleLabel.font;
        NSString *leftStr = @"重新发送(";
        NSString *rightStr = @"s）";
        [self countDown:timeOut runBGColor:bgColor runTitleColor:titleColor runLeftStr:leftStr runRightStr:rightStr runFont:font];
    }
}

/// 验证码倒计时
- (void)countDown:(int)timeOut
       runBGColor:(UIColor *)bgColor
    runTitleColor:(UIColor *)titleColor
       runLeftStr:(NSString *)leftStr
      runRightStr:(NSString *)rightStr
          runFont:(UIFont *)font {
    if (![self isKindOfClass:[UIButton class]]) {
        return;
    } else {
        UIButton *button = (UIButton *)self;
        UIColor *normalBGColor = button.backgroundColor;
        UIColor *normalTitleColor = button.titleLabel.textColor;
        NSString *normalText = button.titleLabel.text;
        UIFont *normalFont = button.titleLabel.font;
        //
        __block int timeout = timeOut; // 倒计时时间
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0); // 每秒执行
        dispatch_source_set_event_handler(timer, ^{
            if(timeout <= 1) { // 倒计时结束，关闭
                dispatch_source_cancel(timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                    button.userInteractionEnabled = YES;
                    button.backgroundColor = normalBGColor;
                    [button setTitleColor:normalTitleColor forState:UIControlStateNormal];
                    [button setTitle:normalText forState:UIControlStateNormal];
                    button.titleLabel.font = normalFont;
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    button.userInteractionEnabled = NO;
                    button.backgroundColor = bgColor;
                    [button setTitleColor:titleColor forState:UIControlStateNormal];
                    [button setTitle:[NSString stringWithFormat:@"%@%.2d%@", leftStr, timeout, rightStr] forState:UIControlStateNormal];
                    button.titleLabel.font = font;
                });
                timeout--;
            }
        });
        dispatch_resume(timer);
    }
}

@end
