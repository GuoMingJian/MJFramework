//
//  NSString+Ext.m
//  OC_MJFramework
//
//  Created by 郭明健 on 2020/3/20.
//  Copyright © 2020 GuoMingJian. All rights reserved.
//

#import "NSString+Ext.h"
// 手机型号
#import <sys/utsname.h>
#include <sys/sysctl.h>
// 电池电量
#import <objc/runtime.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
// ip地址
#import <sys/ioctl.h>
#import <net/if.h>
#import <arpa/inet.h>
//MD5
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Ext)

#pragma mark - APP、iPhone 信息

/// app 名称
+ (NSString *)appName {
    NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
    return appName;
}

/// app 版本
+ (NSString *)appVersion {
    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    return appVersion;
}

/// app Build版本
+ (NSString *)appBuild {
    NSString *appBuild = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    return appBuild;
}

/// app Bundle id
+ (NSString *)appBundleIdentifier {
    NSString *bundleID = [[NSBundle mainBundle] bundleIdentifier];
    return bundleID;
}

/// iPhone 系统版本
+ (NSString *)iPhoneSystemVersion {
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    return systemVersion;
}

/// iPhone 名称
+ (NSString *)iPhoneName {
    NSString *iPhoneName = [[UIDevice currentDevice] name];
    return iPhoneName;
}

/// iPhone 机型
+ (NSString *)iPhoneModel {
    struct utsname systemInfo;
    uname(&systemInfo);
    //型号标识符
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    NSDictionary *dic = @{
        // iPhone
        @"iPhone1,1" : @"iPhone 2G",
        @"iPhone1,2" : @"iPhone 3G",
        @"iPhone2,1" : @"iPhone 3GS",
        @"iPhone3,1" : @"iPhone 4",
        @"iPhone3,2" : @"iPhone 4",
        @"iPhone3,3" : @"iPhone 4",
        @"iPhone4,1" : @"iPhone 4S",
        @"iPhone5,1" : @"iPhone 5",
        @"iPhone5,2" : @"iPhone 5",
        @"iPhone5,3" : @"iPhone 5c",
        @"iPhone5,4" : @"iPhone 5c",
        @"iPhone6,1" : @"iPhone 5s",
        @"iPhone6,2" : @"iPhone 5s",
        @"iPhone7,1" : @"iPhone 6 Plus",
        @"iPhone7,2" : @"iPhone 6",
        @"iPhone8,1" : @"iPhone 6s",
        @"iPhone8,2" : @"iPhone 6s Plus",
        @"iPhone8,4" : @"iPhone SE",
        @"iPhone9,1" : @"iPhone 7",
        @"iPhone9,3" : @"iPhone 7",
        @"iPhone9,2" : @"iPhone 7 Plus",
        @"iPhone9,4" : @"iPhone 7 Plus",
        @"iPhone10,1" : @"iPhone 8",
        @"iPhone10,4" : @"iPhone 8",
        @"iPhone10,2" : @"iPhone 8 Plus",
        @"iPhone10,5" : @"iPhone 8 Plus",
        @"iPhone10,3" : @"iPhone X",
        @"iPhone10,6" : @"iPhone X",
        @"iPhone11,2" : @"iPhone XS",
        @"iPhone11,4" : @"iPhone XS Max",
        @"iPhone11,6" : @"iPhone XS Max",
        @"iPhone11,8" : @"iPhone XR",
        @"iPhone12,1" : @"iPhone 11",
        @"iPhone12,3" : @"iPhone 11 Pro",
        @"iPhone12,5" : @"iPhone 11 Pro Max",
        // 模拟器
        @"i386" : @"iPhone Simulator x86",
        @"x86_64" : @"iPhone Simulator x64",
        // iPad
    };
    NSString *name = dic[platform];
    if (!name) {
        name = [self machineModel];
    }
    return name;
}

