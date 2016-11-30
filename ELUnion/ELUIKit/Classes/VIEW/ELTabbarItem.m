//
//  ELTabbarItem.m
//  Elottory
//
//  Created by 金秋成 on 16/7/17.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "ELTabbarItem.h"
#import <objc/runtime.h>
@implementation ELTabbarItem
+(instancetype)defautItem{
    ELTabbarItem * item = [[self alloc]init];
    item.title = @"item";
    item.titleFont = [UIFont systemFontOfSize:11];
    item.titleColor= [UIColor colorWithRed:0.396 green:0.396 blue:0.396 alpha:1.00];
    item.selectedTitleColor = [UIColor colorWithRed:0.910 green:0.129 blue:0.094 alpha:1.00];
    item.badgeBackgroundColor = [UIColor colorWithRed:0.910 green:0.129 blue:0.094 alpha:1.00];
    item.itemBadgeType = ELTabbarItemBadgeType_NONE;
    return item;
}
@end



@implementation UIViewController (ELTabbarItem)

-(void)setTabbarItem:(ELTabbarItem *)tabbarItem{
    objc_setAssociatedObject(self, @selector(tabbarItem), tabbarItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(ELTabbarItem *)tabbarItem{
    return objc_getAssociatedObject(self, _cmd);
}

@end
