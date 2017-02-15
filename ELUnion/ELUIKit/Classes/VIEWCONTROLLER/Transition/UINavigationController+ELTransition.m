//
//  UINavigationController+ELTransition.m
//  Pods
//
//  Created by 金秋成 on 2016/11/16.
//
//

#import "UINavigationController+ELTransition.h"

#import <objc/runtime.h>

@implementation UINavigationController (ELTransition)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class=[self class];
        //push方法替换
        SEL pushoriginalSelector=@selector(pushViewController:animated:);
        SEL pushswizzledSelector=@selector(el_pushViewController:animated:);
        Method pushoriginalMethod=class_getInstanceMethod(class,pushoriginalSelector);
        Method pushswizzledMethod=class_getInstanceMethod(class,pushswizzledSelector);
        
        if(class_addMethod(class,
                           pushoriginalSelector,
                           method_getImplementation(pushswizzledMethod),
                           method_getTypeEncoding(pushswizzledMethod))){
            
            class_replaceMethod(class,pushswizzledSelector,method_getImplementation(pushoriginalMethod),method_getTypeEncoding(pushoriginalMethod));
        }else{
            method_exchangeImplementations(pushoriginalMethod,pushswizzledMethod);
        }
        
        
        SEL poporiginalSelector=@selector(popToViewController:animated:);
        SEL popswizzledSelector=@selector(el_popToViewController:animated:);
        Method poporiginalMethod=class_getInstanceMethod(class,poporiginalSelector);
        Method popswizzledMethod=class_getInstanceMethod(class,popswizzledSelector);
        
        if(class_addMethod(class,
                           poporiginalSelector,
                           method_getImplementation(popswizzledMethod),
                           method_getTypeEncoding(popswizzledMethod))){
            class_replaceMethod(class,popswizzledSelector,method_getImplementation(poporiginalMethod),method_getTypeEncoding(poporiginalMethod));
        }else{
            method_exchangeImplementations(poporiginalMethod,popswizzledMethod);
        }
        
        SEL popTooriginalSelector=@selector(popViewControllerAnimated:);
        SEL popToswizzledSelector=@selector(el_popViewControllerAnimated:);
        Method popTooriginalMethod=class_getInstanceMethod(class,popTooriginalSelector);
        Method popToswizzledMethod=class_getInstanceMethod(class,popToswizzledSelector);
        
        if(class_addMethod(class,
                           popTooriginalSelector,
                           method_getImplementation(popToswizzledMethod),
                           method_getTypeEncoding(popToswizzledMethod))){
            class_replaceMethod(class,popToswizzledSelector,method_getImplementation(popTooriginalMethod),method_getTypeEncoding(popTooriginalMethod));
        }else{
            method_exchangeImplementations(popTooriginalMethod,popToswizzledMethod);
        }
    });
}
-(void)setEnableInteration:(BOOL)enableInteration{
    if (enableInteration) {
        [self panGesture];
    }
    else{
        [self removePanGesture];
    }
}