// 机型（系统）
+ (NSString *)machineModel {
    static dispatch_once_t one;
    static NSString *model;
    dispatch_once(&one, ^{
        size_t size;
        sysctlbyname("hw.machine", NULL, &size, NULL, 0);
        char *machine = malloc(size);
        sysctlbyname("hw.machine", machine, &size, NULL, 0);
        model = [NSString stringWithUTF8String:machine];
        free(machine);
    });
    return model;
}

/// iPhone 电量
+ (int)iPhoneBatteryLevel {
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    double deviceLevel = [UIDevice currentDevice].batteryLevel;
    return (int)(deviceLevel * 100);
}

///// iPhone 当前网络状态
//+ (NSString *)iPhoneNetworkType {
//    NSString *netconnType = @"";
//    MJReachability *reach = [MJReachability reachabilityWithHostName:@"www.apple.com"];
//    switch ([reach currentReachabilityStatus]) {
//        case NotReachable:// 没有网络
//        {
//            netconnType = @"no network";
//        }
//            break;
//        case ReachableViaWiFi:// Wifi
//        {
//            netconnType = @"Wifi";
//        }
//            break;
//        case ReachableViaWWAN:// 手机自带网络
//        {
//            // 获取手机网络类型
//            CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
//            NSString *currentStatus = info.currentRadioAccessTechnology;
//            if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyGPRS"]) {
//                netconnType = @"GPRS";
//            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyEdge"]) {
//                netconnType = @"2.75G EDGE";
//            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyWCDMA"]){
//                netconnType = @"3G";
//            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSDPA"]){
//                netconnType = @"3.5G HSDPA";
//            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSUPA"]){
//                netconnType = @"3.5G HSUPA";
//            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMA1x"]){
//                netconnType = @"2G";
//            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORev0"]){
//                netconnType = @"3G";
//            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevA"]){
//                netconnType = @"3G";
//            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevB"]){
//                netconnType = @"3G";
//            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyeHRPD"]){
//                netconnType = @"HRPD";
//            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyLTE"]){
//                netconnType = @"4G";
//            }
//        }
//            break;
//        default:
//            break;
//    }
//    return netconnType;
//}

/// iPhone 当前连接WiFi的IP地址
+ (NSString *)iPhoneWIFI_ip {
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sockfd < 0) return nil;
    NSMutableArray *ips = [NSMutableArray array];
    
    int BUFFERSIZE = 4096;
    struct ifconf ifc;
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    
    struct ifreq *ifr, ifrcopy;
    ifc.ifc_len = BUFFERSIZE;
    ifc.ifc_buf = buffer;
    
    if (ioctl(sockfd, SIOCGIFCONF, &ifc) >= 0)
    {
        for (ptr = buffer; ptr < buffer + ifc.ifc_len; )
        {
            ifr = (struct ifreq *)ptr;
            int len = sizeof(struct sockaddr);
            if (ifr->ifr_addr.sa_len > len)
            {
                len = ifr->ifr_addr.sa_len;
            }
            ptr += sizeof(ifr->ifr_name) + len;
            if (ifr->ifr_addr.sa_family != AF_INET) continue;
            if ((cptr = (char *)strchr(ifr->ifr_name, ':')) != NULL) *cptr = 0;
            if (strncmp(lastname, ifr->ifr_name, IFNAMSIZ) == 0) continue;
            memcpy(lastname, ifr->ifr_name, IFNAMSIZ);
            ifrcopy = *ifr;
            ioctl(sockfd, SIOCGIFFLAGS, &ifrcopy);
            if ((ifrcopy.ifr_flags & IFF_UP) == 0) continue;
            NSString *ip = [NSString  stringWithFormat:@"%s", inet_ntoa(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr)];
            [ips addObject:ip];
        }
    }
    close(sockfd);
    NSString *deviceIP = @"";
    for (int i=0; i < ips.count; i++)
    {
        if (ips.count > 0)
        {
            deviceIP = [NSString stringWithFormat:@"%@",ips.lastObject];
        }
    }
    return deviceIP;
}

/// iPhone uuid (Universally Unique Identifier)通用唯一识别码
+ (NSString *)uuidString {
    NSString *uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    return uuid;
}

