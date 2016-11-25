//
//  ELGridViewFlowLayout.h
//  Elottory
//
//  Created by 金秋成 on 16/7/28.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELGridViewFlowLayout : UICollectionViewFlowLayout
-(instancetype)initWithNumberOfInSingleRow:(NSUInteger)numberOfCellInSingleRow andItem:(CGFloat )itemGap;
@property (nonatomic,assign)NSUInteger numberOfCellInSingleRow;
@property (nonatomic,assign)CGFloat    itemGap;
@end
