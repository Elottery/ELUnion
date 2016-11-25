//
//  UIControlTestViewController.m
//  ELUnion
//
//  Created by 金秋成 on 2016/11/1.
//  Copyright © 2016年 NicolasKim. All rights reserved.
//

#import "UIControlTestViewController.h"
#import <ELUnion/UIControl+ELExtention.h>
@interface UIControlTestViewController ()

@end

@implementation UIControlTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 60)];
    [btn setTitle:@"blockSelector" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [btn el_addControlEvents:UIControlEventTouchUpInside actionHandle:^(UIControl *sender, UIEvent *event) {
//        NSLog(@"hahahah");
//    }];
    [self.view addSubview:btn];
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
