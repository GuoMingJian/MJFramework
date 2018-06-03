//
//  NSString+AES.h
//  MJFramework
//
//  Created by 郭明健 on 2018/6/2.
//  Copyright © 2018年 GuoMingJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AES)

- (NSString *)aes256_encryptForKey:(NSString *)key;
- (NSString *)aes256_decryptForKey:(NSString *)key;

- (NSString *)aes128_encryptForKey:(NSString *)key;
- (NSString *)aes128_decryptForKey:(NSString *)key;

@end
