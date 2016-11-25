//
//  ELActionSheetContainer.h
//  Elottory
//
//  Created by 金秋成 on 16/9/3.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELActionSheetContainer : UIView

@property (nonatomic,strong,readonly)UIView * subView;

-(instancetype)initWithTitle:(NSAttributedString *)title
            andSubViewHeight:(CGFloat)height
                  andSubview:(UIView *)subview
                cancelTarget:(id)target
                 andSelector:(SEL)selector;

-(void)show;

-(void)showInView:(UIView *)view;

@end
