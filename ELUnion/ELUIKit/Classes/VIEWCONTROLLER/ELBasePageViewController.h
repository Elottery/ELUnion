//
//  ELBasePageViewController.h
//  PageViewControllerDemo
//
//  Created by 金秋成 on 16/8/9.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "ELBaseViewController.h"

#import "ELCursourView.h"

@protocol ELBasePageViewControllerDatasource <NSObject>

/**
 *  初始viewcontroller 设定
 *
 *  @return 返回初始viewcontroller
 */
-(NSInteger)initializeIndexOfViewController;
/**
 *  返回viewcontroller
 *
 *  @param viewController 当前viewcontroller
 *
 *  @return 当前viewcontroller之前的viewcontroller
 */
-(UIViewController *)viewControllerAtIndex:(NSInteger)index;

/**
 *  viewcontroller 的数量
 *  viewcontroller的数量决定title的个数
 *  @return viewcontroller 的数量
 */
-(NSInteger)numberOfViewController;


/**
 *  未选中状态时的title
 *
 *  @param viewController title对应的uiviewcontroller
 *  @param index          索引
 *
 *  @return 只支持 颜色，大小，字体的设置
 */
-(NSAttributedString *)titleForViewController:(UIViewController *)viewController atIndex:(NSInteger)index;
/**
 *  选中状态时的title
 *
 *  @param viewController title对应的uiviewcontroller
 *  @param index          索引
 *
 *  @return 只支持 颜色，大小，字体的设置
 */
-(NSAttributedString *)selectedTitleForViewController:(UIViewController *)viewController atIndex:(NSInteger)index;


@end



@protocol ELBasePageViewControllerDelegate <NSObject>

@optional


-(void)didSelectViewControllerAtIndex:(NSInteger)index;


@end





@interface ELBasePageViewController : ELBaseViewController


/**
 *  以下两个代理的设置   一定要在该对象viewdidload之前赋值
 */

@property (nonatomic,weak)id<ELBasePageViewControllerDatasource> dataSource;

@property (nonatomic,weak)id<ELBasePageViewControllerDelegate> delegate;


/**
 *  滑动条背景色
 */
@property (nonatomic,strong)UIColor * cursourViewBackGroundColor;



/**
 *  title的左右间距
 */
@property (nonatomic,assign)CGFloat titleGap;

/**
 *  只支持左右的内边距  top和bottom无效
 */
@property (nonatomic,assign)UIEdgeInsets * titleEdgeInsets;

-(void)reloadData;


@end
