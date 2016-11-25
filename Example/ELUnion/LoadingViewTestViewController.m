//
//  LoadingViewTestViewController.m
//  ELUnion
//
//  Created by Nicolas on 2016/11/5.
//  Copyright © 2016年 NicolasKim. All rights reserved.
//

#import "LoadingViewTestViewController.h"
#import <ELUnion/ELLoadingView.h>
@interface LoadingViewTestViewController ()<ELLoadingViewDelegate>
@property (nonatomic,strong)ELLoadingView * loadingView;
@end

@implementation LoadingViewTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _loadingView = [[ELLoadingView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
    _loadingView.delegate = self;
    
    self.view.backgroundColor  = [UIColor whiteColor];
    
    
    
    
    
    [self.view addSubview:_loadingView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_loadingView startLoading];
    });
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_loadingView failLoading];
    });
    
        
}




- (void)loadingView:(ELLoadingView *)loadingView didAddSubView:(UIView *)subview forState:(ELLoadingViewState)state{
    
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
