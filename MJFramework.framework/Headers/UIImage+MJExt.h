//
//  UIImage+MJExt.h
//  MJFramework
//
//  Created by 郭明健 on 2018/6/2.
//  Copyright © 2018年 GuoMingJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MJExt)

/**
 根据颜色生成图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 获取 View 控件截图
 */
+ (UIImage *)imageScreenshotsFromView:(UIView *)view;

/**
 裁剪图片；newSize：目标大小
 */
+ (UIImage *)image:(UIImage *)image
      scaledToSize:(CGSize)newSize;

/**
 压缩图片；maxImageSize单位kb。
 */
+ (UIImage *)compressImage:(UIImage *)image
            toMaxImageSize:(NSInteger)maxImageSize;

/**
 修复图片朝向
 */
+ (UIImage *)fixImageOrientation:(UIImage *)aImage;


@end
