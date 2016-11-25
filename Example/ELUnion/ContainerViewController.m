//
//  ContainerViewController.m
//  ELUIKit
//
//  Created by Nicolas on 2016/10/26.
//  Copyright © 2016年 Nicolas. All rights reserved.
//

#import "ContainerViewController.h"
#import "SubViewcontroller.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
@interface ContainerViewController ()<ELContainerViewControllerDelegate,ELContainerViewControllerDatasource>
@property (nonatomic,strong)NSArray * vcs;
@end

@implementation ContainerViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.vcs = [NSMutableArray new];
            SecondViewController * second = [[SecondViewController alloc]init];
            ThirdViewController  * third  = [[ThirdViewController alloc]init];
            FourthViewController * forth  = [[FourthViewController alloc]init];
            _vcs = @[second,third,forth];
//            [self reloadViewControllers];
        });
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.vcs = [NSMutableArray new];
            SubViewcontroller    * sub    = [[SubViewcontroller alloc]init];
            SecondViewController * second = [[SecondViewController alloc]init];
            ThirdViewController  * third  = [[ThirdViewController alloc]init];
            FourthViewController * forth  = [[FourthViewController alloc]init];
            _vcs = @[sub,second,third,forth];
//            [self reloadViewControllers];
        });
        
        
        
        
        
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

/**
 *  初始viewcontroller 设定
 *
 *  @return 返回初始viewcontroller
 */
-(NSInteger)initializeIndexOfViewController{
    return 0;
}
/**
 *  返回viewcontroller
 *
 *  @param viewController 当前viewcontroller
 *
 *  @return 当前viewcontroller之前的viewcontroller
 */
-(UIViewController *)viewControllerAtIndex:(NSInteger)index{
    return  self.vcs[index];
}

/**
 *  viewcontroller 的数量
 *  viewcontroller的数量决定title的个数
 *  @return viewcontroller 的数量
 */
-(NSInteger)numberOfViewController{
    return self.vcs.count;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
