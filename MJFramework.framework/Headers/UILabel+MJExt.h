//
//  UILabel+MJExt.h
//  MJFramework
//
//  Created by 郭明健 on 2018/6/2.
//  Copyright © 2018年 GuoMingJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (MJExt)

@property (nonatomic) NSString *verticalText;

@end

/*
 NSString *string = @"床前明月光，疑是地上霜。";
 UILabel *label = [[UILabel alloc] initWithFrame:(CGRectMake(100, 100, 0, 0))];
 label.textColor = [UIColor redColor];
 label.verticalText = string;
 [label sizeToFit];
 [self.view addSubview:label];
 */
