//
//  ELPlatform.h
//  Elottory
//
//  Created by 金秋成 on 16/9/3.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ELShareService_Platform_Type) {
    ELShareService_Platform_WECHAT,
    ELShareService_Platform_QQ
};

typedef NS_ENUM(NSUInteger, ELShareService_Platform_SubType) {
    ELShareService_Platform_WECHAT_SESSION,
    ELShareService_Platform_WECHAT_TIMELINE,
    ELShareService_Platform_QQ_SESSION,
    ELShareService_Platform_QQ_ZONE,
};

@interface ELPlatform : NSObject

@property (nonatomic,assign)ELShareService_Platform_Type    platform;

@property (nonatomic,assign)ELShareService_Platform_SubType subPlatform;

@property (nonatomic,strong)NSString * title;

@property (nonatomic,strong)NSString * detailTitle;

@end
