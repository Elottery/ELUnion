//
//  ELContainerTransitionDelegate.h
//  Pods
//
//  Created by 金秋成 on 2016/11/18.
//
//

#import <Foundation/Foundation.h>
//#import "ELContainerTransitionContext.h"
#import "ELContainerInteractiveController.h"


@protocol ELContainerTransitionProtocol <NSObject>

-(id<UIViewControllerAnimatedTransitioning>)el_animationControllerForContainerViewController:(UIViewController *)containerViewController
                                                                   transitFromViewController:(UIViewController *)fromViewController atIndex:(NSUInteger)fromIndex
                                                                            toViewController:(UIViewController *)toViewController   atIndex:(NSUInteger)toIndex;

-(id<UIViewControllerInteractiveTransitioning>)el_interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
                                                                      containerViewController:(UIViewController *)containerViewController;


@end


@interface ELContainerTransitionDelegate : NSObject<ELContainerTransitionProtocol>
@property (nonatomic,strong)ELContainerInteractiveController * interactiveController;
@end
