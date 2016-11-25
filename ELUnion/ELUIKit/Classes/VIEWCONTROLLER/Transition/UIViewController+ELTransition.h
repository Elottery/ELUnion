//
//  UIViewController+ELTransition.h
//  Pods
//
//  Created by 金秋成 on 2016/11/16.
//
//

#import <UIKit/UIKit.h>
#import "ELTransitionAnimationType.h"
#import "ELModalAnimationTransitionDelegate.h"
@interface UIViewController (ELTransition)


@property (nonatomic,strong)ELModalAnimationTransitionDelegate * el_transitionDelegate;

- (void)el_presentViewController:(UIViewController *)viewController
               withAnimationType:(ELViewControllerTransitionAnimationType)type
               animationComplete:(ELTransitionCompeleteBlock)complete;

- (void)el_dismissViewControllerWithAnimationType:(ELViewControllerTransitionAnimationType)type
                                animationComplete:(ELTransitionCompeleteBlock)complete;

@end
