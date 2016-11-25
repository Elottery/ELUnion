//
//  NSObject+el_initializer.m
//  Pods
//
//  Created by 金秋成 on 16/10/13.
//
//

#import "NSObject+el_initializer.h"

static NSObject   * _standardObject;


@implementation NSObject (el_initializer)
+(instancetype)el_initialize:(InitializerBlock)block{
    id instance = [[self alloc] init];
    block(instance);
    return instance;
}
+(instancetype)el_singleton:(InitializerBlock)block{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _standardObject = [[self alloc]init];
    });
    block(_standardObject);
    return _standardObject;
}
@end
