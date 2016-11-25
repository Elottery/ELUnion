//
//  ELModalAnimationController.h
//  Pods
//
//  Created by 金秋成 on 2016/11/10.
//
//

#import "ELTransitionAnimationType.h"

@interface ELModalAnimationController : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic,assign,readonly)ELViewControllerTransitionAnimationType presentType;
@property (nonatomic,assign,readonly)ELViewControllerTransitionAnimationType dismissType;

- (instancetype)initWithPresentTransitionType:(ELViewControllerTransitionAnimationType)presentType
                        dismissTransitionType:(ELViewControllerTransitionAnimationType)dismissType;


- (instancetype)initWithPresentTransitionType:(ELViewControllerTransitionAnimationType)presentType;
- (instancetype)initWithDismissTransitionType:(ELViewControllerTransitionAnimationType)dismissType;

@end
