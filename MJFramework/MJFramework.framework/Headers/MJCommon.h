//
//  MJCommon.h
//  OC_MJFramework
//
//  Created by 郭明健 on 2020/3/23.
//  Copyright © 2020 GuoMingJian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MJCommon : NSObject

#pragma mark - 4.7寸屏幕(6/6s)为标准进行适配

/// 4.7寸 适配宽
+ (CGFloat)kWidth:(CGFloat)width;

/// 4.7寸 适配高
+ (CGFloat)kHeight:(CGFloat)height;

/// 4.7寸 适配字体
+ (CGFloat)kFontSize:(CGFloat)fontSize;

#pragma mark - 计算 /Library/Caches 路径下所有缓存文件大小

/// 获取缓存目录文件大小，单位 M
+ (CGFloat)fileSizeOfCache;

/// 根据路径获取文件大小，单位 M
+ (CGFloat)fileSizeAtPath:(NSString *)path;

/// 清除 /Library/Caches 缓存文件
+ (void)clearCache;

#pragma mark -

@end

NS_ASSUME_NONNULL_END
