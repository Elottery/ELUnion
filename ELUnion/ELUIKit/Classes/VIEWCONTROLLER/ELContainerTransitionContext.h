//
//  ELContainerTransitionContext.h
//  Pods
//
//  Created by 金秋成 on 2016/11/18.
//
//

#import <Foundation/Foundation.h>
#import "ELContainerTransitionDelegate.h"
//#import <ELUnion/ELContainerTransitionDelegate.h>

@protocol ELContainerViewControllerProtocol <NSObject>

@required


-(void)contextDidStartTransition;
-(void)contextTransitionProgress:(CGFloat)progress;
-(void)contextDidFinishTransition:(BOOL)isCanceled;


@end

@interface ELContainerTransitionContext : NSObject
-(instancetype)initWithContainerViewController:(UIViewController<ELContainerViewControllerProtocol> *)containerViewController
                                 containerView:(UIView *)containerView;



@property (nonatomic,strong,readonly)ELContainerTransitionDelegate * trasitionDelegate;


@property (nonatomic,weak)UIViewController * fromViewController;
@property (nonatomic,assign)NSUInteger fromIndex;
@property (nonatomic,weak)UIViewController * toViewController;
@property (nonatomic,assign)NSUInteger toIndex;

-(void)startAnimationTrasition;

-(void)startInteractiveTransition;

-(void)activateInteractiveTransition;

-(void)updateInteractiveTransition:(CGFloat)percentComplete;

-(void)cancelInteractiveTransition;

-(void)finishInteractiveTransition;

@end
