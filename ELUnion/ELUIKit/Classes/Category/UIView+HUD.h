//
//  UIView+HUD.h
//  Elottory
//  如果HUD正在显示中，无需dismissHUD，直接show其他样式即可。
//  Created by 金秋成 on 16/8/20.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HUD)

-(void)showHUD:(NSString *)text;

-(void)showTipHUD:(NSString *)text;

-(void)showSuccessHUD:(NSString *)text;

-(void)showErrorHUD:(NSString *)text;

-(void)showProgressHUD:(NSString *)text;

-(void)updateProgress:(CGFloat)progress HUD:(NSString *)text;

-(void)dismissHUD;

@end
