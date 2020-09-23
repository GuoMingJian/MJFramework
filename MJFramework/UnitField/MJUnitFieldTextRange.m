//
//  MJUnitFieldTextRange.m
//  MicroCoupletTaxi
//
//  Created by 郭明健 on 2020/9/18.
//  Copyright © 2020 GuoMingJian. All rights reserved.
//

#import "MJUnitFieldTextRange.h"

@implementation MJUnitFieldTextRange
@dynamic range;
@synthesize start = _start, end = _end;


+ (instancetype)rangeWithRange:(NSRange)range {
    if (range.location == NSNotFound)
        return nil;
    
    MJUnitFieldTextPosition *start = [MJUnitFieldTextPosition positionWithOffset:range.location];
    MJUnitFieldTextPosition *end = [MJUnitFieldTextPosition positionWithOffset:range.location + range.length];
    return [self rangeWithStart:start end:end];
}

+ (instancetype)rangeWithStart:(MJUnitFieldTextPosition *)start
                           end:(MJUnitFieldTextPosition *)end {
    if (!start || !end) return nil;
    assert(start.offset <= end.offset);
    MJUnitFieldTextRange *range = [[self alloc] init];
    range->_start = start;
    range->_end = end;
    return range;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    return [MJUnitFieldTextRange rangeWithStart:_start end:_end];
}

- (NSRange)range {
    return NSMakeRange(_start.offset, _end.offset - _start.offset);
}

@end
