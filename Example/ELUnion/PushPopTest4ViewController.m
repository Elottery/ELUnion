//
//  PushPopTest4ViewController.m
//  ELUnion
//
//  Created by 金秋成 on 2016/11/17.
//  Copyright © 2016年 NicolasKim. All rights reserved.
//

#import "PushPopTest4ViewController.h"
#import <ELUnion/ELTransitionAnimationType.h>
@interface PushPopTest4ViewController ()<ELTransitionProtocol>

@end

@implementation PushPopTest4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 40)];
    [btn setTitle:@"POP" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(popVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)popVC{
    [self.navigationController popToViewController:[self.navigationController.viewControllers firstObject] animated:YES];
}


//-(ELViewControllerTransitionAnimationType)pushedTransitionType{
//    return ELViewControllerTransitionAnimationTypeFromBottomToTop;
//}
//
//-(ELViewControllerTransitionAnimationType)popedTransitionType{
//    return ELViewControllerTransitionAnimationTypeFromRightToLeft;
//}


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
