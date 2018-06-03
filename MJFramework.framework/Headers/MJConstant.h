//
//  MJConstant.h
//  MJFramework
//
//  Created by 郭明健 on 2018/6/2.
//  Copyright © 2018年 GuoMingJian. All rights reserved.
//

#ifndef MJConstant_h
#define MJConstant_h

#ifdef __OBJC__

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#endif

//判空处理
#define kStringIsEmpty(str) \
([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
#define kArrayIsEmpty(array) \
(array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
#define kDictIsEmpty(dic) \
(dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
#define kObjectIsEmpty(_object) \
(_object == nil || [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

//获取屏幕宽度与高度
#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
#define kNavigationBarHeight (kScreenHeight == 812.0 ? 88 : 64)
#define kTabBarHeight 49
#define kSafeAreaTopHeight (kScreenHeight == 812.0 ? 88 : 64)
#define kSafeAreaBottomHeight (kScreenHeight == 812.0 ? 34 : 0)

//机型&系统
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6Plus ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )736 ) < DBL_EPSILON )
#define iPhone6 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )667 ) < DBL_EPSILON )
#define iPhone5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define iPhone4 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) < DBL_EPSILON )
#define SysVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#define IOS7  ( SysVersion >= 7.0 )
#define IOS8  ( SysVersion >= 8.0 )
#define IOS9  ( SysVersion >= 9.0 )
#define IOS10 ( SysVersion >= 10.0)
#define IOS11 @available(iOS 11.0, *)

//常用缩写
#define kApplication [UIApplication sharedApplication]
#define kKeyWindow [UIApplication sharedApplication].keyWindow
#define kAppDelegate [UIApplication sharedApplication].delegate
#define kUserDefaults [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]

//4.7寸屏幕为标准进行适配
#define kWidth(R) (R)*(kScreenWidth)/375.0
#define kHeight(R) (iPhone6?(R:((R)*(kScreenHeight)/667.0))
#define kFont(R) (R)*(kScreenWidth)/375.0

//获取沙盒路径
#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
#define kTempPath NSTemporaryDirectory()
#define kCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

//开发的时候打印，但是发布的时候不打印的NSLog
#ifdef DEBUG
//#define NSLog(...) NSLog(@"%s 第%d行 \n%@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define NSLog(...)
#endif

//弱引用/强引用
#define kWeakSelf(type) __weak typeof(type) weak##type = type;
#define kStrongSelf(type) __strong typeof(type) type = weak##type;

//由角度转换弧度
#define kDegreesToRadian(x) (M_PI * (x) / 180.0)
//由弧度转换角度
#define kRadianToDegrees(radian) (radian * 180.0) / (M_PI)

//获取一段时间间隔
#define kStartTime CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define kEndTime NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start);

#endif /* Constant_h */
