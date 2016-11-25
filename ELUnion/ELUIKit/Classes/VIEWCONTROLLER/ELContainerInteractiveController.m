//
//  ELContainerInteractiveController.m
//  Pods
//
//  Created by 金秋成 on 2016/11/18.
//
//

#import "ELContainerInteractiveController.h"
#import "ELContainerTransitionContext.h"

@implementation ELContainerInteractiveController
-(void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    self.containerTransitionContext  = transitionContext;
    [self.containerTransitionContext activateInteractiveTransition];
    
}
-(void)updateInteractiveTransition:(CGFloat)percentComplete{
    [self.containerTransitionContext updateInteractiveTransition:percentComplete];
}

-(void)cancelInteractiveTransition{
    [self.containerTransitionContext cancelInteractiveTransition];
}

-(void)finishInteractiveTransition{
    [self.containerTransitionContext finishInteractiveTransition];
}


@end
