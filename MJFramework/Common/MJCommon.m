//
//  MJCommon.m
//  OC_MJFramework
//
//  Created by 郭明健 on 2020/3/23.
//  Copyright © 2020 GuoMingJian. All rights reserved.
//

#import "MJCommon.h"

@implementation MJCommon

#pragma mark - 4.7寸屏幕(6/6s)为标准进行适配

/// 4.7寸 适配宽
+ (CGFloat)kWidth:(CGFloat)width {
    return width * [UIScreen mainScreen].bounds.size.width / 375.0;
}

/// 4.7寸 适配高
+ (CGFloat)kHeight:(CGFloat)height {
    return height * [UIScreen mainScreen].bounds.size.height / 667.0;
}

/// 4.7寸 适配字体
+ (CGFloat)kFontSize:(CGFloat)fontSize {
    return fontSize * [UIScreen mainScreen].bounds.size.width / 375.0;
}

#pragma mark - 计算 /Library/Caches 路径下所有缓存文件大小

/// 获取缓存目录文件大小，单位 M
+ (CGFloat)fileSizeOfCache {
    // 获取Caches目录路径和目录下所有文件
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSLog(@"cache路径:\n%@", cachePath);
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    //
    CGFloat folderSize = 0;
    for (NSString *file in files) {
        // 路径拼接
        NSString *path = [cachePath stringByAppendingPathComponent:file];
        // 计算缓存大小
        folderSize += [self fileSizeAtPath:path];
    }
    //
    return folderSize / (1024*1024); // b->kb->M
}

/// 根据路径获取文件大小，单位 M
+ (CGFloat)fileSizeAtPath:(NSString *)path {
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSDictionary<NSFileAttributeKey, id> *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
        return [fileAttributes[NSFileSize] integerValue];
    } else {
        return 0;
    }
}

/// 清除 /Library/Caches 缓存文件
+ (void)clearCache {
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    for (NSString *file in files) {
        NSString *path = [cachePath stringByAppendingPathComponent:file];
        if ([[NSFileManager defaultManager] isExecutableFileAtPath:path]) {
            [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        }
    }
}

#pragma mark -

@end
