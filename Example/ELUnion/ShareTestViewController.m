//
//  ShareTestViewController.m
//  ELUnion
//
//  Created by 金秋成 on 2016/11/11.
//  Copyright © 2016年 NicolasKim. All rights reserved.
//

#import "ShareTestViewController.h"
#import <ELUnion/ELShareViewController.h>
#import <ELUnion/UIView+HUD.h>
#import <ELUnion/UIViewController+ELTransition.h>
@interface ShareTestViewController ()<ELTransitionProtocol>

@end

@implementation ShareTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 44)];
    [btn setTitle:@"show" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)btnClick{
//    [[ELShareService sharedService]shareToPlatform:ELShareService_Platform_WECHAT andSubtype:ELShareService_Platform_WECHAT_SESSION withTitle:@"alksjdlkfja" andUrl:@"http://www.baidu.com" andThunailImage:UIImagePNGRepresentation([UIImage imageNamed:@"方框橙色"]) compelete:^(BOOL success, NSError *error) {
//        NSLog(@"%@",error.localizedDescription);
//    }];
    __weak typeof(self) weakSelf = self;
    ELShareViewController * vc = [[ELShareViewController alloc]init];
    vc.shareTitle = @"haha";
    vc.shareURL = @"http://baidu.com";
    vc.complete = ^(BOOL success , NSError * error){
        if (success) {
            [weakSelf.view showTipHUD:@"分享成功"];
        }
        else{
            [weakSelf.view showTipHUD:error.localizedDescription];
        }
    };
    [self el_presentViewController:vc withAnimationType:ELViewControllerTransitionAnimationTypeNoneAnimation animationComplete:^{
        
    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(ELViewControllerTransitionAnimationType)pushedTransitionType{
    return ELViewControllerTransitionAnimationTypeFromTopToBottom;
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
