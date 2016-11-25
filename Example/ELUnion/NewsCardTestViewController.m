//
//  NewsCardTestViewController.m
//  ELUnion
//
//  Created by 金秋成 on 2016/11/14.
//  Copyright © 2016年 NicolasKim. All rights reserved.
//

#import "NewsCardTestViewController.h"
#import <ELUnion/ELTabView.h>
@interface NewsCardTestViewController ()
@property (nonatomic,strong)ELTabView * tabView;
@end

@implementation NewsCardTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tabView = [[ELTabView alloc]initWithFrame:CGRectMake(20, 100, 200, 200)];
    self.tabView.tabTitles = @[@"item1",@"item2",@"item3"];
    
    self.tabView.dataSource = ^NSArray *(NSUInteger titleIndex){
        if (titleIndex == 0) {
            return @[@"item1",@"item2",@"item3",@"item1",@"item2",@"item3",@"item1",@"item2"];
        }
        else if (titleIndex == 1){
            return @[@"item1",@"item2",@"item3",@"item1"];
        }
        else{
            return @[@"item1"];
        }
    };
    
    
    [self.view addSubview:self.tabView];
    
    
    
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.tabView.selectIndex = 2;
//        self.tabView.frame = CGRectMake(20, 100, 200, 200);
//    });
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
