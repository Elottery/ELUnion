//
//  ELBaseTabbarController.h
//  ELUIFramework
//
//  Created by 金秋成 on 16/7/16.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELTabbar.h"

@protocol ELBaseTabbarControllerProtocol <NSObject>

@property (nonatomic,strong,readonly)ELTabbar          * el_tabbar;

@property (nonatomic,strong,readonly)NSLayoutConstraint * tabbarBottomConstraint;

@property (nonatomic,strong,readonly)NSLayoutConstraint * tabbarHeightConstraint;

@property (nonatomic,assign)BOOL el_tabbarHidden;

-(void)el_setTabbarHidden:(BOOL)hide animated:(BOOL)animated;

@end

@interface ELBaseTabbarController : UITabBarController<ELBaseTabbarControllerProtocol>

@property (nonatomic,strong,readonly)ELTabbar          * el_tabbar;

@property (nonatomic,strong,readonly)NSLayoutConstraint * tabbarBottomConstraint;

@property (nonatomic,strong,readonly)NSLayoutConstraint * tabbarHeightConstraint;

@property (nonatomic,assign)BOOL el_tabbarHidden;

-(void)el_setTabbarHidden:(BOOL)hide animated:(BOOL)animated;

@end
