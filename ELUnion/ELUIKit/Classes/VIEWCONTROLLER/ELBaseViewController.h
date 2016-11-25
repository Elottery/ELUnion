//
//  ELBaseViewController.h
//  ELUIFramework
//
//  Created by 金秋成 on 16/7/8.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELNavigationBar.h"
#import "ELTabbar.h"
#import "ConstantsColors.h"
#import "ELTransitionAnimationType.h"
#import "UIViewController+ELTransition.h"



@protocol ELBaseViewControllerProtocol <NSObject>
/**
 *  navigation bar 归属于 viewcontroller
 */
@property (nonatomic,strong,readonly)ELNavigationBar * el_navigationBar;

//@property (nonatomic,strong,readonly)UIView          * el_mainView;

@property (nonatomic,assign)BOOL el_tabbarHiddenWhenPushed;

@property (nonatomic,weak,readonly)ELTabbar          * el_tabbar;

@property (nonatomic,weak,readonly)ELBaseTabbarController * el_tabbarController;

- (void)el_setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated;


-(void)backBtnDidClick;

-(BOOL)canBackBtnClick;

-(void)willNavigationBack;

//以下为规范可以不实现，但是会有警告。

/**
 *  初始化subviews，调用时机自己定
 */
-(void)setUpView;



@end


@class ELBaseTabbarController;
@interface ELBaseViewController : UIViewController<ELBaseViewControllerProtocol,ELTransitionProtocol>

@property (nonatomic,strong,readonly) ELNavigationBar * el_navigationBar;

@property (nonatomic,assign) BOOL el_tabbarHiddenWhenPushed;

@property (nonatomic,weak,readonly) ELTabbar          * el_tabbar;

@property (nonatomic,weak,readonly)ELBaseTabbarController * el_tabbarController;

- (void)backBtnClick;

- (void)el_setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated;

@end