-(ELNavigationAnimationTransitionDelegate *)el_navigationTransitionDelegate{
    ELNavigationAnimationTransitionDelegate * delegate = objc_getAssociatedObject(self, _cmd);
    if (!delegate) {
        delegate = [[ELNavigationAnimationTransitionDelegate alloc]init];
        self.el_navigationTransitionDelegate = delegate;
        self.delegate = delegate;
    }
    return delegate;
}
-(void)setEl_navigationTransitionDelegate:(ELNavigationAnimationTransitionDelegate *)el_navigationTransitionDelegate{
    objc_setAssociatedObject(self, @selector(el_navigationTransitionDelegate), el_navigationTransitionDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



-(void)el_pushViewController:(UIViewController<ELTransitionProtocol> *)viewController animated:(BOOL)animated{
    if ([viewController respondsToSelector:@selector(pushedTransitionType)]) {
        self.el_navigationTransitionDelegate.pushType = [viewController pushedTransitionType];
        self.el_navigationTransitionDelegate.interact = NO;
    }
    [self el_pushViewController:viewController animated:animated];
}

-(UIViewController *)el_popViewControllerAnimated:(BOOL)animated{
   UIViewController<ELTransitionProtocol> * vc = self.topViewController;
    if ([vc respondsToSelector:@selector(popedTransitionType)]) {
        self.el_navigationTransitionDelegate.popType = [vc popedTransitionType];
        self.el_navigationTransitionDelegate.interact = [self interacting];
    }
    return  [self el_popViewControllerAnimated:animated];
}

-(NSArray<UIViewController *> *)el_popToViewController:(UIViewController<ELTransitionProtocol> *)viewController
                                           animated:(BOOL)animated{
    if ([self.topViewController respondsToSelector:@selector(popedTransitionType)]) {
        UIViewController<ELTransitionProtocol> * vc = (UIViewController<ELTransitionProtocol> *)self.topViewController;
        self.el_navigationTransitionDelegate.popType = [vc popedTransitionType];
        
        self.el_navigationTransitionDelegate.interact = [self interacting];
    }
    return  [self el_popToViewController:viewController animated:animated];
}


-(void)didPan:(UIPanGestureRecognizer *)pan{
    
    CGPoint panPoint = [pan translationInView:self.view];
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            [self setInteracting:YES];
            UIViewController<ELTransitionProtocol>* vc = self.topViewController;
            if ([vc respondsToSelector:@selector(popedTransitionType)]) {
                [self setPanStartPoint:panPoint];
                [self setStartPercent:0];
            }
            
//            self.el_navigationTransitionDelegate = nil;
            if ([self.topViewController respondsToSelector:NSSelectorFromString(@"el_popDestinationViewController")]) {
                UIViewController * destinationVC = [self.topViewController performSelector:NSSelectorFromString(@"el_popDestinationViewController")];
                if (destinationVC) {
                    [self popToViewController:destinationVC animated:YES];
                }
                else{
                    [self popViewControllerAnimated:YES];
                }
            }
            else{
                [self popViewControllerAnimated:YES];
            }
            
            
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            
            
            
            
            CGPoint startPoint   = [self panStartPoint];
            switch (self.el_navigationTransitionDelegate.popType) {
                case ELViewControllerTransitionAnimationTypeFromBottomToTop:
                {
                    if (startPoint.y>panPoint.y) {
                        CGFloat percent = (startPoint.y - panPoint.y)/self.view.frame.size.height;
                        [self setStartPercent:percent];
                    }
                }
                    break;
                case ELViewControllerTransitionAnimationTypeFromTopToBottom:
                {
                    if (startPoint.y<panPoint.y) {
                        CGFloat percent = (panPoint.y-startPoint.y)/self.view.frame.size.height;
                        [self setStartPercent:percent];
                    }
                }
                    break;
                    
                case ELViewControllerTransitionAnimationTypeFromLeftToRight:
                {
                    if (startPoint.x<panPoint.x) {
                        CGFloat percent = (panPoint.x-startPoint.x)/self.view.frame.size.width;
                        [self setStartPercent:percent];
                    }
                }
                    break;
                case ELViewControllerTransitionAnimationTypeFromRightToLeft:
                {
                    if (startPoint.x>panPoint.x) {
                        CGFloat percent = (startPoint.x-panPoint.x)/self.view.frame.size.width;
                        [self setStartPercent:percent];
                    }
                }
                    break;
                default:
                    break;
            }
            [self.el_navigationTransitionDelegate.interactiveTransition updateInteractiveTransition:[self startPercent]];
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
        {
            if ([self startPercent] > 0.3) {
                [self.el_navigationTransitionDelegate.interactiveTransition finishInteractiveTransition];
            }
            else{
                [self.el_navigationTransitionDelegate.interactiveTransition cancelInteractiveTransition];
            }
            self.el_navigationTransitionDelegate.interact = NO;
            [self setInteracting:NO];
        }
            
            break;
        default:
            break;
    }
}

//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
//    UIViewController<ELTransitionProtocol> * vc =  self.topViewController;
//    return [vc respondsToSelector:@selector(canDragBackWithPan:)];
//}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    UIViewController<ELTransitionProtocol> * vc =  self.topViewController;
    if ([vc respondsToSelector:@selector(canDragBackWithPan:withTouch:)]) {
        return [vc canDragBackWithPan:gestureRecognizer withTouch:touch];
    }
    else
        return YES;
}
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        CGPoint velo     = [(UIPanGestureRecognizer *)gestureRecognizer velocityInView:self.view];
        if (fabs(velo.y)>fabs(velo.x)) {
            return NO;
        }
        return YES;
    }
    return YES;
}

-(UIPanGestureRecognizer *)panGesture{
    UIPanGestureRecognizer * pan = objc_getAssociatedObject(self, _cmd);
    if (!pan) {
        pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(didPan:)];
        pan.delegate = self;
        [self.view addGestureRecognizer:pan];
        objc_setAssociatedObject(self, _cmd, pan, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return pan;
}

-(void)removePanGesture{
    UIPanGestureRecognizer * pan = objc_getAssociatedObject(self, @selector(panGesture));
    if (pan) {
        [self.view removeGestureRecognizer:pan];
        objc_setAssociatedObject(self, _cmd, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}


-(CGPoint)panStartPoint{
    NSString * startPointNumber = objc_getAssociatedObject(self, _cmd);
    if (!startPointNumber) {
        return CGPointZero;
    }
    return CGPointFromString(startPointNumber);
}

-(void)setPanStartPoint:(CGPoint)point{
    objc_setAssociatedObject(self, @selector(panStartPoint), NSStringFromCGPoint(point), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)setStartPercent:(CGFloat)percent{
    objc_setAssociatedObject(self, @selector(startPercent), @(percent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CGFloat)startPercent{
    NSNumber * percentNumber  = objc_getAssociatedObject(self, _cmd);
    if (!percentNumber) {
        percentNumber = @(0);
    }
    return [percentNumber floatValue];
}

-(BOOL)interacting{
    NSNumber * number = objc_getAssociatedObject(self, _cmd);
    return [number boolValue];
}

-(void)setInteracting:(BOOL)interating{
    objc_setAssociatedObject(self, @selector(interacting), [NSNumber numberWithBool:interating], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}






@end
