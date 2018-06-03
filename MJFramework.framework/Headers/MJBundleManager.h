//
//  MJBundleManager.h
//  MJFramework
//
//  Created by 郭明健 on 2018/6/2.
//  Copyright © 2018年 GuoMingJian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MJBundleManager : NSBundle

+ (NSBundle *)mainBundle;

+ (UIImage *)imageNamed:(NSString *)imageName;

@end
