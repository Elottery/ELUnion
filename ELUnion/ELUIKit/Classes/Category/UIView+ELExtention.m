//
//  UIView+ELExtention.m
//  Elottory
//
//  Created by 金秋成 on 16/7/31.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "UIView+ELExtention.h"
#import <objc/runtime.h>
@implementation UIView (ELExtention)


//+(void)load{
//    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Class class=[self class];
//        //push方法替换
//        SEL draworiginalSelector=@selector(drawRect:);
//        SEL drawswizzledSelector=@selector(el_drawRect:);
//        Method draworiginalMethod=class_getInstanceMethod(class,draworiginalSelector);
//        Method drawswizzledMethod=class_getInstanceMethod(class,drawswizzledSelector);
//        
//        if(class_addMethod(class,
//                           draworiginalSelector,
//                           method_getImplementation(drawswizzledMethod),
//                           method_getTypeEncoding(drawswizzledMethod))){
//            
//            class_replaceMethod(class,drawswizzledSelector,method_getImplementation(draworiginalMethod),method_getTypeEncoding(draworiginalMethod));
//        }else{
//            method_exchangeImplementations(draworiginalMethod,drawswizzledMethod);
//        }
//    });
//}
//
//
//-(void)setProgress:(CGFloat)progress{
//    objc_setAssociatedObject(self, @selector(progress), @(progress), OBJC_ASSOCIATION_COPY_NONATOMIC);
//}
//
//-(CGFloat)progress{
//    return  [objc_getAssociatedObject(self, _cmd) floatValue];
//}
//
//-(void)setProgressStyle:(ELExtentsionLoadingProgressStyle)progressStyle{
//    objc_setAssociatedObject(self, @selector(progressStyle), @(progressStyle), OBJC_ASSOCIATION_COPY_NONATOMIC);
//    [self setNeedsDisplay];
//}
//
//-(ELExtentsionLoadingProgressStyle)progressStyle{
//    return  [objc_getAssociatedObject(self, _cmd) floatValue];
//}
//
//
//-(CAShapeLayer *)progressLayer{
//    CAShapeLayer * layer = objc_getAssociatedObject(self, _cmd);
//    if (!layer) {
//        layer = [CAShapeLayer layer];
//        
//        objc_setAssociatedObject(self, _cmd, layer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//        [self.layer addSublayer:layer];
//    }
//    return layer;
//}



//-(void)el_drawRect:(CGRect)rect{
//    [self el_drawRect:rect];
//    
//    [self progressLayer].frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
//    
//    switch (self.progressStyle) {
//        case ELExtentsionLoadingProgressStyle_circle:
//        {
//            
//        }
//            break;
//        case ELExtentsionLoadingProgressStyle_square:
//        {
//            UIBezierPath * path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, rect.size.width, rect.size.height)];
//            [self progressLayer].lineWidth = 2;
//            [self progressLayer].path = path.CGPath;
//            [self progressLayer].fillColor = [UIColor blackColor].CGColor;
//            [self progressLayer].strokeStart = 0;
//            [self progressLayer].strokeEnd   = [self progress];
//        }
//            break;
//        default:
//            break;
//    }
//    
//    
//    
//    
//    
//    
//}




//-(void)uploadProgress:(CGFloat)progress{
//    [self setProgress:progress];
//    [self setNeedsDisplay];
//}



-(void)setEl_width:(CGFloat)el_width{
    CGRect selfBounds = self.bounds;
    selfBounds.size.width = el_width;
    self.bounds = selfBounds;
}

-(CGFloat)el_width{
    return self.bounds.size.width;
}

-(void)setEl_height:(CGFloat)el_height{
    CGRect selfBounds = self.bounds;
    selfBounds.size.height = el_height;
    self.bounds = selfBounds;
}

-(CGFloat)el_height{
    return self.bounds.size.height;
}


-(void)setEl_top:(CGFloat)el_top{
    CGRect selfFrame = self.frame;
    selfFrame.origin.y = el_top;
    self.frame = selfFrame;
}

-(CGFloat)el_top{
    return self.frame.origin.y;
}


-(void)setEl_bottom:(CGFloat)el_bottom{
    UIView * parentView = [self superview];
    CGRect selfFrame = self.frame;
    selfFrame.origin.y = parentView.el_height - (self.el_height + el_bottom);
    self.frame = selfFrame;
}

-(CGFloat)el_bottom{
    UIView * parentView = [self superview];
    return parentView.el_height - CGRectGetMaxY(self.frame);
}

-(void)setEl_left:(CGFloat)el_left{
    CGRect selfFrame = self.frame;
    selfFrame.origin.x = el_left;
    self.frame = selfFrame;
}
-(CGFloat)el_left{
    return self.frame.origin.x;
}



-(void)setEl_right:(CGFloat)el_right{
    UIView * parentView = [self superview];
    CGRect selfFrame = self.frame;
    selfFrame.origin.x = parentView.el_width - (self.el_width + el_right);
    self.frame = selfFrame;
}

-(CGFloat)el_right{
    UIView * parentView = [self superview];
    return parentView.el_width - CGRectGetMaxX(self.frame);
}

-(void)setEl_centerX:(CGFloat)el_centerX{
    CGPoint selfCenter = self.center;
    selfCenter.x = el_centerX;
    self.center = selfCenter;
}

-(CGFloat)el_centerX{
    return  self.center.x;
}

-(void)setEl_centerY:(CGFloat)el_centerY{
    CGPoint selfCenter = self.center;
    selfCenter.y = el_centerY;
    self.center = selfCenter;
}

-(CGFloat)el_centerY{
    return  self.center.y;
}
-(void)setEl_size:(CGSize)el_size{
    CGRect selfFrame = self.frame;
    selfFrame.size = el_size;
    self.frame = selfFrame;
}
-(CGSize)el_size{
    return self.frame.size;
}

@end
