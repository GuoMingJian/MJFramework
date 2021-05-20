//
//  UIImage+Ext.m
//  OC_MJFramework
//
//  Created by 郭明健 on 2020/3/23.
//  Copyright © 2020 GuoMingJian. All rights reserved.
//

#import "UIImage+Ext.h"

@implementation UIImage (Ext)

/// 根据颜色生成图片
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f); // 宽高 1.0只要有值就够了
    return [self imageWithColor:color rect:rect];
}

/// 根据颜色生成图片，指定大小
+ (UIImage *)imageWithColor:(UIColor *)color
                       rect:(CGRect)rect {
    UIGraphicsBeginImageContext(rect.size); // 在这个范围内开启一段上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]); // 在这段上下文中获取到颜色UIColor
    CGContextFillRect(context, rect); // 用这个颜色填充这个上下文
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext(); // 从这段上下文中获取Image属性,,,结束
    UIGraphicsEndImageContext();
    return image;
}

/// 裁剪图片；newSize：目标大小
+ (UIImage *)image:(UIImage *)image
      scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/// 图片压缩
/// @param maxLengthKB 压缩到的大小 KB
/// @param image 准备压缩的图片
/// @param index 图片标记（压缩是异步过程，加个标记）
/// @param block 压缩完成后的图片
+ (void)compressWithMaxLengthKB:(NSUInteger)maxLengthKB
                          image:(UIImage *)image
                          index:(NSInteger)index
                          block:(void (^)(NSData *imageData, NSUInteger index))block {
    if (maxLengthKB <= 0 || [image isKindOfClass:[NSNull class]] || image == nil) block(nil, -1);

    maxLengthKB = maxLengthKB*1024;

    dispatch_async(dispatch_get_global_queue(0, 0), ^{

        CGFloat compression = 1;
        NSData *data = UIImageJPEGRepresentation(image, compression);
        NSLog(@"初始 : %ld KB", data.length/1024);
        if (data.length < maxLengthKB){
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"压缩完成： %zd kb", data.length/1024);
                block(data, index);
            });
            return;
        }

        //质量压缩
        CGFloat scale = 1;
        CGFloat lastLength = 0;
        for (int i = 0; i < 7; ++i) {
            compression = scale / 2;
            data = UIImageJPEGRepresentation(image, compression);
            NSLog(@"质量压缩中： %ld KB", data.length / 1024);
            if (i > 0) {
                if (data.length>0.95*lastLength) break;//当前压缩后大小和上一次进行对比，如果大小变化不大就退出循环
                if (data.length < maxLengthKB) break;//当前压缩后大小和目标大小进行对比，小于则退出循环
            }
            scale = compression;
            lastLength = data.length;

        }
        NSLog(@"压缩图片质量后: %ld KB", data.length / 1024);
        if (data.length < maxLengthKB){
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"压缩完成： %zd kb", data.length/1024);
                block(data, index);
            });
            return;
        }

        //大小压缩
        UIImage *resultImage = [UIImage imageWithData:data];
        NSUInteger lastDataLength = 0;
        while (data.length > maxLengthKB && data.length != lastDataLength) {
            lastDataLength = data.length;
            CGFloat ratio = (CGFloat)maxLengthKB / data.length;
            NSLog(@"Ratio = %.1f", ratio);
            CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                     (NSUInteger)(resultImage.size.height * sqrtf(ratio)));
            UIGraphicsBeginImageContext(size);
            [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
            resultImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            data = UIImageJPEGRepresentation(resultImage, compression);
            NSLog(@"绘图压缩中： %ld KB", data.length / 1024);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"压缩完成： %ld kb", data.length/1024);
            block(data, index);
        });return;
    });

}

/// 修复图片朝向
+ (UIImage *)fixImageOrientation:(UIImage *)aImage {
    // 无操作如果取向已经正确
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;

    // 我们需要计算合适的变换使正直的形象。
    // 我们用2步骤:如果左/右/向下旋转,然后如果镜像翻转。
    CGAffineTransform transform = CGAffineTransformIdentity;

    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;

        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;

        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }

    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;

        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }

    // 现在我们把底层CGImage到一个新的背景下,应用变换
    // 上面的计算。
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;

        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }

    // 现在我们创建一个新的用户界面图像从绘图上下文
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);

    return img;
}

/// base64 String 转 UImage
+ (UIImage *)imageFormBase64String:(NSString *)base64String {
    UIImage *image = [[UIImage alloc] init];
    NSData *data = [base64String dataUsingEncoding:NSUTF8StringEncoding];
    NSData *imageData = [[NSData alloc] initWithBase64EncodedData:data options:NSDataBase64DecodingIgnoreUnknownCharacters];
    if (imageData == nil) { // 如果数据不正确，添加"=="重试
        NSString *newStr = [NSString stringWithFormat:@"%@==", base64String];
        data = [newStr dataUsingEncoding:NSUTF8StringEncoding];
        imageData = [[NSData alloc] initWithBase64EncodedData:data options:NSDataBase64DecodingIgnoreUnknownCharacters];
    }
    if (imageData != nil) {
        image = [[UIImage alloc] initWithData:imageData];
    }
    return image;
}

