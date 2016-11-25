//
//  ELResponse.m
//  ELNetworking
//
//  Created by 金秋成 on 16/7/9.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "ELResponse.h"


@implementation ELResponseHeader

+ (instancetype)responseWithDictionary:(NSDictionary *)dict{
    NSError * error = nil;
    return  [[self alloc]initWithDictionary:dict error:&error];
}

+(JSONKeyMapper *)keyMapper{
    return [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];
}
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

@end

@implementation ELResponse

+ (instancetype)responseWithDictionary:(NSDictionary *)dict{
    NSError * error = nil;
    return  [[self alloc]initWithDictionary:dict error:&error];
}

+(JSONKeyMapper *)keyMapper{
    return [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];
}
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}


@end
