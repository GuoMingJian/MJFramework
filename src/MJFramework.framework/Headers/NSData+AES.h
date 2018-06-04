//
//  NSData+AES.h
//  MJFramework
//
//  Created by 郭明健 on 2018/6/2.
//  Copyright © 2018年 GuoMingJian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@interface NSData (AES)

- (NSData *)aes256_encryptForKey:(NSString *)key;
- (NSData *)aes256_decryptForKey:(NSString *)key;

- (NSData *)AES128EncryptWithKey:(NSString *)key gIv:(NSString *)Iv;   //加密
- (NSData *)AES128DecryptWithKey:(NSString *)key gIv:(NSString *)Iv;   //解密

@end
