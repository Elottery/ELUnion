//
//  ELNavigationBar.h
//  ELUIFramework
//
//  Created by 金秋成 on 16/7/16.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ELNavigationBar_BackBtn_type) {
    ELNavigationBar_BackBtn_type_NONE,
    ELNavigationBar_BackBtn_type_CROSS,
    ELNavigationBar_BackBtn_type_ARROW,
};


@interface ELNavigationBar : UIView

@property (nonatomic,strong,readonly) UIButton * backBtn;

@property (nonatomic,strong,readonly) UILabel  * titleLabel;

@property (nonatomic,strong,readonly) UIView   * titleView;

@property (nonatomic,assign) ELNavigationBar_BackBtn_type backBtnType;

@end
