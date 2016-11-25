//
//  ELNavigationAnimationTransitionDelegate.m
//  Pods
//
//  Created by 金秋成 on 2016/11/16.
//
//

#import "ELNavigationAnimationTransitionDelegate.h"
#import "ELNavigationAnimationController.h"
@implementation ELNavigationAnimationTransitionDelegate
{
//    UIPercentDrivenInteractiveTransition * _interactiveTransition;
    
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _interactiveTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
    }
    return self;
}
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    ELNavigationAnimationController * animationController = nil;
    if (operation == UINavigationControllerOperationPush) {
        animationController = [[ELNavigationAnimationController alloc]initWithTransitionType:self.pushType];
    }
    else if (operation == UINavigationControllerOperationPop){
        animationController = [[ELNavigationAnimationController alloc]initWithTransitionType:self.popType];
    }
    return animationController;
}


-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                        interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{

    return self.interact? _interactiveTransition : nil;
}


@end
