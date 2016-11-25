//
//  ELScrollTitleBar.h
//  PageViewControllerDemo
//
//  Created by Nicolas on 16/8/23.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ELScrollTitleBar;

@protocol ELScrollTitleBarDelegate <NSObject>

-(void)scrollTitleBar:(ELScrollTitleBar *)titleBar didSelectIndex:(NSUInteger)index;

@end

@protocol ELScrollTitleBarDatasource <NSObject>

-(NSAttributedString *)scrollTitleBar:(ELScrollTitleBar *)titleBar titleForIndex:(NSUInteger)index;

-(NSAttributedString *)scrollTitleBar:(ELScrollTitleBar *)titleBar selectedTitleForIndex:(NSUInteger)index;

-(NSUInteger)numberOfTitleScrollTitleBar:(ELScrollTitleBar *)titleBar;


@end


@interface ELScrollTitleBar : UIView
@property (nonatomic,weak)id<ELScrollTitleBarDelegate>      delegate;
@property (nonatomic,weak)id<ELScrollTitleBarDatasource>    datasource;
@property (nonatomic,assign)NSInteger selectedIndex;
@property (nonatomic,strong)UIView * cursourView;


@property (nonatomic,strong)UIColor * cursourBackgroundColor;

-(void)reloadData;

-(void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated;



/**
 *  更新偏移量
 *  是基于当前偏移量的增量或减量
 *  @param x 偏移量
 */
-(void)updateContentOffsetX:(CGFloat)x;

-(void)endUpdateContentOffset;


@end
