//
//  ELContainerTransitionContext.m
//  Pods
//
//  Created by 金秋成 on 2016/11/18.
//
//

#import "ELContainerTransitionContext.h"





@interface ELContainerTransitionContext ()<UIViewControllerContextTransitioning>
@property (nonatomic,assign)BOOL interactive;
@property (nonatomic,assign)BOOL isCancelled;
//@property (nonatomic,assign)NSInteger fromIndex;
//@property (nonatomic,assign)NSInteger toIndex;

@property (nonatomic,assign)CFTimeInterval transitionDuration;
@property (nonatomic,assign)float          transitionPercent;

@property (nonatomic,strong)id<UIViewControllerAnimatedTransitioning> animationController;
@property (nonatomic,weak)UIViewController * privateFromViewController;
@property (nonatomic,weak)UIViewController * privateToViewController;
@property (nonatomic,weak)UIViewController<ELContainerViewControllerProtocol>   * privateContainerViewController;
@property (nonatomic,weak)UIView           * privateContainerView;








@end


@implementation ELContainerTransitionContext

-(instancetype)initWithContainerViewController:(UIViewController<ELContainerViewControllerProtocol> *)containerViewController
                                 containerView:(UIView *)containerView{
    self = [super init];
    if (self) {
        self.privateContainerViewController = containerViewController;
        self.privateContainerView = containerView;
        _trasitionDelegate = [[ELContainerTransitionDelegate alloc]init];
    }
    return self;
}


-(UIViewController *)fromViewController{
    return self.privateFromViewController;
}

-(UIViewController *)toViewController{
    return self.privateToViewController;
}

-(void)setFromViewController:(UIViewController *)fromViewController{
    self.privateFromViewController = fromViewController;
}

-(void)setToViewController:(UIViewController *)toViewController{
    self.privateToViewController = toViewController;
}




-(void)startAnimationTrasition{
    self.animationController = [self.trasitionDelegate el_animationControllerForContainerViewController:self.privateContainerViewController transitFromViewController:self.privateFromViewController atIndex:self.fromIndex toViewController:self.privateToViewController atIndex:self.toIndex];
    [self activateNonInteractiveTransition];
    [self.privateContainerViewController contextDidStartTransition];
    
}


-(BOOL)transitionWasCancelled{
    return self.isCancelled;
}

-(BOOL)isAnimated{
    return self.animationController?YES:NO;
}

-(BOOL)isInteractive{
    return _interactive;
}

-(UIModalPresentationStyle)presentationStyle{
    return UIModalPresentationCustom;
}

-(UIView *)containerView{
    return self.privateContainerView;
}


-(void)completeTransition:(BOOL)isComplete{
    [self.privateToViewController didMoveToParentViewController:self.privateContainerViewController];
    if (isComplete) {
        [self.privateFromViewController willMoveToParentViewController:nil];
        [self.privateFromViewController.view removeFromSuperview];
        [self.privateFromViewController removeFromParentViewController];
    }
    else{
        [self.privateToViewController willMoveToParentViewController:nil];
        [self.privateToViewController.view removeFromSuperview];
        [self.privateToViewController removeFromParentViewController];
    }
    if ([self.animationController respondsToSelector:@selector(animationEnded:)]) {
        [self.animationController animationEnded:!self.isCancelled];
    }
//    if (self.isInteractive) {
        [self.privateContainerViewController contextDidFinishTransition:self.isCancelled];
//    }
    
    
}

#pragma -mark 交互式处理


-(void)startInteractiveTransition{
    
    self.animationController = [self.trasitionDelegate el_animationControllerForContainerViewController:self.privateContainerViewController transitFromViewController:self.privateFromViewController atIndex:self.fromIndex toViewController:self.privateToViewController atIndex:self.toIndex];
    
    self.transitionDuration = [self.animationController transitionDuration:self];
    
    id<UIViewControllerInteractiveTransitioning> interactionController = [self.trasitionDelegate el_interactionControllerForAnimationController:self.animationController containerViewController:self.privateContainerViewController];
    
    
    [interactionController startInteractiveTransition:self];
    
    [self.privateContainerViewController contextDidStartTransition];
    
}

-(void)activateInteractiveTransition{
    self.interactive = YES;
    self.isCancelled = NO;
    [self.privateContainerViewController addChildViewController:self.privateToViewController];
    self.privateContainerView.layer.beginTime = 0;
    self.privateContainerView.layer.speed = 0;
    [self.animationController animateTransition:self];
}