/// UImage 转 base64 String
- (NSString *)toBase64String {
    return [UIImagePNGRepresentation(self) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

#pragma mark - 添加水印

/// 根据目标图片制作一个盖水印的图片
/// @param originalImage 源图片
/// @param title 水印文字
/// @param markFont 水印文字font(如果不传默认为23)
/// @param markColor 水印文字颜色(如果不传递默认为源图片的对比色)
+ (UIImage *)getWaterMarkImage: (UIImage *)originalImage
                      andTitle: (NSString *)title
                   andMarkFont: (UIFont *)markFont
                  andMarkColor: (UIColor *)markColor {
    UIFont *font = markFont;
    if (font == nil) {
        font = [UIFont systemFontOfSize:23];
    }
    UIColor *color = markColor;
    if (color == nil) {
        color = [self mostColor:originalImage];
        if (color == nil) {
            color = [UIColor colorWithRed:174/255.0 green:174/255.0 blue:174/255.0 alpha:0.2];
        }
    }
    // 原始image的宽高
    CGFloat viewWidth = originalImage.size.width;
    CGFloat viewHeight = originalImage.size.height;
    // 为了防止图片失真，绘制区域宽高和原始图片宽高一样
    UIGraphicsBeginImageContext(CGSizeMake(viewWidth, viewHeight));
    // 先将原始image绘制上
    [originalImage drawInRect:CGRectMake(0, 0, viewWidth, viewHeight)];
    // sqrtLength：原始image的对角线length。在水印旋转矩阵中只要矩阵的宽高是原始image的对角线长度，无论旋转多少度都不会有空白。
    CGFloat sqrtLength = sqrt(viewWidth*viewWidth + viewHeight*viewHeight);
    // 文字的属性
    NSDictionary *attr = @{
        // 设置字体大小
        NSFontAttributeName: font,
        // 设置文字颜色
        NSForegroundColorAttributeName :color,
    };
    NSString* mark = title;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:mark attributes:attr];
    // 绘制文字的宽高
    CGFloat strWidth = attrStr.size.width;
    CGFloat strHeight = attrStr.size.height;

    // 开始旋转上下文矩阵，绘制水印文字
    CGContextRef context = UIGraphicsGetCurrentContext();

    // 将绘制原点（0，0）调整到源image的中心
    CGContextConcatCTM(context, CGAffineTransformMakeTranslation(viewWidth/2, viewHeight/2));
    // 以绘制原点为中心旋转
    CGContextConcatCTM(context, CGAffineTransformMakeRotation(CG_TRANSFORM_ROTATION));
    // 将绘制原点恢复初始值，保证当前context中心和源image的中心处在一个点(当前context已经旋转，所以绘制出的任何layer都是倾斜的)
    CGContextConcatCTM(context, CGAffineTransformMakeTranslation(-viewWidth/2, -viewHeight/2));

    // 计算需要绘制的列数和行数
    int horCount = sqrtLength / (strWidth + HORIZONTAL_SPACE) + 1;
    int verCount = sqrtLength / (strHeight + VERTICAL_SPACE) + 1;

    // 此处计算出需要绘制水印文字的起始点，由于水印区域要大于图片区域所以起点在原有基础上移
    CGFloat orignX = -(sqrtLength-viewWidth)/2;
    CGFloat orignY = -(sqrtLength-viewHeight)/2;

    // 在每列绘制时X坐标叠加
    CGFloat tempOrignX = orignX;
    // 在每行绘制时Y坐标叠加
    CGFloat tempOrignY = orignY;
    for (int i = 0; i < horCount * verCount; i++) {
        [mark drawInRect:CGRectMake(tempOrignX, tempOrignY, strWidth, strHeight) withAttributes:attr];
        if (i % horCount == 0 && i != 0) {
            tempOrignX = orignX;
            tempOrignY += (strHeight + VERTICAL_SPACE);
        }else{
            tempOrignX += (strWidth + HORIZONTAL_SPACE);
        }
    }
    // 根据上下文制作成图片
    UIImage *finalImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGContextRestoreGState(context);
    return finalImg;
}

// 根据图片获取图片的主色调
+ (UIColor*)mostColor:(UIImage*)image {

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
    // 第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大
    CGSize thumbSize=CGSizeMake(image.size.width/2, image.size.height/2);

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 thumbSize.width,
                                                 thumbSize.height,
                                                 8,// bits per component
                                                 thumbSize.width*4,
                                                 colorSpace,
                                                 bitmapInfo);

    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect, image.CGImage);
    CGColorSpaceRelease(colorSpace);

    // 第二步 取每个点的像素值
    unsigned char* data = CGBitmapContextGetData (context);
    if (data == NULL) {
        CGContextRelease(context);
        return nil;
    }
    NSCountedSet *cls = [NSCountedSet setWithCapacity:thumbSize.width*thumbSize.height];

    for (int x = 0; x < thumbSize.width; x ++) {
        for (int y = 0; y < thumbSize.height; y ++) {
            int offset = 4*(x*y);
            int red = data[offset];
            int green = data[offset+1];
            int blue = data[offset+2];
            int alpha =  data[offset+3];
            if (alpha > 0) { // 去除透明
                if (red == 255 && green == 255 && blue == 255) {//去除白色
                } else {
                    NSArray *clr = @[@(red), @(green), @(blue), @(alpha)];
                    [cls addObject:clr];
                }

            }
        }
    }
    CGContextRelease(context);
    // 第三步 找到出现次数最多的那个颜色
    NSEnumerator *enumerator = [cls objectEnumerator];
    NSArray *curColor = nil;
    NSArray *MaxColor=nil;
    NSUInteger MaxCount=0;
    while ((curColor = [enumerator nextObject]) != nil)
    {
        NSUInteger tmpCount = [cls countForObject:curColor];
        if (tmpCount < MaxCount) continue;
        MaxCount=tmpCount;
        MaxColor=curColor;
    }
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
}

@end
