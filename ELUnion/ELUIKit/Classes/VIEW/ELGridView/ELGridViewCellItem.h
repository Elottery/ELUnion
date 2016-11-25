//
//  ELGridViewCellItem.h
//  Elottory
//
//  Created by 金秋成 on 16/7/25.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ELGridViewCellItemHandler)();

@interface ELGridViewCellItem : NSObject

@property (nonatomic,assign)UIEdgeInsets imageEdgeInset;

@property (nonatomic,assign)UIEdgeInsets labelEdgeInset;

@property (nonatomic,strong)UIImage     * image;

@property (nonatomic,strong)NSString    * title;

@property (nonatomic,strong)UIColor     * titleColor;

@property (nonatomic,strong)UIFont      * titleFont;

@property (nonatomic,copy)  ELGridViewCellItemHandler  handler;

+(instancetype)defaultValue;

@end
