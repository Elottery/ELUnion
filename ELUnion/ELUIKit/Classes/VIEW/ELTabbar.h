//
//  ELTabbar.h
//  ELUIFramework
//
//  Created by 金秋成 on 16/7/16.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELTabbarItemView.h"
#import "ELTabbarItem.h"

@class ELBaseTabbarController;

@interface ELTabbar : UIView

@property (nonatomic,strong,readonly)NSMutableArray * itemViewArr;

@property (nonatomic,weak)ELBaseTabbarController * tabbarController;

- (void)addBarItem:(ELTabbarItem *)item;

- (void)removeBarItemAtIndex:(NSUInteger)index;

- (void)removeAllBarItems;

@end
