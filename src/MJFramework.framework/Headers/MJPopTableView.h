//
//  MJPopTableView.h
//  MJFramework
//
//  Created by 郭明健 on 2018/6/2.
//  Copyright © 2018年 GuoMingJian. All rights reserved.
//

/*
 用法：
 //CGFloat width = self.btn.width;
 //CGPoint leftTopPonint = self.btn.bottomLeft;//指定popivew出现的左上角的point
 NSArray *dataArr = @[@"美食", @"学校", @"公交", @"地铁", @"银行", @"赛事总奖金50万元",];
 
 MJPopTableView *popView = [[MJPopTableView alloc] init];
 //popView.alignment = NSTextAlignmentCenter;
 [popView setupUIWithDataSource:dataArr width:width rowHeight:50 showMaxCount:3 leftTopPoint:leftTopPonint atSuperView:self.view];
 
 [popView setSelectItemBlock:^(NSString *item, NSInteger index) {
 NSLog(@"%ld--%@", index, item);
 }];
 */

#import <UIKit/UIKit.h>

//index = -1 时，点击的是背景view
typedef void (^DidSelectItemBlock)(NSString *item, NSInteger index);

@interface MJPopTableView : UIView

@property (nonatomic, copy) DidSelectItemBlock selectItemBlock;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, assign) NSTextAlignment alignment;
@property (nonatomic, assign) NSInteger spacOfRight;//三角形跟tableview右边间距，默认15

- (void)setFont:(UIFont *)font
      textColor:(UIColor *)color
      alignment:(NSTextAlignment)alignment;

- (instancetype)setupUIWithDataSource:(NSArray *)datasource
                                width:(CGFloat)width
                            rowHeight:(CGFloat)rowHeight
                         showMaxCount:(CGFloat)maxCount
                         leftTopPoint:(CGPoint)leftTopPoint
                          atSuperView:(UIView *)supView;

@end
