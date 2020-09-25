//
//  MJURLSession.h
//  NSURLSession_Test
//
//  Created by 郭明健 on 2018/9/3.
//  Copyright © 2018年 GuoMingJian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 接口回调
 
 @param result 返回数据
 @param error 错误信息
 */
typedef void(^RequestBlock)(id result, NSError *error);

/// 上传、下载百分比
typedef void(^RequestProgress)(CGFloat percentage);

@interface MJURLSession : NSObject

+ (instancetype)sharedInstance;

/// GET请求
/// @param url URL
/// @param param body 参数
/// @param headers header 参数
/// @param uploadProgress 上传百分比
/// @param resultsBlock 回调
- (void)getRequestUrl:(NSString *)url
                param:(NSDictionary *)param
              headers:(NSDictionary *)headers
             progress:(RequestProgress)uploadProgress
         resultsBlock:(RequestBlock)resultsBlock;

/// POST请求
/// @param url URL
/// @param param body 参数
/// @param headers header 参数
/// @param downloadProgress 下载百分比
/// @param resultsBlock 回调
- (void)postRequestUrl:(NSString *)url
                 param:(NSDictionary *)param
               headers:(NSDictionary *)headers
              progress:(RequestProgress)downloadProgress
          resultsBlock:(RequestBlock)resultsBlock;

/// 取消网络请求
- (void)cancel;

@end
