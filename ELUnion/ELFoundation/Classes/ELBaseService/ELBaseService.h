//
//  ELBaseService.h
//  Elottory
//
//  Created by 金秋成 on 16/8/19.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "ELRequest.h"
#import "ELResponse.h"

typedef NS_ENUM(NSUInteger, ELBaseServiceLoadingState) {
    ELBaseServiceLoadingState_upload,
    ELBaseServiceLoadingState_download,
};

@class ELBaseService;

@protocol ELBaseServiceDelegate <NSObject>
@optional
/**
 *  数据请求开始
 *
 *  @param service 请求服务
 */
-(void)didStartLoadService:(ELBaseService *)service;

/**
 *  请求进度监控
 *
 *  @param service 请求服务
 *  @param uploadingProgress    上传进度
 *  @param downloadingProgress  下载进度
 */
-(void)service:(ELBaseService *)service
     loadState:(ELBaseServiceLoadingState)state
   andProgress:(double)progress;

/**
 *  请求成功回调
 *
 *  @param service 请求服务
 *  @param resp    resp
 */
-(void)service:(ELBaseService *)service loadDataSuccessWithResponse:(id<ELResponseProtocol>)resp;

/**
 *  请求失败回调
 *
 *  @param service 请求服务
 *  @param error   错误信息
 */
-(void)service:(ELBaseService *)service loadDataFailWithError:(NSError *)error;

@end



@interface ELBaseService : NSObject

@property (nonatomic,weak)id<ELBaseServiceDelegate> delegate;

-(void)loadData;

#pragma mark -subclassing

@property (nonatomic,strong)NSString * handler;

@property (nonatomic,strong)id<ELRequestProtocol> request;

@end
