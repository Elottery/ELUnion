//
//  ELBaseService.m
//  Elottory
//
//  Created by 金秋成 on 16/8/19.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "ELBaseService.h"
#import "ELBaseNetworkingService.h"
#import "APPInfo.h"
@implementation ELBaseService
{
    ELBaseNetworkingService * _netWorkService;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _netWorkService =  [ELBaseNetworkingService sharedService];
        ELBaseNetworkingServiceConfiguration * conf = [[ELBaseNetworkingServiceConfiguration alloc]init];
        conf.HOST = [APPInfo APIHOST];
        conf.clientVersion = [APPInfo apiVersion];
        _netWorkService.defaultConfig = conf;
    }
    return self;
}

-(void)loadData{
    id<ELRequestProtocol> requestObj = self.request;
    if (!requestObj) {
        NSLog(@"请求不可为空");
        return;
    }
    __weak typeof(self) weakSelf = self;
    
    [[ELBaseNetworkingService sharedService]request:^id<ELRequestProtocol>{
        return requestObj;
    } withUserToken:^NSString *{
        NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:ELBaseNetworkingService_JSESSIONID];
        return token;
    } didStart:^{
        [weakSelf.delegate didStartLoadService:weakSelf];
    } uploadProgress:^(NSProgress *progress) {
        
    } downloadProgress:^(NSProgress *progress) {
        
    } didFinish:^(id<ELResponseProtocol> response, NSError *error) {
        if (error) {
            [weakSelf.delegate service:weakSelf loadDataFailWithError:error];
        }
        else{
            [weakSelf.delegate service:weakSelf loadDataSuccessWithResponse:response];
        }
    }];
}




@end
