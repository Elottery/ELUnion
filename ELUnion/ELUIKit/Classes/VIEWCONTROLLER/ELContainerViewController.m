//
//  ELContainerViewController.m
//  Pods
//
//  Created by Nicolas on 2016/10/26.
//
//

#import "ELContainerViewController.h"
#import "ELContainerTransitionContext.h"

@interface ELContainerViewController ()<ELContainerViewControllerProtocol,UIGestureRecognizerDelegate>
@property (nonatomic,strong)ELContainerTransitionContext * context;
@property (nonatomic,strong)UIView * containerView;

@property (nonatomic,assign,getter=isInteractive)BOOL interactive;

@property (nonatomic,assign)CGPoint interactiveStartPoint;

@property (nonatomic,assign)CGFloat tempPercent;

@property (nonatomic,assign)NSUInteger childViewControllerCount;

@property (nonatomic,strong)UIViewController * currentViewController;

@property (nonatomic,assign,getter=isTransitioning)BOOL transitioning;

@end

@implementation ELContainerViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        _currentIndex = 0;
        self.selectIndex = 0;
        self.interactive = NO;
        self.childViewControllerCount = 0;
        self.transitioning = NO;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.containerView = [[UIView alloc]initWithFrame:CGRectZero];
    self.containerView.backgroundColor = [UIColor whiteColor];
    self.containerView.translatesAutoresizingMaskIntoConstraints  =NO;
    [self.view addSubview:self.containerView];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:self.containerViewEdge.top]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-self.containerViewEdge.bottom]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:self.containerViewEdge.left]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:-self.containerViewEdge.right]];

    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(didPan:)];
    [self.containerView addGestureRecognizer:pan];
//    [self initViewController];
}


//-(void)initViewController{
//    
//    [self reloadChildViewControllers];
//    
//    
//}


-(void)reloadChildViewControllers{
    self.childViewControllerCount = [self.dataSource numberOfChildViewController];
    if (self.childViewControllerCount > 0) {
        
        if (_childViewControllerCount <= self.currentIndex) {
            _currentIndex = _childViewControllerCount-1;
        }
        
        UIViewController * newCurrentIndexVC = [self.dataSource viewControllerAtIndex:self.currentIndex];
        
        if (newCurrentIndexVC != self.currentViewController) {
            //如果和当前的控制器不是同一个  移除之前的控制器
            [self.currentViewController willMoveToParentViewController:nil];
            [self.currentViewController.view removeFromSuperview];
            [self.currentViewController removeFromParentViewController];
            //将新的控制器加入
            [self addChildViewController:newCurrentIndexVC];
            newCurrentIndexVC.view.frame = self.containerView.bounds;
            [self.containerView addSubview:newCurrentIndexVC.view];
            [newCurrentIndexVC didMoveToParentViewController:self];
            self.currentViewController = newCurrentIndexVC;
        }
        
        
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setSelectIndex:(NSUInteger)selectIndex{
    

    if (self.childViewControllerCount <= selectIndex || selectIndex<0) {
        return;
    }
    
    
    
    
    _selectIndex = selectIndex;
    
    
    
    
    if ([self isViewLoaded] && !self.isTransitioning) {

        self.context = [[ELContainerTransitionContext alloc]initWithContainerViewController:self containerView:self.containerView];
        if (self.currentIndex == selectIndex || selectIndex >= self.childViewControllerCount) {
            return;
        }
        
        
        UIViewController * toVC   = [self.dataSource viewControllerAtIndex:selectIndex];
        UIViewController * fromVC = [self.dataSource viewControllerAtIndex:self.currentIndex];

        self.context.fromViewController = fromVC;
        self.context.toViewController   = toVC;
        self.context.fromIndex = self.currentIndex;
        self.context.toIndex   = selectIndex;
       
        if (self.isInteractive) {
            [self.context startInteractiveTransition];
        }
        else{
            [self.context startAnimationTrasition];
        }
    }
}


-(void)contextDidStartTransition{
    self.transitioning = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(didStartTrasitionFromIndex:toIndex:)]) {
        [self.delegate didStartTrasitionFromIndex:_currentIndex toIndex:_selectIndex];
    }
}


-(void)contextTransitionProgress:(CGFloat)progress{
    if (self.delegate && [self.delegate respondsToSelector:@selector(transitionFromIndex:toIndex:withProgress:)]) {
        [self.delegate transitionFromIndex:_currentIndex toIndex:_selectIndex withProgress:progress];
    }
}


-(void)contextDidFinishTransition:(BOOL)isCanceled{
    self.transitioning = NO;
    if (!isCanceled) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(didEndTrasitionFromIndex:toIndex:)]) {
            [self.delegate didEndTrasitionFromIndex:_currentIndex toIndex:_selectIndex];
        }
        _currentIndex = _selectIndex;
    }
}



#pragma -mark pan
-(void)didPan:(UIPanGestureRecognizer *)pan{
    
    CGPoint panPoint = [pan translationInView:self.containerView];
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.interactive = YES;
            self.interactiveStartPoint = panPoint;
            self.tempPercent = 0;
            CGPoint velocity= [pan velocityInView:self.containerView];
            if (velocity.x > 0) {
                self.selectIndex = self.currentIndex - 1;
            }
            else{
                self.selectIndex = self.currentIndex + 1;
            }
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            

            
            
            
            if (self.selectIndex > self.currentIndex) {
                if (self.interactiveStartPoint.x > panPoint.x) {
                    self.tempPercent = (self.interactiveStartPoint.x - panPoint.x)/self.containerView.frame.size.width;
                    [self.context.trasitionDelegate.interactiveController updateInteractiveTransition:self.tempPercent];
                }
                
                
                
                
            }
            else if(self.selectIndex < self.currentIndex){
                if (self.interactiveStartPoint.x < panPoint.x) {
                    self.tempPercent = (panPoint.x - self.interactiveStartPoint.x)/self.containerView.frame.size.width;
                    [self.context.trasitionDelegate.interactiveController updateInteractiveTransition:self.tempPercent];
                }
            }

        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
        {
            
            if (self.tempPercent > 0.3) {
                
                [self.context.trasitionDelegate.interactiveController finishInteractiveTransition];
            }
            else{
                [self.context.trasitionDelegate.interactiveController cancelInteractiveTransition];
            }
            self.interactive = NO;
        }
            break;
        default:
            break;
    }
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
