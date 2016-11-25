//
//  ELModalAnimationController.m
//  Pods
//
//  Created by 金秋成 on 2016/11/10.
//
//

#import "ELModalAnimationController.h"


@implementation ELModalAnimationController
-(instancetype)initWithPresentTransitionType:(ELViewControllerTransitionAnimationType)presentType
                       dismissTransitionType:(ELViewControllerTransitionAnimationType)dismissType{
    self = [super init];
    if (self) {
        _presentType = presentType;
        _dismissType = dismissType;
    }
    return self;
}

- (instancetype)initWithPresentTransitionType:(ELViewControllerTransitionAnimationType)presentType{
    self = [super init];
    if (self) {
        _presentType = presentType;
    }
    return self;
}
- (instancetype)initWithDismissTransitionType:(ELViewControllerTransitionAnimationType)dismissType{
    self = [super init];
    if (self) {
        _dismissType = dismissType;
    }
    return self;
}





-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.3;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController * fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIViewController * toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView * containerView = [transitionContext containerView];
    UIView * fromView = fromViewController.view;
    UIView * toView   = toViewController.view;
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    
    
    if (toViewController.isBeingPresented) {
        [containerView addSubview:toView];
        
        //设置初始位置
        switch (self.presentType) {
            case ELViewControllerTransitionAnimationTypeFromBottomToTop:
                toView.frame = CGRectMake(0, toView.frame.size.height, toView.frame.size.width, toView.frame.size.height);
                break;
            case ELViewControllerTransitionAnimationTypeFromTopToBottom:
                toView.frame = CGRectMake(0,-toView.frame.size.height , toView.frame.size.width, toView.frame.size.height);
                break;
            case ELViewControllerTransitionAnimationTypeFromLeftToRight:
                toView.frame = CGRectMake(-toView.frame.size.width, 0 , toView.frame.size.width, toView.frame.size.height);
                break;
            case ELViewControllerTransitionAnimationTypeFromRightToLeft:
                toView.frame = CGRectMake(toView.frame.size.width, 0 , toView.frame.size.width, toView.frame.size.height);
                break;
            default:
                break;
        }
        
        
        [UIView animateWithDuration:duration
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
            toView.frame = CGRectMake(0, 0, toView.frame.size.width, toView.frame.size.height);
        } completion:^(BOOL finished) {
            BOOL isCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!isCancelled];
        }];
    }
    
    
    if (fromViewController.isBeingDismissed){
        [UIView animateWithDuration:duration
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
             switch (self.dismissType) {
                 case ELViewControllerTransitionAnimationTypeFromBottomToTop:
                     fromView.frame = CGRectMake(0, -toView.frame.size.height, toView.frame.size.width, toView.frame.size.height);
                     break;
                 case ELViewControllerTransitionAnimationTypeFromTopToBottom:
                     fromView.frame = CGRectMake(0,toView.frame.size.height , toView.frame.size.width, toView.frame.size.height);
                     break;
                 case ELViewControllerTransitionAnimationTypeFromLeftToRight:
                     fromView.frame = CGRectMake(toView.frame.size.width, 0 , toView.frame.size.width, toView.frame.size.height);
                     break;
                 case ELViewControllerTransitionAnimationTypeFromRightToLeft:
                     fromView.frame = CGRectMake(-toView.frame.size.width, 0 , toView.frame.size.width, toView.frame.size.height);
                     break;
                 default:
                     break;
             }
        } completion:^(BOOL finished) {
            BOOL isCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!isCancelled];
        }];
    }
    
    
    
    
}
@end
