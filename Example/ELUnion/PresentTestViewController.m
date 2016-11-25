//
//  PresentTestViewController.m
//  ELUnion
//
//  Created by 金秋成 on 2016/11/10.
//  Copyright © 2016年 NicolasKim. All rights reserved.
//

#import "PresentTestViewController.h"
#import "DismissTestViewController.h"
#import <ELUnion/UIViewController+ELTransition.h>

@interface PresentTestViewController ()

@end

@implementation PresentTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * presentBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 80, 100, 50)];
    [presentBtn setTitle:@"present" forState:UIControlStateNormal];
    [presentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [presentBtn addTarget:self action:@selector(presntBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:presentBtn];
    
}
- (void)presntBtnClick{
    DismissTestViewController * dismissVC = [[DismissTestViewController alloc] init];
    [self el_presentViewController:dismissVC
                      withAnimationType:ELViewControllerTransitionAnimationTypeFromLeftToRight
                 animationComplete:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
