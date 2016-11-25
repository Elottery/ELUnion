//
//  ELGridView.h
//  Elottory
//
//  Created by 金秋成 on 16/7/25.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELGridViewCellItem.h"
@interface ELGridView : UIView
/**
 *  初始化
 *
 *  @param numberOfCell 一行包含的列数
 *
 *  @return self
 */
-(instancetype)initWithNumberOfCellForEachRow:(NSUInteger)numberOfCell;
@property (nonatomic,assign,readonly)NSUInteger   numberOfCellForEachRow;
@property (nonatomic,strong,readonly)NSMutableArray<ELGridViewCellItem *> * items;
/**
 *  添加item之后调用此方法
 */
-(void)reloadItems;



@end
