//
//  ELModalAnimationTransitionDelegate.m
//  Pods
//
//  Created by 金秋成 on 2016/11/10.
//
//

#import "ELModalAnimationTransitionDelegate.h"
#import "ELModalAnimationController.h"
@implementation ELModalAnimationTransitionDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [[ELModalAnimationController alloc]initWithPresentTransitionType:_presentType];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [[ELModalAnimationController alloc]initWithDismissTransitionType:_dismissType];
}
@end
