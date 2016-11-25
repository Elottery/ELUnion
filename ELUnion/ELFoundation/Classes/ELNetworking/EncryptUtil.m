//
//  EncryptUtil.m
//  Ecai
//
//  Created by wangjie.zhao on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EncryptUtil.h"

#import "NSData+Category.h"
#import "GTMBase64.h"


@implementation EncryptUtil
static Byte iv2[] = {1,2,3,4,5,6,7,8};

+(NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key{
    NSString *ciphertext = nil;
    
    NSData *textData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [textData length];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES, kCCOptionPKCS7Padding, [key UTF8String], kCCKeySizeDES, iv2, [textData bytes], dataLength, buffer, 1024, &numBytesEncrypted);
    
    if(cryptStatus == kCCSuccess){
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        ciphertext = [GTMBase64 stringByEncodingData:[GTMBase64 encodeData:data]];
    }
    
    return ciphertext;
}

+(NSString *) decryptUseDES:(NSString*)cipherText key:(NSString *)key{
    NSString *ciphertext = nil;
    
    return ciphertext;
}

+(NSString *) doCipher:(NSString *)plainText key:(NSString *)key operation:(CCOperation)encryptOrDecrypt
{
    const void * vplainText;
    size_t plainTextBufferSize;
    
    if (encryptOrDecrypt == kCCDecrypt)
    {
        NSData * EncryptData = [GTMBase64 decodeData:[plainText
                                                      dataUsingEncoding:NSUTF8StringEncoding]];
        
        plainTextBufferSize = [EncryptData length];
        vplainText = [EncryptData bytes];
        
    }
    else
    {
        NSData * tempData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
        plainTextBufferSize = [tempData length];
        vplainText = [tempData bytes];
    }
    
    CCCryptorStatus ccStatus;
    uint8_t * bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
        // uint8_t ivkCCBlockSize3DES;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSizeDES)
    & ~(kCCBlockSizeDES - 1);
    
    bufferPtr = malloc(bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
//    NSString * initVec = @"init Vec";
    
    const void * vkey = (const void *)[key UTF8String];
//    const void * vinitVec = (const void *)[initVec UTF8String];
    
    uint8_t iv[kCCBlockSizeDES];
    memset((void *) iv, 0x0, (size_t) sizeof(iv));
    
    ccStatus = CCCrypt(encryptOrDecrypt,
                       kCCAlgorithmDES,
                       kCCOptionPKCS7Padding,
                       vkey, //"123456789012345678901234", //key
                       kCCKeySizeDES,
                       iv2, //"init Vec", //iv,
                       vplainText, //plainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);

    
        //if (ccStatus == kCCSuccess) NSLog(@"SUCCESS");
//    if (ccStatus == kCCParamError) return @"PARAM ERROR";
//    else if (ccStatus == kCCBufferTooSmall) return @"BUFFER TOO SMALL";
//    else if (ccStatus == kCCMemoryFailure) return @"MEMORY FAILURE";
//    else if (ccStatus == kCCAlignmentError) return @"ALIGNMENT";
//    else if (ccStatus == kCCDecodeError) return @"DECODE ERROR";
//    else if (ccStatus == kCCUnimplemented) return @"UNIMPLEMENTED";
//    
    NSString * result;
    
    if (encryptOrDecrypt == kCCDecrypt)
    {
        result = [[NSString alloc] initWithData:[NSData
                                                  dataWithBytes:(const void *)bufferPtr
                                                  length:(NSUInteger)movedBytes]  
                                        encoding:NSUTF8StringEncoding];
    }
    else
    {
        NSData * myData = [NSData dataWithBytes:(const void *)bufferPtr
                                         length:(NSUInteger)movedBytes];
        
        result = [GTMBase64 stringByEncodingData:myData];
    }
    
    return result;
    
}




@end
