//
//  UIView+ELFlexable.m
//  Elottory
//
//  Created by 金秋成 on 16/7/19.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "UIView+ELFlexable.h"
#import <objc/runtime.h>
@implementation UIView (ELFlexable)
+ (void)load {
    Method originalFunc = class_getInstanceMethod([self class], @selector(intrinsicContentSize));
    Method swizzledFunc = class_getInstanceMethod([self class], @selector(sw_intrinsicContentSize));
    
    method_exchangeImplementations(originalFunc, swizzledFunc);
}
-(instancetype)initWithEdge:(UIEdgeInsets)edge cornerRatio:(CGFloat)ratio{
    self = [self initWithFrame:CGRectZero];
    if (self) {
        self.edge = edge;
        self.conerRatio = ratio;
    }
    return self;
}
-(instancetype)initWithEdge:(UIEdgeInsets)edge{
    return  [self initWithEdge:edge cornerRatio:0];
}

-(CGSize)sw_intrinsicContentSize{
    CGSize originalSize = [self sw_intrinsicContentSize];
    CGSize editedSize   = CGSizeMake(originalSize.width + self.edge.left + self.edge.right,
                                     originalSize.height + self.edge.top + self.edge.bottom);
//    self.layer.cornerRadius = editedSize.height/2 * self.conerRatio;
    return editedSize;
}
-(UIEdgeInsets)edge{
    NSString * edgeStr = objc_getAssociatedObject(self, _cmd);
    if (edgeStr) {
        return  UIEdgeInsetsFromString(edgeStr);
    }
    return UIEdgeInsetsZero;
}
-(void)setEdge:(UIEdgeInsets)edge{
    objc_setAssociatedObject(self, @selector(edge), NSStringFromUIEdgeInsets(edge), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(CGFloat)conerRatio{
    NSNumber * ratioNumber = objc_getAssociatedObject(self, _cmd);
    return ratioNumber.floatValue;
}

-(void)setConerRatio:(CGFloat)conerRatio{
    objc_setAssociatedObject(self, @selector(conerRatio), @(conerRatio), OBJC_ASSOCIATION_COPY_NONATOMIC);
}



@end
