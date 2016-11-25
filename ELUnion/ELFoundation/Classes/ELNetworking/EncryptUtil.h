//
//  EncryptUtil.h
//  Ecai
//
//  Created by wangjie.zhao on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonCryptor.h>

@interface EncryptUtil : NSObject

+(NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key;
+(NSString *) decryptUseDES:(NSString*)cipherText key:(NSString *)key;

+(NSString *) doCipher:(NSString *)plainText key:(NSString *)key operation:(CCOperation)encryptOrDecrypt;

@end
