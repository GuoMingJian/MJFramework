//
//  UIImage+Ext.h
//  OC_MJFramework
//
//  Created by 郭明健 on 2020/3/23.
//  Copyright © 2020 GuoMingJian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Ext)

/// 根据颜色生成图片
+ (UIImage *)imageWithColor:(UIColor *)color;

/// 根据颜色生成图片，指定大小
+ (UIImage *)imageWithColor:(UIColor *)color
                       rect:(CGRect)rect;

/// 裁剪图片；newSize：目标大小
+ (UIImage *)image:(UIImage *)image
      scaledToSize:(CGSize)newSize;

/// 图片压缩
/// @param maxLengthKB 压缩到的大小 KB
/// @param image 准备压缩的图片
/// @param block 压缩完成后的图片
+ (void)compressWithMaxLengthKB:(NSUInteger)maxLengthKB
                          image:(UIImage *)image
                          block:(void (^)(NSData *imageData))block;

/// 修复图片朝向
+ (UIImage *)fixImageOrientation:(UIImage *)aImage;

/// base64 String 转 UImage
+ (UIImage *)imageFormBase64String:(NSString *)base64String;

/// UImage 转 base64 String
- (NSString *)toBase64String;

#pragma mark - 添加水印

#define HORIZONTAL_SPACE 100 // 水平间距
#define VERTICAL_SPACE 100   // 竖直间距
#define CG_TRANSFORM_ROTATION (- M_PI_2 / 3) // 旋转角度(正旋45度 || 反旋45度)

/// 根据目标图片制作一个盖水印的图片
/// @param originalImage 源图片
/// @param title 水印文字
/// @param markFont 水印文字font(如果不传默认为23)
/// @param markColor 水印文字颜色(如果不传递默认为源图片的对比色)
+ (UIImage *)getWaterMarkImage: (UIImage *)originalImage
                      andTitle: (NSString *)title
                   andMarkFont: (UIFont *)markFont
                  andMarkColor: (UIColor *)markColor;

@end

NS_ASSUME_NONNULL_END
