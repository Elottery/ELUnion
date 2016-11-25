//
//  ELRootTableViewController.m
//  ELUIKit
//
//  Created by 金秋成 on 16/10/13.
//  Copyright © 2016年 Nicolas. All rights reserved.
//

#import "ELRootTableViewController.h"
#import "FlexableViewController.h"
#import "AlertContainerViewController.h"
#import "ContainerViewController.h"
#import "UIControlTestViewController.h"
#import "ScrollTitleBarTestViewController.h"
#import "PresentTestViewController.h"
#import "LoadingViewTestViewController.h"
#import "ELNavigationController.h"
#import "ShareTestViewController.h"
#import "NewsCardTestViewController.h"
#import "ContextBasedContainerViewController.h"

@interface ELRootTableViewController ()
@property (nonatomic,strong)NSArray * listData;
@end

@implementation ELRootTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString * title = [self.listData objectAtIndex:indexPath.row];
    cell.textLabel.text = title;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * title = [self.listData objectAtIndex:indexPath.row];
    if ([title isEqualToString:@"UIView+ELFlexable,HUD"]) {
        FlexableViewController * flexVC = [[FlexableViewController alloc] init];
        [self.navigationController pushViewController:flexVC animated:YES];
    }
    else if ([title isEqualToString:@"Alert ContainerView"]){
        AlertContainerViewController * vc = [[AlertContainerViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([title isEqualToString:@"Container vc"]){
        ContainerViewController * vc = [[ContainerViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([title isEqualToString:@"UIControl_extension"]){
        UIControlTestViewController * vc = [[UIControlTestViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([title isEqualToString:@"ScrollTitleBar"]){
        ScrollTitleBarTestViewController * vc = [[ScrollTitleBarTestViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([title isEqualToString:@"PresentTransition"]){
        PresentTestViewController * vc = [[PresentTestViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([title isEqualToString:@"ELLoadingView"]){
        LoadingViewTestViewController* vc = [[LoadingViewTestViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([title isEqualToString:@"ELNavigationController"]){
        ELNavigationController * nv = [[ELNavigationController alloc]init];
        [self presentViewController:nv animated:YES completion:^{
            
        }];
    }
    else if ([title isEqualToString:@"ShareTestViewController"]){
        ShareTestViewController * vc = [[ShareTestViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([title isEqualToString:@"NewsCard"]){
        NewsCardTestViewController * vc = [[NewsCardTestViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([title isEqualToString:@"ContextBasedContainerViewController"]){
        ContextBasedContainerViewController * vc = [[ContextBasedContainerViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(NSArray *)listData{
    if (!_listData) {
        _listData = @[@"UIView+ELFlexable,HUD",
                      @"Alert ContainerView",
                      @"Container vc",
                      @"UIControl_extension",
                      @"ScrollTitleBar",
                      @"PresentTransition",
                      @"ELLoadingView",
                      @"ELNavigationController",
                      @"ShareTestViewController",
                      @"NewsCard",
                      @"ContextBasedContainerViewController"];

    }
    return _listData;
}
@end
