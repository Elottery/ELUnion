//
//  PushPopTest2ViewController.m
//  ELUnion
//
//  Created by 金秋成 on 2016/11/17.
//  Copyright © 2016年 NicolasKim. All rights reserved.
//

#import "PushPopTest2ViewController.h"
#import "PushPopTest3ViewController.h"
#import <ELUnion/ELTransitionAnimationType.h>
@interface PushPopTest2ViewController ()<ELTransitionProtocol>

@end

@implementation PushPopTest2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 40)];
    [btn setTitle:@"PUSH" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pushVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
}

-(void)pushVC{
    PushPopTest3ViewController * shareVC = [[PushPopTest3ViewController alloc]init];
    [self.navigationController pushViewController:shareVC animated:YES];
}
//-(ELViewControllerTransitionAnimationType)pushedTransitionType{
//    return ELViewControllerTransitionAnimationTypeFromLeftToRight;
//}
//
//-(ELViewControllerTransitionAnimationType)popedTransitionType{
//    return ELViewControllerTransitionAnimationTypeFromTopToBottom;
//}
-(BOOL)canDragBackWithPan:(UIPanGestureRecognizer *)panGesture{
    
   CGPoint point = [panGesture translationInView:self.navigationController.view];
    
    if (point.y > 300 ) {
        return YES;
    }
    return NO;
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
