//
//  ELTabbarItemView.h
//  Elottory
//
//  Created by 金秋成 on 16/7/17.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELTabbarItem.h"
@interface ELTabbarItemView : UICollectionViewCell
/**
 *  标题
 */
@property (nonatomic,strong,readonly)UILabel     * titleLabel;

/**
 *  图标
 */
@property (nonatomic,strong,readonly)UIImageView * imageView;

/**
 *  点
 */
@property (nonatomic,strong,readonly)UILabel     * badgeView;

@property (nonatomic,strong,readonly)ELTabbarItem * item;

-(void)reloadItemViewWithItem:(ELTabbarItem *)item;

@end
