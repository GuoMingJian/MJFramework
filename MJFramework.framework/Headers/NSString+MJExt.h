//
//  NSString+MJExt.h
//  MJFramework
//
//  Created by 郭明健 on 2018/6/2.
//  Copyright © 2018年 GuoMingJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MJExt)

/**
 中文转拼音
 */
+ (NSString *)transformPinyin:(NSString *)str;

/**
 字符串反转
 */
+ (NSString *)reverse:(NSString *)str;

/**
 去除字符串首尾空格
 */
+ (NSString *)trimmingSpac:(NSString *)str;

/**
 MD5加密
 */
+ (NSString *)MD5:(NSString *)str;

@end
