//
//  PushPopTest1ViewController.m
//  ELUnion
//
//  Created by 金秋成 on 2016/11/17.
//  Copyright © 2016年 NicolasKim. All rights reserved.
//

#import "PushPopTest1ViewController.h"
#import "PushPopTest2ViewController.h"
#import <ELUnion/ELTransitionAnimationType.h>
@interface PushPopTest1ViewController ()<ELTransitionProtocol>

@end

@implementation PushPopTest1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor brownColor];
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 40)];
    [btn setTitle:@"PUSH" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pushVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    
}
-(void)pushVC{
    PushPopTest2ViewController * shareVC = [[PushPopTest2ViewController alloc]init];
    [self.navigationController pushViewController:shareVC animated:YES];
}

-(ELViewControllerTransitionAnimationType)pushedTransitionType{
    return ELViewControllerTransitionAnimationTypeFromRightToLeft;
}

-(ELViewControllerTransitionAnimationType)popedTransitionType{
    return ELViewControllerTransitionAnimationTypeFromTopToBottom;
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
