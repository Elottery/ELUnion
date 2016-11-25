//
//  ELNavigationRootViewController.m
//  ELUnion
//
//  Created by Nicolas on 2016/11/8.
//  Copyright © 2016年 NicolasKim. All rights reserved.
//

#import "ELNavigationRootViewController.h"
#import <ELUnion/UINavigationController+ELTransition.h>
#import "PushPopTest1ViewController.h"

@interface ELNavigationRootViewController ()<ELTransitionProtocol>

@end

@implementation ELNavigationRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.el_navigationBar.backBtnType = ELNavigationBar_BackBtn_type_CROSS;
    
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 40)];
    [btn setTitle:@"PUSH" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pushVC) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
}

-(void)pushVC{
    PushPopTest1ViewController * shareVC = [[PushPopTest1ViewController alloc]init];
    [self.navigationController pushViewController:shareVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(ELViewControllerTransitionAnimationType)popedTransitionType{
    return  ELViewControllerTransitionAnimationTypeFromLeftToRight;
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
