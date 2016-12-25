//
//  ELBaseViewController.m
//  ELUIFramework
//
//  Created by 金秋成 on 16/7/8.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "ELBaseViewController.h"
#import "ELBaseTabbarController.h"
#import "UIView+ELExtention.h"
#import "ELModalAnimationTransitionDelegate.h"

@interface ELBaseViewController ()

@property (nonatomic,strong)ELModalAnimationTransitionDelegate * transitionDelegateObj;

@property (nonatomic,strong,readonly)NSLayoutConstraint * navigationBarTopConstraint;

@property (nonatomic,strong,readonly)NSLayoutConstraint * navigationBarHeightConstraint;

@property (nonatomic,strong,readonly)NSLayoutConstraint * navigationBarLeadingConstraint;

@property (nonatomic,strong,readonly)NSLayoutConstraint * navigationBarTrailingConstraint;


@property (nonatomic,strong,readonly)NSLayoutConstraint * mainViewTopConstraint;

@property (nonatomic,strong,readonly)NSLayoutConstraint * mainViewBottomConstraint;

@property (nonatomic,strong,readonly)NSLayoutConstraint * mainViewLeadingConstraint;

@property (nonatomic,strong,readonly)NSLayoutConstraint * mainViewTrailingConstraint;

@end

@implementation ELBaseViewController
{
    ELNavigationBar * _el_navigationBar;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _el_tabbarHiddenWhenPushed = NO;
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.parentViewController == self.navigationController && self.parentViewController != nil) {
        [self.el_tabbarController el_setTabbarHidden:self.el_tabbarHiddenWhenPushed animated:YES];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    if (self.parentViewController == self.navigationController && self.parentViewController != nil) {
        [self.view addSubview:self.el_navigationBar];
        self.el_navigationBar.backBtnType = [self backBtnType];
        _navigationBarTopConstraint = [NSLayoutConstraint constraintWithItem:_el_navigationBar
                                                                   attribute:NSLayoutAttributeTop
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeTop
                                                                  multiplier:1
                                                                    constant:0];

        _navigationBarHeightConstraint = [NSLayoutConstraint constraintWithItem:_el_navigationBar
                                                                      attribute:NSLayoutAttributeHeight
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:nil
                                                                      attribute:NSLayoutAttributeNotAnAttribute
                                                                     multiplier:1
                                                                       constant:64];
        _navigationBarLeadingConstraint = [NSLayoutConstraint constraintWithItem:_el_navigationBar
                                                                       attribute:NSLayoutAttributeLeading
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.view
                                                                       attribute:NSLayoutAttributeLeading
                                                                      multiplier:1
                                                                        constant:0];
        _navigationBarTrailingConstraint = [NSLayoutConstraint constraintWithItem:_el_navigationBar
                                                                        attribute:NSLayoutAttributeTrailing
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.view
                                                                        attribute:NSLayoutAttributeTrailing
                                                                       multiplier:1
                                                                         constant:0];
        [self.view addConstraints:@[_navigationBarTopConstraint,
                                    _navigationBarHeightConstraint,
                                    _navigationBarLeadingConstraint,
                                    _navigationBarTrailingConstraint]];
        
    }
    
    

    
}




-(void)setUpView{
    
}


-(void)backBtnClick{
    if ([self canBackBtnClick]) {
        [self willNavigationBack];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


-(void)willNavigationBack{
    
}

-(BOOL)canBackBtnClick{
    return YES;
}

- (void)el_setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated{
    [self.view layoutIfNeeded];
    if (hidden) {
        _navigationBarTopConstraint.constant = -64;
        _mainViewTopConstraint.constant      = 0;
    }
    else{
        self.el_navigationBar.hidden = NO;
        _navigationBarTopConstraint.constant = 0;
        _mainViewTopConstraint.constant      = 64;
    }
    
    
    if (animated) {
        [UIView animateWithDuration:0.28 animations:^{
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
//            self.el_navigationBar.hidden = YES;
        }];
    }
    else{
        
        self.el_navigationBar.hidden = hidden;
    }
}



-(ELTabbar *)el_tabbar{
    if (self.el_tabbarController) {
        return self.el_tabbarController.el_tabbar;
    }
    return nil;
}
-(ELBaseTabbarController *)el_tabbarController{
    if (self.tabBarController && [self.tabBarController isKindOfClass:[ELBaseTabbarController class]] ) {
        ELBaseTabbarController * tabbarVC = (ELBaseTabbarController *)self.tabBarController;
        return tabbarVC;
    }
    return nil;
}
-(ELNavigationBar *)el_navigationBar{
    if (!_el_navigationBar && self.parentViewController == self.navigationController) {
        _el_navigationBar = [[ELNavigationBar alloc] initWithFrame:CGRectZero];
        _el_navigationBar.translatesAutoresizingMaskIntoConstraints = NO;
        _el_navigationBar.backgroundColor = ELColor01;
        [_el_navigationBar.backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _el_navigationBar;
}

-(void)willMoveToParentViewController:(UIViewController *)parent{
    [super willMoveToParentViewController:parent];
}

-(void)didMoveToParentViewController:(UIViewController *)parent{
    [super didMoveToParentViewController:parent];
//    self.el_navigationBar.backBtnType = self.backBtnType;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(ELViewControllerTransitionAnimationType)pushedTransitionType{
    return ELViewControllerTransitionAnimationTypeFromRightToLeft;
}
-(ELViewControllerTransitionAnimationType)popedTransitionType{
    return ELViewControllerTransitionAnimationTypeFromLeftToRight;
}
-(ELViewControllerTransitionAnimationType)presentedTransitionType{
    return  ELViewControllerTransitionAnimationTypeFromBottomToTop;
}
-(ELViewControllerTransitionAnimationType)dismissedTransitionType{
    return  ELViewControllerTransitionAnimationTypeFromTopToBottom;
}

-(ELNavigationBar_BackBtn_type)backBtnType{
    return ELNavigationBar_BackBtn_type_ARROW;
}

-(BOOL)canDragBackWithPan:(UIPanGestureRecognizer *)panGesture{
    return YES;
}

@end
