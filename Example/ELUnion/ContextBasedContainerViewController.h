//
//  ContextBasedContainerViewController.h
//  ELUnion
//
//  Created by 金秋成 on 2016/11/18.
//  Copyright © 2016年 NicolasKim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ELUnion/ELContainerTransitionContext.h>
@interface ContextBasedContainerViewController : UIViewController<ELContainerViewControllerProtocol>
@property (nonatomic,strong)NSArray * el_viewControllers;

@end
