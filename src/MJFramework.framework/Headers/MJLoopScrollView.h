//
//  MJLoopScrollView.h
//  MJFramework
//
//  Created by 郭明健 on 2018/6/2.
//  Copyright © 2018年 GuoMingJian. All rights reserved.
//

//========用法============
/*
 //1.确保包含头文件
 //#import "MJLoopScrollView.h"
 
 //2.创建循环滚动视图
 MJLoopScrollView *mjLoopScrollView = [[MJLoopScrollView alloc] init];
 //mjLoopScrollView.frame = superView.bounds;
 //[superView addSubview:mjLoopScrollView];
 
 //图片数组
 NSMutableArray *imageM = [NSMutableArray array];
 [imageM addObject:@"http://www.zgzhizhu.com/public/uploads/images/2016/03/20160330222230118.jpg"];
 [imageM addObject:@"http://img04.tooopen.com/images/20131017/sy_42787413252.jpg"];
 [imageM addObject:@"http://pic1a.nipic.com/2008-11-13/200811139126243_2.jpg"];
 [imageM addObject:@"http://pic5.nipic.com/20100121/1396946_104643942888_2.jpg"];
 
 [mjLoopScrollView startAutoRunningImages:imageM clickAction:^(UIImageView *imageView, int index) {
 NSLog(@"您点击的是:图片%d", index);
 }];
 
 //info.plist添加: App Transport Security Settings  -->  Allow Arbitrary Loads : YES
 */
//=======================

#import <UIKit/UIKit.h>

@interface MJLoopScrollView : UIView

/*
 PageControl的位置
 */
typedef NS_ENUM(NSInteger, MJPageControlAlignment)
{
    MJBottomCenter = 0, //居下中 默认
    MJBottomLeft = 1,   //居下左
    MJBottomRight = 2,  //居下右
    
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
 pageControl 距离底部的距离，默认5px
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

#pragma mark - private Funtions

/**
 销毁定时器
 */
-(void)invalidateTimer;

/**
 暂停定时器
 */
-(void)pauseTimer;

/**
 开启定时器
 */
-(void)startTimer;

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
 轮播图Frame改变，一般用户屏幕旋转
 */
- (void)orientChangeUpdateFrame:(CGRect)frame;

@end
