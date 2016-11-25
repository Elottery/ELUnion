//
//  ELModel.m
//  ELNetworking
//
//  Created by 金秋成 on 16/8/21.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "ELModel.h"

@implementation ELModel
+(JSONKeyMapper *)keyMapper{
    return [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];
}
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}
@end
