//
//  ELBaseNavigationController.m
//  ELUIFramework
//
//  Created by 金秋成 on 16/7/8.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "ELBaseNavigationController.h"
#import "ELBaseTabbarController.h"
#import "UINavigationController+ELTransition.h"




@interface ELBaseNavigationController ()<UINavigationControllerDelegate>

@end

@implementation ELBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBarHidden = YES;
    self.enableInteration = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
    if ([viewController conformsToProtocol:@protocol(ELBaseViewControllerProtocol)]) {
        UIViewController<ELBaseViewControllerProtocol> * el_viewController = (UIViewController<ELBaseViewControllerProtocol> *)viewController;
        if (el_viewController.el_tabbarHiddenWhenPushed) {
            
            if ([el_viewController.tabBarController conformsToProtocol:@protocol(ELBaseTabbarControllerProtocol)]) {
                UITabBarController<ELBaseTabbarControllerProtocol> * el_tabbarController =  (UITabBarController<ELBaseTabbarControllerProtocol> *)el_viewController.tabBarController;
                [el_tabbarController el_setTabbarHidden:YES animated:YES];
            }
        }
    }
}
-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
    UIViewController * vc = [super popViewControllerAnimated:animated];
    if ([vc conformsToProtocol:@protocol(ELBaseViewControllerProtocol)] &&
        [vc.tabBarController conformsToProtocol:@protocol(ELBaseTabbarControllerProtocol)])
    {
        UITabBarController<ELBaseTabbarControllerProtocol> * tabbarVC = (UITabBarController<ELBaseTabbarControllerProtocol> *)vc.tabBarController;
        ELBaseViewController * viewController = self.viewControllers.lastObject;
        [tabbarVC el_setTabbarHidden:viewController.el_tabbarHiddenWhenPushed animated:YES];
    }
    return vc;
}

-(NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    NSArray<UIViewController *> * arr = [super popToViewController:viewController animated:animated];
    if ([viewController conformsToProtocol:@protocol(ELBaseViewControllerProtocol)] &&
        [viewController.tabBarController conformsToProtocol:@protocol(ELBaseTabbarControllerProtocol)])
    {
        UITabBarController<ELBaseTabbarControllerProtocol> * tabbarVC = (UITabBarController<ELBaseTabbarControllerProtocol> *)viewController.tabBarController;
        [tabbarVC el_setTabbarHidden:NO animated:YES];
    }
    return arr;
}


//-(void)el_pushViewController:(UIViewController *)viewController animationType:(ELViewControllerTransitionAnimationType)type{
//    [self pushViewController:viewController animated:YES];
//    
//}
//
//-(UIViewController *)el_popViewControllerWithAnimationType:(ELViewControllerTransitionAnimationType)type{
//    [self popViewControllerAnimated:YES];
//}
//
//-(NSArray<UIViewController *> *)el_popToViewController:(UIViewController *)viewController animationType:(ELViewControllerTransitionAnimationType)type{
//    [self popToViewController:viewController animated:YES];
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
