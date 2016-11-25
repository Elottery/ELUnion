//
//  ELNavigationAnimationController.m
//  Pods
//
//  Created by 金秋成 on 2016/11/16.
//
//

#import "ELNavigationAnimationController.h"




@implementation ELNavigationAnimationController
{
    ELViewControllerTransitionAnimationType _trasitionType;
    
}
- (instancetype)initWithTransitionType:(ELViewControllerTransitionAnimationType)trasitionType{
    self = [super init];
    if (self) {
        _trasitionType = trasitionType;
    }
    return self;
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.28;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController * tovc   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController * fromvc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView * containerView = [transitionContext containerView];
    UIView * toView        = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView * fromView      = [transitionContext viewForKey:UITransitionContextFromViewKey];

    NSTimeInterval duration = [self transitionDuration:transitionContext];
    toView.frame = containerView.bounds;
    [containerView addSubview:toView];
    
    switch (_trasitionType) {
        case ELViewControllerTransitionAnimationTypeFromBottomToTop:
        {
            CGFloat toTranslationY   = toView.frame.size.height;
            CGFloat fromTranslationY = fromView.frame.size.height;
            fromView.transform = CGAffineTransformIdentity;
            toView.transform = CGAffineTransformMakeTranslation(0, toTranslationY);
            [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                toView.transform   = CGAffineTransformIdentity;
                fromView.transform = CGAffineTransformMakeTranslation(0, -fromTranslationY);
            } completion:^(BOOL finished) {
                if (finished) {
                    toView.transform = CGAffineTransformIdentity;
                    fromView.transform = CGAffineTransformIdentity;
                    [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                }
            }];
        }
            break;
        case ELViewControllerTransitionAnimationTypeFromTopToBottom:
        {
            CGFloat toTranslationY   = toView.frame.size.height;
            CGFloat fromTranslationY = fromView.frame.size.height;
            toView.transform = CGAffineTransformMakeTranslation(0, -toTranslationY);
            fromView.transform = CGAffineTransformIdentity;
            [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                toView.transform = CGAffineTransformMakeTranslation(0, 0);
                fromView.transform = CGAffineTransformMakeTranslation(0, fromTranslationY);
            } completion:^(BOOL finished) {
                toView.transform = CGAffineTransformIdentity;
                fromView.transform = CGAffineTransformIdentity;
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }];
        }
            break;
            
        case ELViewControllerTransitionAnimationTypeFromLeftToRight:
        {
            CGFloat toTranslationX = toView.frame.size.width;
            CGFloat fromTranslationX = fromView.frame.size.width;
            toView.transform = CGAffineTransformMakeTranslation(-toTranslationX, 0);
            fromView.transform = CGAffineTransformIdentity;
            [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                toView.transform = CGAffineTransformMakeTranslation(0, 0);
                fromView.transform = CGAffineTransformMakeTranslation(fromTranslationX, 0);
            } completion:^(BOOL finished) {
                toView.transform = CGAffineTransformIdentity;
                fromView.transform = CGAffineTransformIdentity;
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }];
        }
            break;
        case ELViewControllerTransitionAnimationTypeFromRightToLeft:
        {
            CGFloat toTranslationX = toView.frame.size.width;
            CGFloat fromTranslationX = fromView.frame.size.width;
            toView.transform = CGAffineTransformMakeTranslation(toTranslationX, 0);
            fromView.transform = CGAffineTransformIdentity;
            [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                toView.transform = CGAffineTransformMakeTranslation(0, 0);
                fromView.transform = CGAffineTransformMakeTranslation(-fromTranslationX, 0);
            } completion:^(BOOL finished) {
                toView.transform = CGAffineTransformIdentity;
                fromView.transform = CGAffineTransformIdentity;
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }];
        }
            break;
        default:
        {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }
            break;
    }
    
    
    
    
    
    
}
@end
