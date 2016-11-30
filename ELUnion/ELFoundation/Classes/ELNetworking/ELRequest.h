//
//  ELRequest.h
//  ELNetworking
//
//  Created by 金秋成 on 16/7/9.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ELResponse.h"


@protocol ELRequestProtocol <NSObject>

/**
 *  接口地址协议
 *
 *  @return 接口地址
 */
//- (NSString *)methodURLStr;
- (NSString *)protocolId;
/**
 *  响应的对象类型
 *
 *  @return 响应的对象类型
 */
- (Class<ELResponseProtocol>)responseClass;
/**
 *  是否需要登陆权限
 *
 *  @return 需要YES 不需要NO
 */
- (BOOL)needTokenAuth;

@optional
/**
 *  aes加密KEY
 *
 *  @return aes加密KEY
 */
- (NSString *)encryptKey;

- (NSDictionary *)requestDictionary;

- (NSString *)toJSONString;

- (BOOL)isFileData;

- (NSData *)fileData;


@end

@interface ELRequest : JSONModel<ELRequestProtocol>

@end
