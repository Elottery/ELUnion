//
//  ScrollTitleBarTestViewController.m
//  ELUnion
//
//  Created by 金秋成 on 2016/11/3.
//  Copyright © 2016年 NicolasKim. All rights reserved.
//

#import "ScrollTitleBarTestViewController.h"
#import <ELUnion/ELScrollTitleBar.h>
#import <ELUnion/DTFlexSelectionView.h>
#import "FlexCollectionViewCell.h"
#import <ELUnion/ELContainerTransitionContext.h>
#import "PushPopTest1ViewController.h"
#import "PushPopTest2ViewController.h"
#import "PushPopTest3ViewController.h"
#import "PushPopTest4ViewController.h"
@interface ScrollTitleBarTestViewController ()<ELScrollTitleBarDatasource,ELScrollTitleBarDelegate,DTFlexSelectionViewDelegate,ELContainerViewControllerDatasource,ELContainerViewControllerDelegate>
{
    ELScrollTitleBar * titlebar;
    DTFlexSelectionView * flexView;
    NSMutableArray * titleArr;
    
    UIView * _containerView;
    NSMutableArray * _vcs;
    
    NSInteger _currentIndex;
}



@end

@implementation ScrollTitleBarTestViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _currentIndex = 0;
//    _containerView = [[UIView alloc]initWithFrame:CGRectMake(0, 108, self.view.frame.size.width, self.view.frame.size.height)];
//    _containerView.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:_containerView];
    titleArr = [NSMutableArray new];
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    titlebar = [[ELScrollTitleBar alloc]initWithFrame:CGRectZero];
    titlebar.datasource = self;
    titlebar.delegate   = self;
    
    [self.view addSubview:titlebar];
    titlebar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[TITLEBAR]-0-|" options:0 metrics:nil views:@{@"TITLEBAR":titlebar}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-64-[TITLEBAR(44)]" options:0 metrics:nil views:@{@"TITLEBAR":titlebar}]];
    
    
    
    
    
    for (NSInteger i = 0; i < 4; i++) {
        [titleArr addObject:[NSString stringWithFormat:@"title%ld",i]];
    }
    [titlebar reloadData];
    
    
    _vcs = [NSMutableArray new];
    PushPopTest1ViewController * vc1 = [[PushPopTest1ViewController alloc]init];
    PushPopTest2ViewController * vc2 = [[PushPopTest2ViewController alloc]init];
    PushPopTest3ViewController * vc3 = [[PushPopTest3ViewController alloc]init];
    PushPopTest4ViewController * vc4 = [[PushPopTest4ViewController alloc]init];
    [_vcs addObject:vc1];
    [_vcs addObject:vc2];
    [_vcs addObject:vc3];
    [_vcs addObject:vc4];
    

    
    
    
//    flexView = [[DTFlexSelectionView alloc]initWithFrame:CGRectMake(10, 200, 200, 64)];
//    [flexView registCellClass:[FlexCollectionViewCell class]];
//    
//    flexView.delegate = self;
//    [self.view addSubview:flexView];
//    [flexView reloadData];
//    flexView.layer.borderWidth = 0.5;
//    flexView.layer.borderColor = [UIColor blackColor].CGColor;
    
    
    //UIButton * switchBtn = [[UIButton alloc]initWithFrame:CGRectMake(230, 200, 70, 44)];
    //[switchBtn setTitle:@"open" forState:UIControlStateNormal];
    //[switchBtn setTitle:@"close" forState:UIControlStateSelected];
    //[switchBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //[switchBtn addTarget:self action:@selector(switchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:switchBtn];
    
    [self reloadChildViewControllers];
}

-(void)switchBtnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    
    [UIView animateWithDuration:2 animations:^{
        flexView.frame = CGRectMake(10, 200, 200, [flexView sizeForOpen:sender.selected].height);
    }];
    
}

-(UIViewController *)viewControllerAtIndex:(NSUInteger)index{
    return  [_vcs objectAtIndex:index];
}
-(NSUInteger)numberOfChildViewController{
    return _vcs.count;
}


-(void)didStartTrasitionFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex{
    NSLog(@"start from index : %lu to index : %lu",fromIndex,toIndex);
}

-(void)didEndTrasitionFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex{
    NSLog(@"end from index : %lu to index : %lu",fromIndex,toIndex);
    [titlebar setSelectedIndex:toIndex animated:YES];
}

-(void)transitionFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex withProgress:(CGFloat)progress{
//    NSLog(@"progress from index : %lu to index : %lu progress : %f",fromIndex,toIndex,progress);
}





-(void)scrollTitleBar:(ELScrollTitleBar *)titleBar didSelectIndex:(NSUInteger)index{
//    ELContainerTransitionContext * context = [[ELContainerTransitionContext alloc]initWithContainerViewController:self containerView:_containerView fromViewController:[_vcs objectAtIndex:_currentIndex] toViewController:[_vcs objectAtIndex:index]];
//    [context startAnimationTrasition];
//    _currentIndex = index;
    
    self.selectIndex = index;
    
    
}


-(NSAttributedString *)scrollTitleBar:(ELScrollTitleBar *)titleBar titleForIndex:(NSUInteger)index{
    NSAttributedString * str = [[NSAttributedString alloc]initWithString:titleArr[index] attributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    return str;
}

-(NSAttributedString *)scrollTitleBar:(ELScrollTitleBar *)titleBar selectedTitleForIndex:(NSUInteger)index{
    NSAttributedString * str = [[NSAttributedString alloc]initWithString:titleArr[index] attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
    return str;
}

-(NSUInteger)numberOfTitleScrollTitleBar:(ELScrollTitleBar *)titleBar{
    return titleArr.count;
}


-(void)flexSelectionView:(DTFlexSelectionView *)view configurCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    FlexCollectionViewCell * confCell = (FlexCollectionViewCell *)cell;
    confCell.layer.borderColor = [UIColor redColor].CGColor;
    confCell.layer.borderWidth = 0.5;
    confCell.titleLabel.text = [NSString stringWithFormat:@"title%ld",indexPath.row];
    
}

-(NSInteger)numberOfTitleInFlexSelectionView:(DTFlexSelectionView *)view{
    return 7;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)el_viewControllers{
    return _vcs;
}

@end
