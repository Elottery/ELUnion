//
//  ELBaseNetworkingService.h
//  ELNetworking
//
//  Created by 金秋成 on 16/7/8.
//  Copyright © 2016年 金秋成. All rights reserved.
//


#import <AFNetworking/AFURLSessionManager.h>
#import "ELBaseNetworkingServiceConfiguration.h"
#import "ELRequest.h"
#import "ELResponse.h"

extern NSString * const ELBaseNetworkingService_JSESSIONID;
extern NSString * const ELBaseNetworkingService_WOKE;

typedef id<ELRequestProtocol>(^ELReturnRequestBlock)();
typedef BOOL(^ELReturnBoolBlock)();
typedef NSString *(^ELReturnStringBlock)();
typedef void(^ELNormalBlock)();
typedef void(^ELProgressBlock)(NSProgress * progress);
typedef void(^ELResponseBlock)(id<ELResponseProtocol> response,NSError * error);

@interface ELBaseNetworkingService : NSObject

+(instancetype)sharedService;

@property (nonatomic,strong)ELBaseNetworkingServiceConfiguration * defaultConfig;



/**
 *  请求方法
 *
 *  @param request        返回请求对象
 *  @param start          开始请求回调
 *  @param uploadProgress 上传进度回调
 *  @param uploadProgress 下载进度回调
 *  @param response       下载完成回调
 */
-   (void)request:(ELReturnRequestBlock)request
    withUserToken:(ELReturnStringBlock)token
         didStart:(ELNormalBlock)start
   uploadProgress:(ELProgressBlock)uploadProgress
 downloadProgress:(ELProgressBlock)uploadProgress
        didFinish:(ELResponseBlock)response;


@end
