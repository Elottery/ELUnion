//
//  NSObject+el_binding.h
//  Pods
//
//  Created by 金秋成 on 16/10/13.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (el_binding)
//runtime绑定值
-(void)bindObj:(id)obj withKey:(id)key;

//runtime获取绑定的值
-(instancetype)getBindedObjWithKey:(id)key;

@end
