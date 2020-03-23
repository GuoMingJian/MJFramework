//
//  UIFont+Ext.h
//  OC_MJFramework
//
//  Created by 郭明健 on 2020/3/20.
//  Copyright © 2020 GuoMingJian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (Ext)

/// PingFangSC-Light
/// @param fontSize 字体大小
+ (UIFont *)PFLight:(CGFloat)fontSize;

/// PingFangSC-Regular
/// @param fontSize 字体大小
+ (UIFont *)PFRegular:(CGFloat)fontSize;

/// PingFangSC-Medium
/// @param fontSize 字体大小
+ (UIFont *)PFMedium:(CGFloat)fontSize;

@end

NS_ASSUME_NONNULL_END
