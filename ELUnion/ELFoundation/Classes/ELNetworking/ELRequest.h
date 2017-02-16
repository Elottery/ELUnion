//
//  ELRequest.h
//  ELNetworking
//
//  Created by 金秋成 on 16/7/9.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "ELResponse.h"

typedef void(^ELProgressBlock)(NSProgress * progress);
typedef void(^ELResponseBlock)(id<ELResponseProtocol> response,NSError * error);
typedef void(^ELJSONResponseBlock)(NSDictionary * responseJSON,NSError * error);
typedef BOOL(^ELValidateBlock)(NSDictionary * paramDict);

typedef NS_ENUM(NSUInteger, ELRequestType) {
    ELRequestType_GET,
    ELRequestType_POST,
};

@interface ELRequest : NSObject

@property (nonatomic,strong,readonly)NSString * URLPath;
@property (nonatomic,assign,readonly)BOOL       https;
@property (nonatomic,assign,readonly)ELRequestType       type;
@property (nonatomic,strong,readonly)NSDictionary * headerDict;
@property (nonatomic,strong,readonly)NSDictionary * paramDict;
@property (nonatomic,copy,readonly)ELValidateBlock validateBlock;
@property (nonatomic,copy,readonly)ELProgressBlock progressBlock;
@property (nonatomic,copy,readonly)ELResponseBlock responseBlock;

@property (nonatomic,strong,readonly)NSURLRequest * request;

-(instancetype)initWithURLPath:(NSString *)URLPath
                      useHttps:(BOOL)https
                        header:(NSDictionary *)headerDict
                          type:(ELRequestType)type
                        params:(NSDictionary *)paramDict;

//不会触发请求动作
-(instancetype)validate:(ELValidateBlock)validateBlock;
//不会触发请求动作
-(instancetype)progress:(ELProgressBlock)progressBlock;
//会触发请求动作
-(void)response:(ELResponseBlock)responseBlock;


@end
