//
//  FlexableViewController.m
//  ELUIKit
//
//  Created by 金秋成 on 16/10/13.
//  Copyright © 2016年 Nicolas. All rights reserved.
//

#import "FlexableViewController.h"
#import <ELUnion/UIView+HUD.h>
@interface FlexableViewController ()
{
    NSTimer * t;
    float progress ;
}
@end

@implementation FlexableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    progress = 0;
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)hudDidClick:(id)sender {
    [self.view showHUD:@"hud"];
}
- (IBAction)tipDidClick:(id)sender {
    [self.view showTipHUD:@"tip"];
}

- (IBAction)SuccessDidClick:(id)sender {
    [self.view showSuccessHUD:@"success"];
}

- (IBAction)errorDidClick:(id)sender {
    [self.view showErrorHUD:@"error"];
}

- (IBAction)updateDidClick:(id)sender {
    t = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
}

- (IBAction)dismissDidClick:(id)sender {
    [self.view dismissHUD];
}

- (IBAction)progressDidClick:(id)sender {
    [self.view showProgressHUD:@"progress"];
}

- (void)updateProgress{
    progress += 0.1;
    [self.view updateProgress:progress HUD:[NSString stringWithFormat:@"updating%.0f",progress * 100]];
    if (progress >= 1) {
        [t invalidate];
        t = nil;
        [self.view dismissHUD];
        return;
    }
}



@end
