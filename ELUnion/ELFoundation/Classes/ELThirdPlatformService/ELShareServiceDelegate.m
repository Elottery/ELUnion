//
//  ELShareServiceDelegate.m
//  Elottory
//
//  Created by 金秋成 on 16/9/3.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "ELShareServiceDelegate.h"

#import <TencentOpenAPI/QQApiInterface.h>

@interface ELShareServiceDelegate ()<WXApiDelegate,QQApiInterfaceDelegate>

@end

@implementation ELShareServiceDelegate
#pragma mark -wechat delegate
-(void)onReq:(id)req{//BaseReq , QQBaseReq
    
}

-(void)onResp:(id)resp{//BaseResp , QQBaseResp
    
}

#pragma mark -qq delegate

- (void)isOnlineResponse:(NSDictionary *)response{
    
}


@end
