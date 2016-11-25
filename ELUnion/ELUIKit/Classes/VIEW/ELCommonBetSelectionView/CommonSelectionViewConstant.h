//
//  CommonSelectionViewConstant.h
//  BetSelectionDemo
//
//  Created by 金秋成 on 16/9/14.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#ifndef CommonSelectionViewConstant_h
#define CommonSelectionViewConstant_h
#import <UIKit/UIKit.h>
@class CommonSelectionView;

@protocol SelectionViewModelProtocol;

typedef void(^CommonSelectionViewSelectHandler)(id<SelectionViewModelProtocol> viewModel,NSInteger index);


@protocol SelectionViewModelProtocol <NSObject>

@property (nonatomic,strong)NSAttributedString * attributedTitle;
@property (nonatomic,strong)NSAttributedString * attributedSubTitle;

@property (nonatomic,strong)NSAttributedString * attributedSelectedTitle;
@property (nonatomic,strong)NSAttributedString * attributedSelectedSubTitle;

@property (nonatomic,strong)UIColor   * backgroundColor;
@property (nonatomic,strong)UIColor   * selectedBackgroundColor;


@property (nonatomic,assign)NSUInteger cellSpan;//水平跨度
@property (nonatomic,assign)BOOL selected;
@property (nonatomic,assign)BOOL enable;
@property (nonatomic,copy)CommonSelectionViewSelectHandler selectHandler;
@end



//代理协议
@protocol CommonSelectionViewDelegate <NSObject>



#pragma mark 矩阵网格   跟数据源无关
//单行显示cell的数量
-(NSInteger)cellCountInSingleRowInSelectionView:(CommonSelectionView *)selectionView;
//单列显示cell的数量
-(NSInteger)cellCountInSingleLieInSelectionView:(CommonSelectionView *)selectionView;

//返回数据源
//cell对应的viewmodel
-(NSArray<id<SelectionViewModelProtocol>> *)viewModelsOfSelectionView:(CommonSelectionView *)selectionView;




@optional
//水平cell的间距
-(CGFloat)horizontalCellSpaceOfSelectionView:(CommonSelectionView *)selectionView;
//垂直cell的间距
-(CGFloat)verticalCellSpaceSelectionView:(CommonSelectionView *)selectionView;

-(void)commonSelectionView:(CommonSelectionView *)selectionView
      didSelectItemAtIndex:(NSInteger)index
              andViewModel:(id<SelectionViewModelProtocol>)viewModel;



@end


//类协议
@protocol CommonSelectionViewFlowLayoutProtocol <NSObject>

@property (nonatomic,weak)id<CommonSelectionViewDelegate> delegate;

@end

#endif /* CommonSelectionViewConstant_h */
