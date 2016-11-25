//
//  ELGridViewCellItem.m
//  Elottory
//
//  Created by 金秋成 on 16/7/25.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "ELGridViewCellItem.h"

@implementation ELGridViewCellItem
+(instancetype)defaultValue{
    ELGridViewCellItem *item = [[ELGridViewCellItem alloc]init];
    item.title = @"Item Title";
    item.titleColor = [UIColor blackColor];
    return item;
}
@end
