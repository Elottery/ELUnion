//
//  ELNavigationAnimationController.h
//  Pods
//
//  Created by 金秋成 on 2016/11/16.
//
//

#import "ELTransitionAnimationType.h"

@interface ELNavigationAnimationController : NSObject<UIViewControllerAnimatedTransitioning>
- (instancetype)initWithTransitionType:(ELViewControllerTransitionAnimationType)trasitionType;
@end
