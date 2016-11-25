//
//  CommonSelectionViewFlowLayout.h
//  BetSelectionDemo
//
//  Created by 金秋成 on 16/9/14.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "CommonSelectionViewConstant.h"



@protocol CommonSelectionViewFlowLayoutDelegate <NSObject>

-(NSInteger)cellCountInSingleRow;

-(NSInteger)cellCountInSingleLie;

-(NSArray<id<SelectionViewModelProtocol>> *)viewModelsOfFlowLayout;

@end

@interface CommonSelectionViewFlowLayout : UICollectionViewFlowLayout
@property (nonatomic,weak)id<CommonSelectionViewFlowLayoutDelegate> delegate;
@end
