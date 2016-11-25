//
//  CommonSelectionView.h
//  BetSelectionDemo
//
//  Created by 金秋成 on 16/9/14.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonSelectionViewModel.h"
@interface CommonSelectionView : UIView
@property (nonatomic,weak)id<CommonSelectionViewDelegate> delegate;
-(void)reloadData;
@end
