//
//  MJProgressHUDManager.h
//  ZXToolProjects
//
//  Created by 郭明健 on 2018/6/26.
//  Copyright © 2018年 GuoMingJian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MJProgressHUDManager : NSObject

#define kDEFAULT_MESSAGE @"正在加载..."

/**
 Loading 默认显示文本 "请稍候..."
 
 @param isShow 显示/隐藏
 */
+ (void)isShow:(BOOL)isShow;

/**
 Loading 自定义显示文本
 
 @param isShow 显示/隐藏
 @param content 自定义文本
 */
+ (void)isShow:(BOOL)isShow content:(NSString*)content;

/**
 Loading 自定义显示文本
 
 @param isShow 显示/隐藏
 @param content 自定义文本
 @param isEnabled 是否可点击取消
 */
+ (void)isShow:(BOOL)isShow content:(NSString*)content hudIsEnabled:(BOOL)isEnabled;

/**
 提示弹窗
 
 @param text 文本
 @param duration 弹窗停留时间
 */
+ (void)showText:(NSString *)text duration:(NSTimeInterval)duration;

@end
