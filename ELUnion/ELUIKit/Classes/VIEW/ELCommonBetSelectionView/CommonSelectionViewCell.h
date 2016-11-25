//
//  CommonSelectionViewCell.h
//  BetSelectionDemo
//
//  Created by 金秋成 on 16/9/14.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonSelectionViewModel.h"
@interface CommonSelectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

-(void)bindViewModel:(id<SelectionViewModelProtocol>)viewModel;

@end
