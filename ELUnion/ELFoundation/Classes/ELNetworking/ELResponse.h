//
//  ELResponse.h
//  ELNetworking
//
//  Created by 金秋成 on 16/7/9.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ELConstant.h"
#import "ELModel.h"

@class ELResponseHeader;

@protocol ELResponseProtocol <NSObject>

@property (nonatomic,copy)NSString * protocolId;

@property (nonatomic,assign)NSTimeInterval cTime;//客户端请求发起的时间

@property (nonatomic,assign)NSUInteger status;//ELResponseStatus

@property (nonatomic,assign)NSString * memo;


+ (instancetype)responseWithDictionary:(NSDictionary *)dict;

@optional

- (NSString *)decryptKey;

- (NSString *)toJSONString;

- (ELResponseHeader *)header;

@end


@interface ELResponseHeader : JSONModel
@property (nonatomic,strong)NSString * version;
@property (nonatomic,strong)NSString * sid;
@property (nonatomic,assign)long       duration;
@end


@interface ELResponse : JSONModel<ELResponseProtocol>
@property (nonatomic,copy)NSString * protocolId;
@property (nonatomic,assign)NSTimeInterval cTime;
@property (nonatomic,assign)NSUInteger  status;//ELResponseStatus
@property (nonatomic,assign)NSString * memo;
@property (nonatomic,strong)ELResponseHeader * header;
@end
