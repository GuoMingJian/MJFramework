//
//  MJUnitFieldTextPosition.m
//  MicroCoupletTaxi
//
//  Created by 郭明健 on 2020/9/18.
//  Copyright © 2020 GuoMingJian. All rights reserved.
//

#import "MJUnitFieldTextPosition.h"

@implementation MJUnitFieldTextPosition

+ (instancetype)positionWithOffset:(NSInteger)offset {
    MJUnitFieldTextPosition *position = [[self alloc] init];
    position->_offset = offset;
    return position;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    return [MJUnitFieldTextPosition positionWithOffset:self.offset];
}

@end