/// 判断 iPhone 是否越狱
+ (BOOL)isJailBreak {
    __block BOOL jailBreak = NO;
    NSArray *array = @[@"/Applications/Cydia.app",
                       @"/private/var/lib/apt",
                       @"/usr/lib/system/libsystem_kernel.dylib",
                       @"Library/MobileSubstrate/MobileSubstrate.dylib",
                       @"/etc/apt"];
    [array enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL fileExist = [[NSFileManager defaultManager] fileExistsAtPath:obj];
        if ([obj isEqualToString:@"/usr/lib/system/libsystem_kernel.dylib"]) {
            jailBreak |= !fileExist;
        } else {
            jailBreak |= fileExist;
        }
    }];
    return jailBreak;
}

#pragma mark - 日期

/// 默认时间显示格式 yyyy-MM-dd HH:mm:ss
+ (NSString *)formatter {
    return @"yyyy-MM-dd HH:mm:ss";
}

/// 获取 DateFormatter 实例
+ (NSDateFormatter *)getDateFormatter:(NSString *)formatter {
    NSString *dateFormat = (formatter.length == 0) ? [NSString formatter] : formatter;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = dateFormat;
    return dateFormatter;
}

/// Date 转 时间戳（String）10位
+ (NSString *)dateToStamp:(NSDate *)date {
    NSString *stamp = [NSString dateToStampMS:date];
    if (stamp.length >= 10) {
        stamp = [stamp substringToIndex:10];
    } else {
        stamp = @"0";
    }
    return stamp;
}

/// Date 转 时间戳（String）13位
+ (NSString *)dateToStampMS:(NSDate *)date {
    NSDateFormatter *dateFormatter = [NSString getDateFormatter:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    NSDate *newDate = [dateFormatter dateFromString:dateStr];
    NSTimeInterval timeInterval = [newDate timeIntervalSince1970];
    long long totalMilliseconds = timeInterval * 1000;
    NSString *stamp = [NSString stringWithFormat:@"%llu", totalMilliseconds];
    return stamp;
}

/// 时间戳 转 Date（String）
+ (NSString *)stampToDateString:(NSString *)timeStamp
                      formatter:(NSString *)formatter {
    NSDateFormatter *dateFormatter = [NSString getDateFormatter:formatter];
    dateFormatter.timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    NSTimeInterval dT = [timeStamp doubleValue];
    if (timeStamp.length == 13) {
        dT = dT / 1000.0;
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dT];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

/// Date 转 时间字符串
+ (NSString *)dateToString:(NSDate *)date
                 formatter:(NSString *)formatter {
    NSDateFormatter *dateFormatter = [NSString getDateFormatter:formatter];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

/// 时间字符串 转 Date
+ (NSDate *)stringToDate:(NSString *)dateStr
               formatter:(NSString *)formatter {
    NSDateFormatter *dateFormatter = [NSString getDateFormatter:formatter];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    return date;
}

/// 获取传入date几天前或几天后的新日期（count>0 : 几天后）
+ (NSDate *)newDayWithCount:(NSDate *)date
                      count:(int)count {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear |
                                    NSCalendarUnitMonth |
                                    NSCalendarUnitDay |
                                    NSCalendarUnitHour |
                                    NSCalendarUnitMinute |
                                    NSCalendarUnitSecond
                                               fromDate:date];
    [components setDay:([components day] + count)]; // 正数为几天后，负数为几天前。
    NSDate *newDate = [calendar dateFromComponents:components];
    return newDate;
}

/// 几秒后
+ (NSDate *)newSecondWithDate:(NSDate *)date
                        count:(int)count {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear |
                                    NSCalendarUnitMonth |
                                    NSCalendarUnitDay |
                                    NSCalendarUnitHour |
                                    NSCalendarUnitMinute |
                                    NSCalendarUnitSecond
                                               fromDate:date];
    [components setSecond:components.second + count];
    NSDate *newDate = [calendar dateFromComponents:components];
    return newDate;
}

/// 获取date属于星期几 (星期日：0，星期一：1，以此类推)
+ (NSArray *)weakIndexWithDate:(NSDate *)date {
    NSMutableArray *arrM = [NSMutableArray array];
    //
    NSString *weakString = @"";
    NSArray *weakStrArray = @[@"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六"];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:date];
    NSInteger index = components.weekday; //index == 1 [星期日];
    weakString = weakStrArray[index - 1];
    [arrM addObject:[NSNumber numberWithInteger:index]];
    [arrM addObject:weakString];
    return arrM;
}

