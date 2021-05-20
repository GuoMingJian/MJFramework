//
//  UIFont+Ext.m
//  OC_MJFramework
//
//  Created by 郭明健 on 2020/3/20.
//  Copyright © 2020 GuoMingJian. All rights reserved.
//

#import "UIFont+Ext.h"

@implementation UIFont (Ext)

#pragma mark - PingFangSC 字体

/// PingFangSC-Light
/// @param fontSize 字体大小
+ (UIFont *)PFLight:(CGFloat)fontSize {
    return [UIFont fontWithName:@"PingFangSC-Light" size:fontSize];
}

/// PingFangSC-Regular
/// @param fontSize 字体大小
+ (UIFont *)PFRegular:(CGFloat)fontSize {
    return [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize];
}

/// PingFangSC-Medium
/// @param fontSize 字体大小
+ (UIFont *)PFMedium:(CGFloat)fontSize {
    return [UIFont fontWithName:@"PingFangSC-Medium" size:fontSize];
}

/// PingFangSC-Semibold
/// @param fontSize 字体大小
+ (UIFont *)PFSemibold:(CGFloat)fontSize {
    return [UIFont fontWithName:@"PingFangSC-Semibold" size:fontSize];
}

/// PingFangSC-Ultralight
/// @param fontSize 字体大小
+ (UIFont *)PFUltralight:(CGFloat)fontSize {
    return [UIFont fontWithName:@"PingFangSC-Ultralight" size:fontSize];
}

/// PingFangSC-Thin
/// @param fontSize 字体大小
+ (UIFont *)PFThin:(CGFloat)fontSize {
    return [UIFont fontWithName:@"PingFangSC-Thin" size:fontSize];
}

@end
