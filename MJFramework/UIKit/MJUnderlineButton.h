//
//  MJUnderlineButton.h
//  MicroCoupletTaxi
//
//  Created by 郭明健 on 2020/9/18.
//  Copyright © 2020 GuoMingJian. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 下划线按钮
@interface MJUnderlineButton : UIButton

/// 是否显示下划线，默认YES
@property (nonatomic, assign) BOOL isShowLine;
/// 下划线与文本间距，默认2px
@property (nonatomic, assign) CGFloat lineSpac;

+ (MJUnderlineButton*)underlineButton;

@end