/// 获取传入date所在周一、周日 日期
+ (NSArray *)mondayAndSundayWithDate:(NSDate *)date {
    NSMutableArray *array = [NSMutableArray array];
    //
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear |
                                    NSCalendarUnitMonth |
                                    NSCalendarUnitDay |
                                    NSCalendarUnitWeekday
                                               fromDate:date];
    //该日期属于星期几,1:周日...
    NSInteger dayOfWeek = [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:date] weekday];
    NSInteger dayOfDate = [components day];
    
    //周一对应是2.当前星期几与2相减得到相差几天.当前日期也相差几天.
    NSDateComponents *copyComponents = [components copy];
    [copyComponents setDay:(dayOfDate - (dayOfWeek - 2))];
    NSDate *monday = [calendar dateFromComponents:copyComponents];
    
    NSDateFormatter *dateFormatter = [NSString getDateFormatter:@""];
    NSString *mondayStr = [dateFormatter stringFromDate:monday];
    [array addObject:mondayStr];
    
    //当前周日对应是8;
    [components setDay:(dayOfDate + (8 - dayOfWeek))];
    NSDate *sunday = [calendar dateFromComponents:components];
    NSString *sundayStr = [dateFormatter stringFromDate:sunday];
    [array addObject:sundayStr];
    
    return array;
}

/// 计算两个Date相差几天
+ (int)dayCountWithDate:(NSDate *)startDate
                endDate:(NSDate *)endDate {
    /**
     * 要比较的时间单位,常用如下,可以同时传：
     *    NSCalendarUnitYear : 年
     *    NSCalendarUnitMonth : 月
     *    NSCalendarUnitDay : 天
     *    NSCalendarUnitHour : 时
     *    NSCalendarUnitMinute : 分
     *    NSCalendarUnitSecond : 秒
     */
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay;
    NSDateComponents *components = [calendar components:unit fromDate:startDate toDate:endDate options:0];
    return (int)components.day + 1;
}

/// 计算两个Date相差几秒
+ (int)secondsCountWithDate:(NSDate *)startDate
                    endDate:(NSDate *)endDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:unit fromDate:startDate toDate:endDate options:0];
    return (int)components.second + 1;
}

/// 比较两个日期时间大小 (-1: str1 > str2; 0:相等; 1: str1 < str2)
+ (int)compareDateStr:(NSString *)str1
          withDateStr:(NSString *)str2 {
    NSDate *date1 = [NSString stringToDate:str1 formatter:@""];
    NSDate *date2 = [NSString stringToDate:str2 formatter:@""];
    return [NSString compareDate:date1 withDate:date2];
}

/// 比较两个日期时间大小 (-1: date1 > date2; 0:相等; 1: date1 < date2)
+ (int)compareDate:(NSDate *)date1
          withDate:(NSDate *)date2 {
    int comparisonResult;
    //
    NSComparisonResult result = [date1 compare:date2];
    //NSLog(@"result==%ld", (long)result);
    switch(result)
    {
            // date2 比 date1 大
        case NSOrderedAscending:
            comparisonResult = 1;
            break;
            // date2 比 date1 小
        case NSOrderedDescending:
            comparisonResult = -1;
            break;
            // date2 相等 date1
        case NSOrderedSame:
            comparisonResult = 0;
            break;
        default:
            NSLog(@"%s:erorr dates %@, %@",__func__, date1, date2);
            break;
    }
    return comparisonResult;
}

#pragma mark - 正则表达式

