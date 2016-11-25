//
//  ELRequest.m
//  ELNetworking
//
//  Created by 金秋成 on 16/7/9.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "ELRequest.h"
#import "ELResponse.h"
@implementation ELRequest
- (NSDictionary *)requestDictionary{
    return self.toDictionary;
}
-(NSString *)encryptKey{
    return @"wA1PW^T5";
}

-(NSString *)protocolId{
    return @"";
}

-(Class<ELResponseProtocol>)responseClass{
    return  [ELResponse class];
}
-(BOOL)needTokenAuth{
    return NO;
}


//jsonmodel相关
+(JSONKeyMapper *)keyMapper{
    return [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];
}
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}



@end
