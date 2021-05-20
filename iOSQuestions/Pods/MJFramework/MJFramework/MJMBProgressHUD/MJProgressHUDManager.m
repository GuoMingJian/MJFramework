//
//  MJProgressHUDManager.h
//  ZXToolProjects
//
//  Created by 郭明健 on 2018/6/26.
//  Copyright © 2018年 GuoMingJian. All rights reserved.
//

#import "MJProgressHUDManager.h"
#import "MJMBProgressHUD.h"

@implementation MJProgressHUDManager

+ (void)isShow:(BOOL)isShow
{
    [self isShow:isShow content:kDEFAULT_MESSAGE hudIsEnabled:YES];
}

+ (void)isShow:(BOOL)isShow
       content:(NSString*)content
{
    [self isShow:isShow content:content hudIsEnabled:YES];
}

+ (void)isShow:(BOOL)isShow
       content:(NSString*)content
  hudIsEnabled:(BOOL)isEnabled
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSArray *subViews = [UIApplication sharedApplication].keyWindow.subviews;
        for(UIView *subView in subViews)
        {
            if([subView isKindOfClass: [MJMBProgressHUD class]])
            {
                [((MJMBProgressHUD *) subView) hideAnimated:YES];
                [((MJMBProgressHUD *) subView) removeFromSuperview];
                break;
            }
        }
        
        if (isShow) {
            MJMBProgressHUD *HUD = [[MJMBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
            HUD.bezelView.backgroundColor = [UIColor blackColor];
            HUD.contentColor = [UIColor whiteColor];
            HUD.label.text = content;
            HUD.userInteractionEnabled = isEnabled;
            [[UIApplication sharedApplication].keyWindow addSubview:HUD];
            [HUD showAnimated:YES];
        } else {
        }
    });
}

+ (void)showText:(NSString *)text
        duration:(NSTimeInterval)duration
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MJMBProgressHUD *hud = [[MJMBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
        hud.margin = 16;
        hud.userInteractionEnabled = NO;
        hud.detailsLabel.text = text;
        hud.detailsLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        hud.minShowTime = duration;
        hud.mode = MJMBProgressHUDModeText;
        hud.bezelView.backgroundColor = [UIColor blackColor];
        hud.contentColor = [UIColor whiteColor];
        [[UIApplication sharedApplication].keyWindow addSubview:hud];
        [hud showAnimated:YES];
        [hud hideAnimated:YES afterDelay:duration];
    });
}

@end
