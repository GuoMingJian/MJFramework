//
//  MJMacro.h
//  OC_MJFramework
//
//  Created by 郭明健 on 2020/3/23.
//  Copyright © 2020 GuoMingJian. All rights reserved.
//

#ifndef MJMacro_h
#define MJMacro_h

// 屏幕宽高
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

// keyWindow
#define kKeyWindow \
({UIWindow *window = [[UIWindow alloc] init];\
if (@available(iOS 13.0, *)) {\
window = [UIApplication sharedApplication].windows.firstObject;\
} else {\
window = [UIApplication sharedApplication].keyWindow;\
}\
(window);})

// 状态栏高度
#define kStatusBarHeight \
({CGFloat h = 0;\
if (@available(iOS 13.0, *)) {\
UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;\
h = statusBarManager.statusBarFrame.size.height;\
} else { \
h = [UIApplication sharedApplication].statusBarFrame.size.height;\
}\
(h);})
// 导航栏Bar高度
#define kNavigationBarHeight [[UINavigationController alloc] init].navigationBar.frame.size.height
// 导航高度
#define kNavigationHeight kStatusBarHeight + kNavigationBarHeight
// tabBar高度
#define kTabBarHeight [[UITabBarController alloc] init].tabBar.frame.size.height

// 弱引用/强引用
#define kWeakSelf(type) __weak typeof(type) weak##type = type;
#define kStrongSelf(type) __strong typeof(type) type = weak##type;

// 判断是否为iPhone
#define kISiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
// 判断是否为iPad
#define kISiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// 4.7寸屏幕为标准进行适配
#define kWidth(R) (R)*(kScreenWidth)/375.0
#define kHeight(R) (R)*(kScreenHeight)/667.0
#define kFontSize(R) (R)*(kScreenWidth)/375.0

// 判断是否为iPhoneX (刘海屏幕)
#define IPHONE_X \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})
//
#define kSafeAreaStateBarHeight (IPHONE_X ? 44 : 20)
#define kSafeAreaTopHeight (IPHONE_X ? 88 : 64)
#define kSafeAreaBottomHeight (IPHONE_X ? (49 + 34) : 49)

// 字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
// 数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
// 字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
// 是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

// 一些缩写
#define kUserDefaults [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]

// 系统版本
#define IOS8 @available(iOS 8.0, *)
#define IOS9 @available(iOS 9.0, *)
#define IOS10 @available(iOS 10.0, *)
#define IOS11 @available(iOS 11.0, *)
#define IOS12 @available(iOS 12.0, *)
#define IOS13 @available(iOS 13.0, *)

// 获取沙盒Document路径
#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
// 获取沙盒temp路径
#define kTempPath NSTemporaryDirectory()
// 获取沙盒Cache路径
#define kCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

// 开发的时候打印，但是发布的时候不打印的NSLog
#ifdef DEBUG
//#define NSLog(...) NSLog(@"%s 第%d行 \n%@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define NSLog(...)
#endif

// 由角度转换弧度
#define kDegreesToRadian(x) (M_PI * (x) / 180.0)
// 由弧度转换角度
#define kRadianToDegrees(radian) (radian * 180.0) / (M_PI)

// 获取一段时间间隔
#define kStartTime CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define kEndTime NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start);

#endif /* MJMacro_h */
