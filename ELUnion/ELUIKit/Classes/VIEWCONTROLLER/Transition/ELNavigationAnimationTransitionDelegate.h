//
//  ELNavigationAnimationTransitionDelegate.h
//  Pods
//
//  Created by 金秋成 on 2016/11/16.
//
//

#import "ELTransitionAnimationType.h"

@interface ELNavigationAnimationTransitionDelegate : NSObject<UINavigationControllerDelegate>
@property (nonatomic,assign)ELViewControllerTransitionAnimationType pushType;
@property (nonatomic,assign)ELViewControllerTransitionAnimationType popType;
@property (nonatomic,strong,readonly)UIPercentDrivenInteractiveTransition * interactiveTransition;
@property (nonatomic,assign)BOOL interact;
@end
