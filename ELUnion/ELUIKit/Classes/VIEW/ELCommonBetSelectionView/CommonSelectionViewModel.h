//
//  CommonSelectionViewModel.h
//  BetSelectionDemo
//
//  Created by 金秋成 on 16/9/14.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonSelectionViewConstant.h"

@interface CommonSelectionViewModel : NSObject<SelectionViewModelProtocol>
@property (nonatomic,strong)NSAttributedString * attributedTitle;
@property (nonatomic,strong)NSAttributedString * attributedSubTitle;

@property (nonatomic,strong)NSAttributedString * attributedSelectedTitle;
@property (nonatomic,strong)NSAttributedString * attributedSelectedSubTitle;

@property (nonatomic,strong)UIColor   * backgroundColor;
@property (nonatomic,strong)UIColor   * selectedBackgroundColor;

@property (nonatomic,assign)NSUInteger cellSpan;//默认为1
@property (nonatomic,assign)BOOL selected;
@property (nonatomic,assign)BOOL enable;//默认为yes
@property (nonatomic,copy)CommonSelectionViewSelectHandler selectHandler;

@end