//http://deerchao.net/tutorials/regex/regex.htm[正则表达式入门]
//http://gold.xitu.io/entry/571807a88ac247005f117209/promote?utm_source=baidu&utm_medium=keyword&utm_content=regexp&utm_campaign=q3_search[20 个正则表达式]

/// 验证表达式字符串是否正确
+ (BOOL)isRight:(NSString *)expression
          value:(NSString *)value {
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", expression];
    BOOL isMatch = [pred evaluateWithObject:value];
    return isMatch;
}

/// 是否为纯数字
+ (BOOL)isNumber:(NSString *)value {
    NSString *isNumExp = @"^[0-9]*$";
    return [NSString isRight:isNumExp value:value];
}

/// 手机号
+ (BOOL)isMobileNumber:(NSString *)value {
    BOOL isPhoneNumber = [NSString isChinaMobile:value] || [NSString isChinaUnicom:value] ||[NSString isChinaTelecom:value];
    return isPhoneNumber;
}

/// 中国移动
+ (BOOL)isChinaMobile:(NSString *)value {
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478]|9[8])\\d{8}$)|(^1705\\d{7}$)";
    return [self isRight:CM value:value];
}

/// 中国联通
+ (BOOL)isChinaUnicom:(NSString *)value {
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|6[6]|7[56]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    return [self isRight:CU value:value];
}

/// 中国电信
+ (BOOL)isChinaTelecom:(NSString *)value {
    NSString *CT = @"(^1(33|53|77|8[019]|99)\\d{8}$)|(^1700\\d{7}$)";
    return [self isRight:CT value:value];
}

/// 手机运营商（中国移动、中国电信、中国联通）
+ (NSString *)mobileOperator:(NSString *)value {
    return [self isChinaMobile:value]? @"中国移动":
    ([self isChinaUnicom:value]? @"中国联通":
     ([self isChinaTelecom:value]? @"中国电信": @"未知"));
}

/// 邮箱
+ (BOOL)isEmail:(NSString *)value {
    NSString *emailExp = @"[\\w!#$%&'*+/=?^_`{|}~-]+(?:\\.[\\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\\w](?:[\\w-]*[\\w])?\\.)+[\\w](?:[\\w-]*[\\w])?";
    return [self isRight:emailExp value:value];
}

/// 身份证号
+ (BOOL)isIdCard:(NSString *)value {
    // 判断位数
    if (value.length != 15 && value.length != 18)
    {
        return NO;
    }
    
    NSString *carid = value;
    long lSumQT = 0;
    // 加权因子
    int R[] = {7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    // 校验码
    unsigned char sChecker[11] = {'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    
    // 将15位身份证号转换成18位
    NSMutableString *mString = [NSMutableString stringWithString:value];
    if (value.length == 15)
    {
        [mString insertString:@"19" atIndex:6];
        long p = 0;
        const char *pid = [mString UTF8String];
        
        for (int i = 0; i <= 16; i ++)
        {
            p += (pid[i] - 48) * R[i];
        }
        
        int o = p % 11;
        NSString *string_content = [NSString stringWithFormat:@"%c", sChecker[o]];
        [mString insertString:string_content atIndex:[mString length]];
        carid = mString;
    }
    
    // 判断地区码
    NSString * sProvince = [carid substringToIndex:2];
    if (![self areaCode:sProvince])
    {
        return NO;
    }
    
    // 判断年月日是否有效
    // 年份
    int strYear = [[self substringWithString:carid begin:6 end:4] intValue];
    // 月份
    int strMonth = [[self substringWithString:carid begin:10 end:2] intValue];
    // 日
    int strDay = [[self substringWithString:carid begin:12 end:2] intValue];
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",
                                                strYear, strMonth, strDay]];
    if (date == nil)
    {
        return NO;
    }
    
    const char *PaperId  = [carid UTF8String];
    // 检验长度
    if(18 != strlen(PaperId)) return NO;
    // 校验数字
    for (int i = 0; i < 18; i++)
    {
        if (!isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i))
        {
            return NO;
        }
    }
    
    // 验证最末的校验码
    for (int i = 0; i <= 16; i ++)
    {
        lSumQT += (PaperId[i] - 48) * R[i];
    }
    
    if (sChecker[lSumQT%11] != PaperId[17])
    {
        return NO;
    }
    return YES;
}

