//
//  ELBasePageViewController.m
//  PageViewControllerDemo
//
//  Created by 金秋成 on 16/8/9.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "ELBasePageViewController.h"
#import "ELScrollTitleBar.h"
typedef NS_ENUM(NSUInteger, ScrollDirect) {
    ScrollDirectLeftToRight,
    ScrollDirectRightToLeft,
};


@interface ELBasePageViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource,UIGestureRecognizerDelegate,ELScrollTitleBarDelegate,ELScrollTitleBarDatasource>
@property (nonatomic,strong)UIPageViewController * pageViewController;
@property (nonatomic,strong)NSArray *              hContraints;
@property (nonatomic,strong)NSArray *              vContraints;


@property (nonatomic,strong)UIPanGestureRecognizer * swipeGes;

@property (nonatomic,assign)NSInteger              currentIndex;

@property (nonatomic,assign)NSInteger              numberOfVC;

@property (nonatomic,assign)ScrollDirect           direct;

@property (nonatomic,strong)ELScrollTitleBar * bar;

@property (nonatomic,assign)UIPageViewControllerNavigationDirection reloadDirection;

@property (nonatomic,assign)CGPoint startPanPoint;

@property (nonatomic,strong)UIView * cursourView;

@end

@implementation ELBasePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentIndex = [self.dataSource initializeIndexOfViewController];
    self.numberOfVC   = [self.dataSource numberOfViewController];
    
    [self addChildViewController: self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    self.pageViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self remakeConstraint];
    [self.pageViewController didMoveToParentViewController:self];
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:self.swipeGes];
    
    
    
    self.bar = [[ELScrollTitleBar alloc]initWithFrame:CGRectZero];
    self.bar.delegate = self;
    self.bar.datasource = self;
    self.bar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.bar];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[bar]-0-|" options:0 metrics:nil views:@{@"bar":self.bar}]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-64-[bar(44)]" options:0 metrics:nil views:@{@"bar":self.bar}]];
    
    
    [self reloadData];
}





-(void)remakeConstraint{
    
    if (self.hContraints) {
        [self.view removeConstraints:_hContraints];
    }
    if (self.vContraints) {
        [self.view removeConstraints:self.vContraints];
    }
    
    self.hContraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-left-[CONTAINER]-right-|"
                                                                  options:0
                                                                  metrics:@{@"left":@(0),
                                                                          @"right":@(0)}
                                                                    views:@{@"CONTAINER":self.pageViewController.view}];
    self.vContraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-top-[CONTAINER]-bottom-|"
                                                                  options:0
                                                                  metrics:@{@"top":@(64+44),
                                                                            @"bottom":@(self.el_tabbarHiddenWhenPushed ? 0 : 40)}
                                                                    views:@{@"CONTAINER":self.pageViewController.view}];
    
    
    
    
    [self.view addConstraints:self.hContraints];
    [self.view addConstraints:self.vContraints];
    
    [self.view layoutIfNeeded];
}


-(void)reloadData{
    __weak typeof(self) weakSelf = self;
    self.numberOfVC   = [self.dataSource numberOfViewController];
    if (self.numberOfVC > 0) {
        _pageViewController.view.userInteractionEnabled = YES;
        UIViewController * currentViewController = [self.dataSource viewControllerAtIndex:self.currentIndex];
        [_pageViewController setViewControllers:@[currentViewController] direction:self.reloadDirection animated:NO completion:^(BOOL finished) {
            [weakSelf.delegate didSelectViewControllerAtIndex:weakSelf.currentIndex];
            [weakSelf.bar reloadData];
        }];
    }
    else{
        [self.bar reloadData];
        _pageViewController.view.userInteractionEnabled = NO;
    }
}
- (void)swipeGesture:(UIPanGestureRecognizer *)gesture{
    
    CGPoint point = [gesture velocityInView:self.view];
    if (point.x > 0) {
        self.direct = ScrollDirectLeftToRight;
    }
    else{
        self.direct = ScrollDirectRightToLeft;
    }

    
}

#pragma mark -dataSource


- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    UIViewController * beforeViewController = [[UIViewController alloc] init];
    if (self.numberOfVC >= 0) {
        NSInteger index = self.currentIndex;
        if (index ==0 ) {
            index = self.numberOfVC-1;
        }
        else{
            index = index - 1;
        }
        beforeViewController = [self.dataSource viewControllerAtIndex:index];
        
    }
    
    return beforeViewController;
    
    
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    UIViewController * afterViewController = [[UIViewController alloc] init];;
    if (self.numberOfVC > 0) {
        NSInteger index = self.currentIndex;
        index = (index + 1)%self.numberOfVC;
        afterViewController = [self.dataSource viewControllerAtIndex:index];
    }
    return afterViewController;
}





-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    if (self.numberOfVC > 0) {
        if (completed) {
            if (self.direct == ScrollDirectLeftToRight) {
                if ((self.currentIndex - (long)previousViewControllers.count) < 0) {
                    self.currentIndex = self.numberOfVC + (self.currentIndex - (long)previousViewControllers.count);
                }
                else{
                    self.currentIndex = self.currentIndex - (long)previousViewControllers.count;
                }
            }
            else{
                self.currentIndex = (self.currentIndex + previousViewControllers.count)%self.numberOfVC;
            }
            [self.delegate didSelectViewControllerAtIndex:self.currentIndex];
        }
        
        [self.bar setSelectedIndex:self.currentIndex animated:YES];
    }
}

#pragma mark -titlebardatasource

-(NSAttributedString *)scrollTitleBar:(ELScrollTitleBar *)titleBar titleForIndex:(NSUInteger)index{
    return [self.dataSource titleForViewController:nil atIndex:index];
}

-(NSAttributedString *)scrollTitleBar:(ELScrollTitleBar *)titleBar selectedTitleForIndex:(NSUInteger)index{
    return [self.dataSource selectedTitleForViewController:nil atIndex:index];
}

-(NSUInteger)numberOfTitleScrollTitleBar:(ELScrollTitleBar *)titleBar{
    return self.numberOfVC;
}

#pragma mark -titlebardelegate
-(void)scrollTitleBar:(ELScrollTitleBar *)titleBar didSelectIndex:(NSUInteger)index{
    
    if (index < self.currentIndex) {
        self.reloadDirection =UIPageViewControllerNavigationDirectionReverse;
    }
    else{
        self.reloadDirection =UIPageViewControllerNavigationDirectionForward;
    }
    
    self.currentIndex = index;
    
    
    [self reloadData];
}

#pragma mark -setter

-(void)setCursourViewBackGroundColor:(UIColor *)cursourViewBackGroundColor{
    _cursourViewBackGroundColor = cursourViewBackGroundColor;
    self.bar.cursourBackgroundColor = cursourViewBackGroundColor;
}


#pragma mark -getter






-(UIPageViewController *)pageViewController{
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                             navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                           options:@{UIPageViewControllerOptionSpineLocationKey : @(UIPageViewControllerSpineLocationMin)}];
        
        
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
    }
    return _pageViewController;
}

-(UIPanGestureRecognizer *)swipeGes{
    if (!_swipeGes) {
        _swipeGes = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGesture:)];
        _swipeGes.delegate = self;
    }
    return _swipeGes;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
