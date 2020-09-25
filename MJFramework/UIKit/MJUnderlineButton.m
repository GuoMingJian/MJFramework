//
//  MJUnderlineButton.m
//  MicroCoupletTaxi
//
//  Created by 郭明健 on 2020/9/18.
//  Copyright © 2020 GuoMingJian. All rights reserved.
//

#import "MJUnderlineButton.h"

@implementation MJUnderlineButton

- (id)init {
    if (self = [super init]) {
        _isShowLine = YES;
        _lineSpac = 2;
    }
    return self;
}

+ (MJUnderlineButton*)underlineButton
{
    MJUnderlineButton* button = [[MJUnderlineButton alloc] init];
    button.isShowLine = YES;
    button.lineSpac = 2;
    return button;
}

- (void)drawRect:(CGRect)rect
{
    if (_lineSpac < 2) {
        _lineSpac = 2;
    }
    UIColor *lineColor = self.titleLabel.textColor;
    if (!_isShowLine) {
        lineColor = UIColor.clearColor;
    }
    CGRect textRect = self.titleLabel.frame;
    CGFloat descender = self.titleLabel.font.descender + _lineSpac;
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(contextRef, lineColor.CGColor);
    CGContextMoveToPoint(contextRef, textRect.origin.x, textRect.origin.y + textRect.size.height + descender);
    CGContextAddLineToPoint(contextRef, textRect.origin.x + textRect.size.width, textRect.origin.y + textRect.size.height + descender);
    CGContextClosePath(contextRef);
    CGContextDrawPath(contextRef, kCGPathStroke);
}

@end
