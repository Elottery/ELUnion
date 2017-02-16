//
//  ELRequest.m
//  ELNetworking
//
//  Created by 金秋成 on 16/7/9.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "ELRequest.h"
#import "ELResponse.h"
#import "ELBaseNetworkingService.h"

@implementation ELRequest

-(instancetype)initWithURLPath:(NSString *)URLPath
                      useHttps:(BOOL)https
                        header:(NSDictionary *)headerDict
                          type:(ELRequestType)type
                        params:(NSDictionary *)paramDict{
    self = [super init];
    if (self) {
        _URLPath    = URLPath;
        _https      = https;
        _headerDict = headerDict;
        _type       = type;
        _paramDict  = paramDict;
    }
    return self;
}

//不会触发请求动作
-(instancetype)validate:(ELValidateBlock)validateBlock{
    _validateBlock = [validateBlock copy];
    
    return self;
}
//不会触发请求动作
-(instancetype)progress:(ELProgressBlock)progressBlock{
    _progressBlock = [progressBlock copy];
    return self;
}
//会触发请求动作
-(void)response:(ELResponseBlock)responseBlock{
    _responseBlock = [responseBlock copy];
}


-(NSURLRequest *)getRequest{
    NSData  * requestData = nil;
    //组装请求
    NSMutableURLRequest * URLRequest = nil;
    NSMutableString * URLStr = [NSMutableString stringWithFormat:@"%@",self.URLPath];

    if (self.https) {//添加
        if (![URLStr hasPrefix:@"https"]) {
            [URLStr insertString:@"s" atIndex:4];
        }
    }
    else{//移除
        if ([URLStr hasPrefix:@"https"]) {
            [URLStr deleteCharactersInRange:NSMakeRange(4, 1)];
        }
    }
    
    URLRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLStr] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
    [self.headerDict enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, NSString *  _Nonnull obj, BOOL * _Nonnull stop) {
        [URLRequest setValue:obj forHTTPHeaderField:key];
    }];
    if (self.type == ELRequestType_GET) {
        [URLRequest setHTTPMethod:@"GET"];
        NSMutableArray * keyValueArr = [NSMutableArray new];
        [self.paramDict enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, NSString *  _Nonnull obj, BOOL * _Nonnull stop) {
            [keyValueArr addObject:[NSString stringWithFormat:@"%@=%@",key,obj]];
        }];
        URLStr = [URLStr stringByAppendingString:[keyValueArr componentsJoinedByString:@"&"]];
        URLRequest.URL = [NSURL URLWithString:URLStr];
    }
    else{
        [URLRequest setHTTPMethod:@"POST"];
        [URLRequest setHTTPBody:[NSJSONSerialization dataWithJSONObject:self.paramDict options:NSJSONWritingPrettyPrinted error:nil]];
    }
    return URLRequest;
}

@end
