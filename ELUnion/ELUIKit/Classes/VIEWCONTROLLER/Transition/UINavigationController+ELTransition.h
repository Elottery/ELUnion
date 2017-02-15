//
//  UINavigationController+ELTransition.h
//  Pods
//
//  Created by 金秋成 on 2016/11/16.
//
//

#import <UIKit/UIKit.h>
#import "ELTransitionAnimationType.h"
#import "ELNavigationAnimationTransitionDelegate.h"

@interface UINavigationController (ELTransition)<UIGestureRecognizerDelegate>


@property(nonatomic,assign)BOOL enableInteration;

@property (nonatomic,strong)ELNavigationAnimationTransitionDelegate * el_navigationTransitionDelegate;

//-(void)el_pushViewController:(UIViewController *)viewController animationType:(ELViewControllerTransitionAnimationType)type;
//
//-(UIViewController *)el_popViewControllerWithAnimationType:(ELViewControllerTransitionAnimationType)type;
//
//-(NSArray<UIViewController *> *)el_popToViewController:(UIViewController *)viewController animationType:(ELViewControllerTransitionAnimationType)type;
@end
