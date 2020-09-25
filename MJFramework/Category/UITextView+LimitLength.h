//
//  UITextView+LimitLength.m
//  OC_MJFramework
//
//  Created by 郭明健 on 2018/9/3.
//  Copyright © 2018年 GuoMingJian. All rights reserved.
//

/*
 PS:如果想给textView.text直接赋值，请务必在对placehoulder和limitLength之前进行。
 */

#import <UIKit/UIKit.h>

@interface UITextView (LimitLength)

/// 占位符，可与下面属性任意一个同时设置
@property (nonatomic, strong) NSString *placeholder;

/// 需要限制的字数，优先级高于lines
@property (nonatomic, copy) NSNumber *limitLength;

/// 需要限制的行数
@property (nonatomic, copy) NSNumber *limitLines;

/// 占位符文字，默认13号字体
@property (nonatomic, strong) UIFont *placeholdFont;

/// 行数、字数限制文字，默认13号字体
@property (nonatomic, strong) UIFont *limitPlaceFont;

/// 占位符文字颜色，默认灰色
@property (nonatomic, strong) UIColor *placeholdColor;

/// 行数、字数限制文字颜色，默认灰色
@property (nonatomic, strong) UIColor *limitPlaceColor;

/// 自动高度，默认不计算，设置@1自动计算高度
@property (nonatomic, copy) NSNumber *autoHeight;

@end
