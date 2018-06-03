//
//  MJBaseNavigationController.h
//  MJFramework
//
//  Created by 郭明健 on 2018/6/2.
//  Copyright © 2018年 GuoMingJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJBaseNavigationController : UINavigationController

@property (nonatomic, strong) UIBarButtonItem *speaceItem;
@property (nonatomic, strong) UIBarButtonItem *backItem;
@property (nonatomic, copy) NSString *backImgStr;

/**
 设置导航栏背景色
 
 @param color 背景色
 */
- (void)setBarTintColor:(UIColor *)color;

/**
 设置title样式
 
 example:
 NSDictionary *textAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont fontWithName:@"PingFangSC-Medium" size:19.0f]};
 
 @param attributes 样式
 */
- (void)setTitleTextAttributes:(NSDictionary *)attributes;

/**
 添加全屏右划返回手势
 */
- (void)addFullScreenBackGesture;

@end