/**
 * 功能:获取指定范围的字符串
 * 参数:字符串的开始小标
 * 参数:字符串的结束下标
 */
+ (NSString *)substringWithString:(NSString *)str begin:(NSInteger)begin end:(NSInteger )end
{
    return [str substringWithRange:NSMakeRange(begin, end)];
}

/**
 * 功能:判断是否在地区码内
 * 参数:地区码
 */
+ (BOOL)areaCode:(NSString *)code
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"北京" forKey:@"11"];
    [dic setObject:@"天津" forKey:@"12"];
    [dic setObject:@"河北" forKey:@"13"];
    [dic setObject:@"山西" forKey:@"14"];
    [dic setObject:@"内蒙古" forKey:@"15"];
    [dic setObject:@"辽宁" forKey:@"21"];
    [dic setObject:@"吉林" forKey:@"22"];
    [dic setObject:@"黑龙江" forKey:@"23"];
    [dic setObject:@"上海" forKey:@"31"];
    [dic setObject:@"江苏" forKey:@"32"];
    [dic setObject:@"浙江" forKey:@"33"];
    [dic setObject:@"安徽" forKey:@"34"];
    [dic setObject:@"福建" forKey:@"35"];
    [dic setObject:@"江西" forKey:@"36"];
    [dic setObject:@"山东" forKey:@"37"];
    [dic setObject:@"河南" forKey:@"41"];
    [dic setObject:@"湖北" forKey:@"42"];
    [dic setObject:@"湖南" forKey:@"43"];
    [dic setObject:@"广东" forKey:@"44"];
    [dic setObject:@"广西" forKey:@"45"];
    [dic setObject:@"海南" forKey:@"46"];
    [dic setObject:@"重庆" forKey:@"50"];
    [dic setObject:@"四川" forKey:@"51"];
    [dic setObject:@"贵州" forKey:@"52"];
    [dic setObject:@"云南" forKey:@"53"];
    [dic setObject:@"西藏" forKey:@"54"];
    [dic setObject:@"陕西" forKey:@"61"];
    [dic setObject:@"甘肃" forKey:@"62"];
    [dic setObject:@"青海" forKey:@"63"];
    [dic setObject:@"宁夏" forKey:@"64"];
    [dic setObject:@"新疆" forKey:@"65"];
    [dic setObject:@"台湾" forKey:@"71"];
    [dic setObject:@"香港" forKey:@"81"];
    [dic setObject:@"澳门" forKey:@"82"];
    [dic setObject:@"国外" forKey:@"91"];
    
    if ([dic objectForKey:code] == nil) {
        return NO;
    }
    return YES;
}

/// 中文
+ (BOOL)isChinese:(NSString *)value {
    NSString *regexp = @"^[\\u4e00-\\u9fa5]{0,}$";
    return [self isRight:regexp value:value];
}

/// 车牌号码
+ (BOOL)isCarNumber:(NSString *)value {
    NSString *regexp = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    return [self isRight:regexp value:value];
}

#pragma mark - 常用方法

/// 中文转拼音
- (NSString *)transformToPinYin {
    NSMutableString *mutableString = [NSMutableString stringWithString:self];
    //转成带声调的拼音
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    //转成没有声调的拼音
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformStripDiacritics, false);
    NSString *newstr = [mutableString stringByReplacingOccurrencesOfString:@" " withString:@""];
    return newstr;
}

/// 去除首尾空格
- (NSString *)trimmingSpac {
    NSString *str = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return str;
}

/// 去除所有空格
- (NSString *)trimmingAllSpac {
    NSString *str = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    return str;
}

