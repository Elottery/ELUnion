//
//  CommonSelectionViewCell.m
//  BetSelectionDemo
//
//  Created by 金秋成 on 16/9/14.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "CommonSelectionViewCell.h"

@implementation CommonSelectionViewCell
{
    id<SelectionViewModelProtocol> _vm;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)bindViewModel:(id<SelectionViewModelProtocol>)viewModel{
    _vm = viewModel;
    
    if (viewModel.selected) {
        self.titleLabel.attributedText    = _vm.attributedSelectedTitle;
        self.subTitleLabel.attributedText = _vm.attributedSelectedSubTitle;
        self.backgroundColor = _vm.selectedBackgroundColor;
    }
    else{
        self.titleLabel.attributedText = _vm.attributedTitle;
        self.subTitleLabel.attributedText = _vm.attributedSubTitle;
        self.backgroundColor = _vm.backgroundColor;
    }
}



@end
