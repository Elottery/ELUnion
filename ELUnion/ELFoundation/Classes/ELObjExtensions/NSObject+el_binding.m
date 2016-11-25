//
//  NSObject+el_binding.m
//  Pods
//
//  Created by 金秋成 on 16/10/13.
//
//

#import "NSObject+el_binding.h"
#import <objc/runtime.h>
@implementation NSObject (el_binding)
//runtime绑定值
-(void)bindObj:(id)obj withKey:(id)key{
    if (obj && key) {
        objc_setAssociatedObject(self, &key, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    else{
        NSLog(@"绑定的值或者key为空");
    }
}

//runtime获取绑定的值
-(instancetype)getBindedObjWithKey:(id)key{
    if (key) {
        return objc_getAssociatedObject(self, &key);
    }
    else{
        NSLog(@"key 为空");
        return nil;
    }
    
}
@end
