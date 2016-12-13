//
//  UIView+HUD.m
//  Elottory
//
//  Created by 金秋成 on 16/8/20.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "UIView+HUD.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>
#import "ConstantsColors.h"
@implementation UIView (HUD)

-(MBProgressHUD *)HUD{
    MBProgressHUD * hud = objc_getAssociatedObject(self, _cmd);
    if (!hud) {
        hud =  [[MBProgressHUD alloc]initWithView:self];
        hud.removeFromSuperViewOnHide = NO;
        [self addSubview:hud];
        
        objc_setAssociatedObject(self, @selector(HUD), hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return  hud;
}

-(void)setHUD:(MBProgressHUD *)hud{
    objc_setAssociatedObject(self, @selector(HUD), hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



-(void)showHUD:(NSString *)text{
    [self.HUD showAnimated:YES];
    self.HUD.mode = MBProgressHUDModeIndeterminate;
    self.HUD.label.text = text;
    self.HUD.label.font = ELTextSize04;
}

-(void)showTipHUD:(NSString *)text{
    [self.HUD showAnimated:YES];
    self.HUD.mode = MBProgressHUDModeText;
    self.HUD.label.text = text;
    self.HUD.label.numberOfLines = 0;
    self.HUD.label.font = ELTextSize04;
    [self.HUD hideAnimated:YES afterDelay:2];
}

-(void)showSuccessHUD:(NSString *)text{
    [self.HUD showAnimated:YES];
    self.HUD.mode = MBProgressHUDModeCustomView;
    self.HUD.label.text = text;
    self.HUD.label.font = ELTextSize04;
    [self.HUD hideAnimated:YES afterDelay:2];
}

-(void)showErrorHUD:(NSString *)text{
    [self.HUD showAnimated:YES];
    self.HUD.mode = MBProgressHUDModeCustomView;
    self.HUD.label.text = text;
    self.HUD.label.font = ELTextSize04;
    [self.HUD hideAnimated:YES afterDelay:2];
}

-(void)showProgressHUD:(NSString *)text{
    [self.HUD showAnimated:YES];
    self.HUD.mode = MBProgressHUDModeAnnularDeterminate;
    self.HUD.label.text = text;
    self.HUD.label.font = ELTextSize04;
    
}

-(void)updateProgress:(CGFloat)progress HUD:(NSString *)text{
    [self.HUD showAnimated:YES];
    self.HUD.mode = MBProgressHUDModeAnnularDeterminate;
    self.HUD.label.text = text;
    self.HUD.label.font = ELTextSize04;
    self.HUD.progress = progress;
}

-(void)dismissHUD:(BOOL)animated{
    MBProgressHUD * beforeHUD = [self HUD];
    if (beforeHUD) {
        [beforeHUD hideAnimated:animated];
    }
}

-(void)dismissHUD{
    [self dismissHUD:YES];
}
@end
