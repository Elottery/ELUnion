//
//  ELTransitionAnimationType.h
//  Pods
//
//  Created by 金秋成 on 2016/11/10.
//
//

#ifndef ELTransitionAnimationType_h
#define ELTransitionAnimationType_h



typedef void(^ELTransitionCompeleteBlock)();

typedef NS_ENUM(NSUInteger, ELViewControllerTransitionAnimationType) {
    ELViewControllerTransitionAnimationTypeNoneAnimation,
    ELViewControllerTransitionAnimationTypeFromBottomToTop,
    ELViewControllerTransitionAnimationTypeFromTopToBottom,
    ELViewControllerTransitionAnimationTypeFromLeftToRight,
    ELViewControllerTransitionAnimationTypeFromRightToLeft,
};


@protocol ELTransitionProtocol <NSObject>

@optional
-(ELViewControllerTransitionAnimationType)pushedTransitionType;
-(ELViewControllerTransitionAnimationType)popedTransitionType;
-(ELViewControllerTransitionAnimationType)presentedTransitionType;
-(ELViewControllerTransitionAnimationType)dismissedTransitionType;

-(BOOL)canDragBackWithPan:(UIPanGestureRecognizer *)panGesture withTouch:(UITouch *)touch;

@end


#endif /* ELTransitionAnimationType_h */
