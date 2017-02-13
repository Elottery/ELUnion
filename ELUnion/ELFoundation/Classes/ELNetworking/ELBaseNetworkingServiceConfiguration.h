//
//  ELBaseNetworkingServiceConfiguration.h
//  ELNetworking
//
//  Created by 金秋成 on 16/7/8.
//  Copyright © 2016年 金秋成. All rights reserved.
//



@interface ELBaseNetworkingServiceConfiguration : NSObject

@property (nonatomic,copy)  NSString     * HOST;

@property (nonatomic,copy)  NSString     * apiVersion;

@property (nonatomic,copy)  NSString     * clientVersion;

@property (nonatomic,copy)  NSData       * certificateData;

@end
