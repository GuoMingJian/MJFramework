//
//  NSString+Ext.h
//  OC_MJFramework
//
//  Created by 郭明健 on 2020/3/20.
//  Copyright © 2020 GuoMingJian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Ext)

#pragma mark - APP、iPhone 信息

/// app 名称
+ (NSString *)appName;

/// app 版本
+ (NSString *)appVersion;

/// app Build版本
+ (NSString *)appBuild;

/// app Bundle id
+ (NSString *)appBundleIdentifier;

/// iPhone 系统版本
+ (NSString *)iPhoneSystemVersion;

/// iPhone 名称
+ (NSString *)iPhoneName;

/// iPhone 机型
+ (NSString *)iPhoneModel;

/// iPhone 电量
+ (int)iPhoneBatteryLevel;

/// iPhone 当前网络状态
+ (NSString *)iPhoneNetworkType;

/// iPhone 当前连接WiFi的IP地址
+ (NSString *)iPhoneWIFI_ip;

/// iPhone uuid (Universally Unique Identifier)通用唯一识别码
+ (NSString *)uuidString;

/// 判断 iPhone 是否越狱
+ (BOOL)isJailBreak;

#pragma mark - 日期

/// 默认时间显示格式 yyyy-MM-dd HH:mm:ss
+ (NSString *)formatter;

/// Date 转 时间戳（String）10位
+ (NSString *)dateToStamp:(NSDate *)date;

/// Date 转 时间戳（String）13位
+ (NSString *)dateToStampMS:(NSDate *)date;

/// 时间戳 转 Date（String）
+ (NSString *)stampToDateString:(NSString *)timeStamp
                      formatter:(NSString *)formatter;

/// Date 转 时间字符串
+ (NSString *)dateToString:(NSDate *)date
                 formatter:(NSString *)formatter;

/// 时间字符串 转 Date
+ (NSDate *)stringToDate:(NSString *)dateStr
               formatter:(NSString *)formatter;

/// 获取传入date几天前或几天后的新日期（count>0 : 几天后）
+ (NSDate *)newDayWithCount:(NSDate *)date
                      count:(int)count;

/// 几秒后
+ (NSDate *)newSecondWithDate:(NSDate *)date
                        count:(int)count;

/// 获取date属于星期几 (星期日：0，星期一：1，以此类推)
+ (NSArray *)weakIndexWithDate:(NSDate *)date;

/// 获取传入date所在周一、周日 日期
+ (NSArray *)mondayAndSundayWithDate:(NSDate *)date;

/// 计算两个Date相差几天
+ (int)dayCountWithDate:(NSDate *)startDate
                endDate:(NSDate *)endDate;

/// 计算两个Date相差几秒
+ (int)secondsCountWithDate:(NSDate *)startDate
                    endDate:(NSDate *)endDate;

#pragma mark - 正则表达式

/// 验证表达式字符串是否正确
+ (BOOL)isRight:(NSString *)expression
          value:(NSString *)value;

/// 是否为纯数字
+ (BOOL)isNumber:(NSString *)isRight;

/// 手机号
+ (BOOL)isMobileNumber:(NSString *)isRight;

/// 中国移动
+ (BOOL)isChinaMobile:(NSString *)isRight;

/// 中国联通
+ (BOOL)isChinaUnicom:(NSString *)isRight;

/// 中国电信
+ (BOOL)isChinaTelecom:(NSString *)isRight;

/// 手机运营商（中国移动、中国电信、中国联通）
+ (NSString *)mobileOperator:(NSString *)isRight;

/// 邮箱
+ (BOOL)isEmail:(NSString *)isRight;

/// 身份证号
+ (BOOL)isIdCard:(NSString *)isRight;

/// 中文
+ (BOOL)isChinese:(NSString *)value;

/// 车牌号码
+ (BOOL)isCarNumber:(NSString *)value;

#pragma mark - 常用方法

/// 中文转拼音
- (NSString *)transformToPinYin;

/// 去除首尾空格
- (NSString *)trimmingSpac;

/// 去除所有空格
- (NSString *)trimmingAllSpac;

/// 字符串左右对齐
- (NSAttributedString *)leftRightAlignment;

/// 子字符串富文本
- (NSAttributedString *)attributesWithString:(NSString *)subStr
                                        font:(UIFont *)font
                                       color:(UIColor *)color;

/// 子字符串富文本
- (NSAttributedString *)attributesWithRange:(NSRange)range
                                       font:(UIFont *)font
                                      color:(UIColor *)color;
/// 文本Rect
- (CGRect)textRect:(UIFont *)font
       displaySize:(CGSize)displaySize;

/// 数组 转 JSON String
+ (NSString *)getJSONStringFromArray:(NSArray *)array;

/// JSON String 转 数组
+ (NSArray *)getArrayFromJSONString:(NSString *)jsonString;

/// 字典 转 JSON String
+ (NSString *)getJSONStringFromDictionary:(NSDictionary *)dictionary;

/// JSON String 转 字典
+ (NSDictionary *)getDictionaryFromJSONString:(NSString *)jsonString;

/// 随机字符串
+ (NSString *)randomString:(int)length;

/// 指定字符串随机生成指定长度的新字符串
+ (NSString *)randomString:(NSInteger)length String:(NSString *)letters;

/// MD5
+ (NSString *)md5:(NSString *)str;

/// 插入数据
+ (void)saveUserDefault:(NSString *)key
                  value:(NSString *)value;

/// 获取数据
+ (NSString *)getUserDefault:(NSString *)key;

#pragma mark - URL 编解码

/// URL编码
+ (NSString *)URLEncod:(NSString *)value;

/// URL解码
+ (NSString *)URLDecod:(NSString *)value;

@end

NS_ASSUME_NONNULL_END