-(void)activateNonInteractiveTransition{
    self.interactive = NO;
    self.isCancelled = NO;
    self.privateContainerView.layer.beginTime = 0;
    self.privateContainerView.layer.speed = 1;
    [self.privateContainerViewController addChildViewController:self.privateToViewController];
    [self.animationController animateTransition:self];
}




-(void)updateInteractiveTransition:(CGFloat)percentComplete{
    if (self.interactive) {
        self.transitionPercent = percentComplete;
        self.privateContainerView.layer.timeOffset = percentComplete * self.transitionDuration;
        [self.privateContainerViewController contextTransitionProgress:percentComplete];
    }
}


-(void)finishInteractiveTransition{
    self.interactive = NO;
//    CFTimeInterval pausedTime = self.privateContainerView.layer.timeOffset;
//    self.privateContainerView.layer.speed = 1.0;
//    self.privateContainerView.layer.timeOffset = 0.0;
//    self.privateContainerView.layer.beginTime = 0.0;
//    CFTimeInterval timeSincePause = [self.privateContainerView.layer convertTime:CACurrentMediaTime() fromLayer:nil]-pausedTime;
//    self.privateContainerView.layer.beginTime = timeSincePause;
    
    CADisplayLink * displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(finishCurrentAnimation:)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];

    
    CFTimeInterval interval = (1-self.transitionPercent) * self.transitionDuration;
    [self performSelector:@selector(fixBeginTimeBug) withObject:nil afterDelay:interval];
    
    
}

-(void)cancelInteractiveTransition{
    self.interactive = NO;
    self.isCancelled = YES;
    
    CADisplayLink * displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(reverseCurrentAnimation:)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    
}

-(void)finishCurrentAnimation:(CADisplayLink *)displayLink{
    CFTimeInterval timeOffset = self.privateContainerView.layer.timeOffset + displayLink.duration;
    if (timeOffset > self.transitionDuration) {
        [displayLink invalidate];
        self.privateContainerView.layer.timeOffset = 0.0;
        self.privateContainerView.layer.speed   = 1;
    }
    else{
        self.privateContainerView.layer.timeOffset = timeOffset;
        self.transitionPercent = timeOffset/self.transitionDuration;
        [self.privateContainerViewController contextTransitionProgress:self.transitionPercent];
    }
}


-(void)reverseCurrentAnimation:(CADisplayLink *)displayLink{
    CFTimeInterval timeOffset = self.privateContainerView.layer.timeOffset - displayLink.duration;
    if (timeOffset>0) {
        self.privateContainerView.layer.timeOffset = timeOffset;
        self.transitionPercent = timeOffset/self.transitionDuration;
        
        [self.privateContainerViewController contextTransitionProgress:self.transitionPercent];
    }
    else{
        [displayLink invalidate];
        self.privateContainerView.layer.timeOffset = 0;//self.transitionDuration;
        self.privateContainerView.layer.speed   = 1;
        
//        UIView * fakeFromView = [self.privateFromViewController.view snapshotViewAfterScreenUpdates:NO];
//        [self.privateContainerView addSubview:fakeFromView];
//        [self performSelector:@selector(removeFakeFromView:) withObject:fakeFromView afterDelay:1/60];
//        [self.privateContainerViewController contextDidFinishTransition:YES];
    }

}

//-(void)removeFakeFromView:(UIView *)view{
//    [view removeFromSuperview];
//}

-(void)fixBeginTimeBug{
    self.privateContainerView.layer.beginTime = 0.0;
}


-(UIViewController *)viewControllerForKey:(UITransitionContextViewControllerKey)key{
    if ([key isEqualToString:UITransitionContextFromViewControllerKey]) {
        return self.privateFromViewController;
    }
    else if([key isEqualToString:UITransitionContextToViewControllerKey]){
        return self.privateToViewController;
    }
    return nil;
}

-(UIView *)viewForKey:(UITransitionContextViewKey)key{
    if ([key isEqualToString:UITransitionContextFromViewKey]) {
        return self.privateFromViewController.view;
    }
    else if([key isEqualToString:UITransitionContextToViewKey]){
        return self.privateToViewController.view;
    }
    return nil;
}

-(CGRect)initialFrameForViewController:(UIViewController *)vc{
    return CGRectZero;
}

-(CGRect)finalFrameForViewController:(UIViewController *)vc{
    return vc.view.frame;
}

-(CGAffineTransform)targetTransform{
    return CGAffineTransformIdentity;
}


#pragma -mark getter







-(void)dealloc{
    NSLog(@"context销毁");
}

@end
