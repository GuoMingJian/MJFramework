//
//  MJLoopScrollView.h
//  ZXToolProjects
//
//  Created by 郭明健 on 2018/6/25.
//  Copyright © 2018年 GuoMingJian. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 轮播图
@interface MJLoopScrollView : UIView

/*
 PageControl的位置
 */
typedef NS_ENUM(NSInteger, MJPageControlAlignment)
{
    MJPageControlBottomCenter = 0, //居下中 默认
    MJPageControlBottomLeft,       //居下左
    MJPageControlBottomRight,      //居下右
};

/**
 *  需要显示的页数
 */
@property (assign, nonatomic, readonly) NSInteger pageCount;

/**
 *  每一张图片展示的时间
 */
@property (assign, nonatomic) NSTimeInterval timeInterval;

/**
 *  是否自动滚动
 */
@property (assign, nonatomic) BOOL autoScroll;

/**
 *  是否显示pageControl
 */
@property (assign, nonatomic) BOOL showPageControl;

/**
 pageControl 距离底部的距离，默认0px
 */
@property (assign, nonatomic) CGFloat pageControlSpacBottom;

/**
 *  pageControl 默认颜色
 */
@property (strong, nonatomic) UIColor *defaultColor;

/**
 *  pageControl 选中颜色
 */
@property (strong, nonatomic) UIColor *selectedColor;

//==================自定义圆点图片样式==================

/**
 *  pageControl 自定义-默认图片
 */
@property (strong, nonatomic) UIImage *defaultImage;

/**
 *  pageControl 未选中圆点-默认大小(7,7)
 */
@property (assign, nonatomic) CGSize defaultImageSize;

/**
 *  pageControl 自定义-选中图片
 */
@property (strong, nonatomic) UIImage *selectedImage;

/**
 *  pageControl 选中圆点-默认大小(7,7)
 */
@property (assign, nonatomic) CGSize selectedImageSize;

#pragma mark - private Funtions

/**
 销毁定时器
 */
- (void)invalidateTimer;

/**
 暂停定时器
 */
- (void)pauseTimer;

/**
 开启定时器
 */
- (void)startTimer;

/**
 设置pageControl 位置
 */
- (void)setPageControlAlignment:(MJPageControlAlignment)alignment;

/**
 图片开始轮播，图片点击事件
 */
- (void)startAutoRunningImages:(NSArray *)images
                   clickAction:(void(^)(UIImageView *imageView, int index))action;

/**
 轮播图Frame改变，用于监听屏幕旋转
 */
- (void)orientChangeUpdateFrame:(CGRect)frame;

@end
