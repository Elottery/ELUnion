//
//  ELModalAnimationTransitionDelegate.h
//  Pods
//
//  Created by 金秋成 on 2016/11/10.
//
//


#import "ELTransitionAnimationType.h"
@interface ELModalAnimationTransitionDelegate : NSObject<UIViewControllerTransitioningDelegate>

@property (nonatomic,assign)ELViewControllerTransitionAnimationType presentType;
@property (nonatomic,assign)ELViewControllerTransitionAnimationType dismissType;

@end
