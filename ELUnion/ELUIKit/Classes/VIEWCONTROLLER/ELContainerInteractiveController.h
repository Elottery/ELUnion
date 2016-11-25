//
//  ELContainerInteractiveController.h
//  Pods
//
//  Created by 金秋成 on 2016/11/18.
//
//

#import <UIKit/UIKit.h>
@class ELContainerTransitionContext;
@interface ELContainerInteractiveController : NSObject<UIViewControllerInteractiveTransitioning>
@property (nonatomic,weak)ELContainerTransitionContext * containerTransitionContext;

-(void)updateInteractiveTransition:(CGFloat)percentComplete;

-(void)cancelInteractiveTransition;

-(void)finishInteractiveTransition;


@end
