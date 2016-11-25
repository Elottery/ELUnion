//
//  ELContainerTransitionDelegate.m
//  Pods
//
//  Created by 金秋成 on 2016/11/18.
//
//

#import "ELContainerTransitionDelegate.h"
#import "ELNavigationAnimationController.h"
#import "ELContainerTransitionContext.h"

@interface ELContainerTransitionDelegate ()

@end


@implementation ELContainerTransitionDelegate

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.interactiveController = [[ELContainerInteractiveController alloc]init];
        
    }
    return self;
}

-(id<UIViewControllerAnimatedTransitioning>)el_animationControllerForContainerViewController:(UIViewController *)containerViewController
                                                                   transitFromViewController:(UIViewController *)fromViewController atIndex:(NSUInteger)fromIndex
                                                                            toViewController:(UIViewController *)toViewController atIndex:(NSUInteger)toIndex{
    if (fromIndex < toIndex) {//左滑
        return [[ELNavigationAnimationController alloc]initWithTransitionType:ELViewControllerTransitionAnimationTypeFromRightToLeft];
        
    }
    else{
        return [[ELNavigationAnimationController alloc]initWithTransitionType:ELViewControllerTransitionAnimationTypeFromLeftToRight];
    }
}





-(id<UIViewControllerInteractiveTransitioning>)el_interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController containerViewController:(UIViewController *)containerViewController{
    return  self.interactiveController;
}

@end
