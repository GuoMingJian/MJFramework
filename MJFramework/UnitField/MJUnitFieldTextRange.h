//
//  MJUnitFieldTextRange.h
//  MicroCoupletTaxi
//
//  Created by 郭明健 on 2020/9/18.
//  Copyright © 2020 GuoMingJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJUnitFieldTextPosition.h"

NS_ASSUME_NONNULL_BEGIN

@interface MJUnitFieldTextRange : UITextRange <NSCopying>

@property (nonatomic, readonly) MJUnitFieldTextPosition *start;
@property (nonatomic, readonly) MJUnitFieldTextPosition *end;

@property (nonatomic, readonly) NSRange range;

+ (nullable instancetype)rangeWithStart:(MJUnitFieldTextPosition *)start
                                    end:(MJUnitFieldTextPosition *)end;

+ (nullable instancetype)rangeWithRange:(NSRange)range;

@end

NS_ASSUME_NONNULL_END
