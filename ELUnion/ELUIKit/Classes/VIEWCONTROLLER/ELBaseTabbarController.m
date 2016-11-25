//
//  ELBaseTabbarController.m
//  ELUIFramework
//
//  Created by 金秋成 on 16/7/16.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "ELBaseTabbarController.h"

#define EL_TABBAR_HEIGHT 49

@interface ELBaseTabbarController ()

@end

@implementation ELBaseTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.hidden = YES;
    _el_tabbar = [[ELTabbar alloc]initWithFrame:CGRectZero];
    _el_tabbar.backgroundColor = [UIColor whiteColor];
    _el_tabbar.translatesAutoresizingMaskIntoConstraints = NO;
    _el_tabbar.tabbarController = self;
    [self.view addSubview:_el_tabbar];
    
    
    //tabbar距mainview下方默认为0
    _tabbarBottomConstraint = [NSLayoutConstraint constraintWithItem:_el_tabbar
                                                           attribute:NSLayoutAttributeBottom
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.view
                                                           attribute:NSLayoutAttributeBottom
                                                          multiplier:1
                                                            constant:0];
    //tabbar高度默认为49
    _tabbarHeightConstraint = [NSLayoutConstraint constraintWithItem:_el_tabbar
                                                           attribute:NSLayoutAttributeHeight
                                                           relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                              toItem:nil
                                                           attribute:NSLayoutAttributeNotAnAttribute
                                                          multiplier:1
                                                            constant:EL_TABBAR_HEIGHT];
    [self.view addConstraints:@[_tabbarBottomConstraint,_tabbarHeightConstraint]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[TAB_BAR]-0-|" options:0 metrics:nil views:@{@"TAB_BAR":_el_tabbar}]];
    
    
}


-(void)el_setTabbarHidden:(BOOL)hide animated:(BOOL)animated{
    _el_tabbarHidden = hide;
    if (hide && animated) {
        [UIView animateWithDuration:0.28 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.el_tabbar.transform = CGAffineTransformMakeTranslation(0, EL_TABBAR_HEIGHT);
        } completion:^(BOOL finished) {
            
        }];
    }
    else if(!hide && animated){
        [UIView animateWithDuration:0.28 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.el_tabbar.transform = CGAffineTransformMakeTranslation(0, 0);
        } completion:^(BOOL finished) {
            
        }];
    }
    else if (hide && !animated){
        self.el_tabbar.transform = CGAffineTransformMakeTranslation(0, EL_TABBAR_HEIGHT);
    }
    else{
        self.el_tabbar.transform = CGAffineTransformMakeTranslation(0, 0);
    }
    
}
-(void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers{
    [super setViewControllers:viewControllers];
    [_el_tabbar removeAllBarItems];
    __weak typeof(self) weakSelf = self;
    [self.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (!obj.tabbarItem) {
            ELTabbarItem * item = [ELTabbarItem defautItem];
            if (obj.title) {
                item.title = obj.title;
            }
            obj.tabbarItem = item;
        }
        obj.tabbarItem.clickHandler = ^(){
            weakSelf.selectedIndex = idx;
        };
        [_el_tabbar addBarItem:obj.tabbarItem];
    }];

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
