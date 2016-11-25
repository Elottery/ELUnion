//
//  ELNavigationController.m
//  ELUnion
//
//  Created by Nicolas on 2016/11/8.
//  Copyright © 2016年 NicolasKim. All rights reserved.
//

#import "ELNavigationController.h"
#import "ELNavigationRootViewController.h"
#import <ELUnion/UINavigationController+ELTransition.h>
@interface ELNavigationController ()

@end

@implementation ELNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    ELNavigationRootViewController * root = [[ELNavigationRootViewController alloc] init];
//    root.el_navigationBar.backBtnType = ELNavigationBar_BackBtn_type_CROSS;
//    [self pushViewController:root animated:NO];
    self.enableInteration = YES;
    [self pushViewController:root animated:YES];
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
