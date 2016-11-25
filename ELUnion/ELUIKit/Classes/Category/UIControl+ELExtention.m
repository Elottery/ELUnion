//
//  UIControl+ELExtention.m
//  Pods
//
//  Created by 金秋成 on 2016/11/1.
//
//

#import "UIControl+ELExtention.h"
#import <objc/runtime.h>
@implementation UIControl (ELExtention)
//-(void)el_addControlEvents:(UIControlEvents)event actionHandle:(ELUIKit_UIControl)handle{
//    [self addEventKey:event withHandle:handle];
//    [self addTarget:self action:@selector(el_action:event:) forControlEvents:event];
//}
//
//
//-(void)el_action:(UIButton *)sender event:(UIEvent *)event{
//    
//    
//    
//
//}
//    
//    
//-(void)addEventKey:(UIControlEvents)event withHandle:(ELUIKit_UIControl)handle{
//    NSMutableDictionary * dict = [self eventHandleDict];
//    [dict setObject:[handle copy] forKey:@(event)];
//}
//    
//-(NSMutableDictionary *)eventHandleDict{
//    NSMutableDictionary * dict = objc_getAssociatedObject(self, _cmd);
//    if (dict) {
//        dict = [NSMutableDictionary new];
//        objc_setAssociatedObject(self, _cmd, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    }
//    return dict;
//}


    
@end
