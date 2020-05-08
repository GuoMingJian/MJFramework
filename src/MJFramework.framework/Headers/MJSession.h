//
//  MJSession.h
//  NSURLSession_Test
//
//  Created by 郭明健 on 2018/9/3.
//  Copyright © 2018年 GuoMingJian. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 接口回调
 
 @param result 返回数据
 @param error 错误信息
 */
typedef void(^RequestBlock)(id result, NSError *error);

@interface MJSession : NSObject

+ (instancetype)sharedInstance;

/// POST请求
/// @param url URL
/// @param param body 参数
/// @param headers header 参数
/// @param resultsBlock 回调
- (void)postRequestUrl:(NSString *)url
                 param:(NSDictionary *)param
               headers:(NSDictionary *)headers
          resultsBlock:(RequestBlock)resultsBlock;

/// GET请求
/// @param url URL
/// @param param body 参数
/// @param headers header 参数
/// @param resultsBlock 回调
- (void)getRequestUrl:(NSString *)url
                param:(NSDictionary *)param
              headers:(NSDictionary *)headers
         resultsBlock:(RequestBlock)resultsBlock;

/**
 取消接口请求
 */
- (void)cancel;

@end
