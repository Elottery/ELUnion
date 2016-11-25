//
//  ELTabbarItem.h
//  Elottory
//
//  Created by 金秋成 on 16/7/17.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ELTabbarItemBadgeType) {
    ELTabbarItemBadgeType_DOT,
    ELTabbarItemBadgeType_NUMBER,
    ELTabbarItemBadgeType_NONE,
};


typedef void(^ELTabbarItemClick)();

@interface ELTabbarItem : NSObject

@property (nonatomic,strong)NSString * title;
@property (nonatomic,strong)UIFont   * titleFont;

@property (nonatomic,strong)UIColor  * titleColor;
@property (nonatomic,strong)UIColor  * selectedTitleColor;


@property (nonatomic,strong)UIImage  * image;   //优先级低
@property (nonatomic,strong)NSURL    * imageUrl;//优先级高

@property (nonatomic,strong)UIImage  * selectedImage;   //优先级低
@property (nonatomic,strong)NSURL    * selectedImageUrl;//优先级高


@property (nonatomic,assign)ELTabbarItemBadgeType   itemBadgeType;
@property (nonatomic,assign)NSInteger               badgeNumber;
@property (nonatomic,strong)UIColor               * badgeBackgroundColor;

@property (nonatomic,copy)ELTabbarItemClick          clickHandler;

@property (nonatomic,assign)BOOL selected;


+(instancetype)defautItem;

@end



@interface UIViewController (ELTabbarItem)

@property (nonatomic,strong)ELTabbarItem * tabbarItem;

@end