/// 字符串左右对齐
- (NSAttributedString *)leftRightAlignment {
    NSMutableAttributedString *mAbStr = [[NSMutableAttributedString alloc] initWithString:self];
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

/// 子字符串富文本
- (NSAttributedString *)attributesWithString:(NSString *)subStr
                                        font:(UIFont *)font
                                       color:(UIColor *)color {
    NSRange range = [self rangeOfString:subStr];
    return [self attributesWithRange:range font:font color:color];
}

/// 子字符串富文本
- (NSAttributedString *)attributesWithRange:(NSRange)range
                                       font:(UIFont *)font
                                      color:(UIColor *)color {
    NSMutableAttributedString *attStrM = [[NSMutableAttributedString alloc] initWithString:self];
    NSDictionary *attributes = @{NSForegroundColorAttributeName : color,
                                 NSFontAttributeName : font};
    [attStrM addAttributes:attributes range:range];
    return attStrM;
}

/// 文本Rect
- (CGRect)textRect:(UIFont *)font
       displaySize:(CGSize)displaySize {
    NSDictionary *attributes = @{NSFontAttributeName: font};
    CGRect rect = [self boundingRectWithSize:displaySize
                                     options:NSStringDrawingTruncatesLastVisibleLine
                   |NSStringDrawingUsesLineFragmentOrigin
                   |NSStringDrawingUsesFontLeading
                                  attributes:attributes context:nil];
    return rect;
}

/// 数组 转 JSON String
+ (NSString *)getJSONStringFromArray:(NSArray *)array {
    if (![NSJSONSerialization isValidJSONObject:array]) {
        NSLog(@"无法解析出JSONString");
        return @"[]";
    }
    NSJSONWritingOptions options = NSJSONWritingPrettyPrinted;
    if (@available(iOS 11.0, *)) {
        // NSJSONWritingSortedKeys 默认：一整行
        options = NSJSONWritingSortedKeys;
    } else {
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:array options:options error:nil];
    NSString *JsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return JsonString;
}

/// JSON String 转 数组
+ (NSArray *)getArrayFromJSONString:(NSString *)jsonString {
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    if (array) {
        return array;
    } else {
        return @[];
    }
}

/// 字典 转 JSON String
+ (NSString *)getJSONStringFromDictionary:(NSDictionary *)dictionary {
    if (![NSJSONSerialization isValidJSONObject:dictionary]) {
        NSLog(@"无法解析出JSONString");
        return @"[]";
    }
    NSJSONWritingOptions options = NSJSONWritingPrettyPrinted;
    if (@available(iOS 11.0, *)) {
        // NSJSONWritingSortedKeys 默认：一整行
        options = NSJSONWritingSortedKeys;
    } else {
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:options error:nil];
    NSString *JsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return JsonString;
}

/// JSON String 转 字典
+ (NSDictionary *)getDictionaryFromJSONString:(NSString *)jsonString {
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    if (dict) {
        return dict;
    } else {
        return @{};
    }
}

/// 随机字符串
+ (NSString *)randomString:(int)length {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: length];
    for (NSInteger i = 0; i < length; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((int)[letters length])]];
    }
    return randomString;
}

/// 指定字符串随机生成指定长度的新字符串
+ (NSString *)randomString:(NSInteger)length
                    String:(NSString *)letters {
    NSMutableString *randomString = [NSMutableString stringWithCapacity: length];
    for (NSInteger i = 0; i < length; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((int)[letters length])]];
    }
    return randomString;
}

/// MD5
+ (NSString *)md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];//16
    CC_MD5( cStr, (unsigned int)strlen(cStr), digest );
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02X", digest[i]];
    return [output uppercaseString];
}

/// 插入数据
+ (void)saveUserDefault:(NSString *)key
                  value:(NSString *)value {
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/// 获取数据
+ (NSString *)getUserDefault:(NSString *)key {
    NSString *result = @"";
    NSString *value = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (value) {
        result = value;
    }
    return result;
}

#pragma mark - URL 编解码

/// URL编码
+ (NSString *)URLEncod:(NSString *)value {
    NSString *newValue = [value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return newValue;
}

/// URL解码
+ (NSString *)URLDecod:(NSString *)value {
    NSString *newValue = [value stringByRemovingPercentEncoding];
    return newValue;
}

@end
