//
//  NSObject+el_initializer.h
//  Pods
//
//  Created by 金秋成 on 16/10/13.
//
//

#import <Foundation/Foundation.h>

typedef void(^InitializerBlock)(id obj);


@interface NSObject (el_initializer)

//通用的初始化方法block携带self
+(instancetype)el_initialize:(InitializerBlock)block;

//通用获取单利的方法block携带self
+(instancetype)el_singleton:(InitializerBlock)block;

@end
