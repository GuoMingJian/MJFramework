//
//  NSString+Date.h
//  MJFramework
//
//  Created by 郭明健 on 2018/6/2.
//  Copyright © 2018年 GuoMingJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Date)

/**
 默认的时间格式 [yyyy-MM-dd HH:mm:ss]
 */
+ (NSString *)defaultFormater;

/**
 NSDate-->时间戳
 [注意:如果stamp=0,请确保(date[时间],formaterStr[时间格式])正确!]
 */
+ (NSString *)stampWithDate:(NSDate *)date
                   formater:(NSString *)formaterStr;

/**
 时间戳-->字符串
 */
+ (NSString *)dateStringWithStamp:(NSString *)stamp
                         formater:(NSString *)formaterStr;

/**
 字符串-->NSDate
 [注意:传入的字符串中，应为"2016-05-21 05:24:12"格式，不能为"2016年05月21日 05时24分12秒"]
 */
+ (NSDate *)dateWithString:(NSString *)str
                  formater:(NSString *)formaterStr;

/**
 NSDate-->字符串
 */
+ (NSString *)dateStringWithDate:(NSDate *)date
                        formater:(NSString *)formaterStr;

/**
 获取传入日期date几天前(dayCount<0)或几天后(dayCount>0)的时间字符串
 */
+ (NSString *)dateStirngWithDate:(NSDate *)date
                        dayCount:(NSInteger)dayCount
                        formater:(NSString *)formaterStr;

/**
 NSDate-->星期几
 */
+ (NSString *)weakStringWithDate:(NSDate *)date;

/**
 获取传入日期所在周的数组，数组0:周一，1:周日
 */
+ (NSArray *)mondayAndSundayArrayWithDate:(NSDate *)date;

@end
