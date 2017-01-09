//
//  ELContainerViewController.h
//  Pods
//
//  Created by Nicolas on 2016/10/26.
//
//

#import "ELBaseViewController.h"



@protocol ELContainerViewControllerDatasource <NSObject>

-(UIViewController *)viewControllerAtIndex:(NSUInteger)index;

-(NSUInteger)numberOfChildViewController;



@end



@protocol ELContainerViewControllerDelegate <NSObject>


@optional


-(void)didStartTrasitionFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

-(void)transitionFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex withProgress:(CGFloat)progress;

-(void)didEndTrasitionFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

@end



@interface ELContainerViewController : ELBaseViewController

@property (nonatomic,assign)UIEdgeInsets containerViewEdge;

@property (nonatomic,assign)NSUInteger currentIndex;

@property (nonatomic,assign)NSUInteger selectIndex;




@property (nonatomic,weak)id<ELContainerViewControllerDatasource> dataSource;

@property (nonatomic,weak)id<ELContainerViewControllerDelegate> delegate;

-(void)reloadChildViewControllers;

@end
