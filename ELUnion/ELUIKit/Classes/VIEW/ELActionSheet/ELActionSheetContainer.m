//
//  ELActionSheetContainer.m
//  Elottory
//
//  Created by 金秋成 on 16/9/3.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "ELActionSheetContainer.h"


#define TOPVIEW_HEIGHT    30
#define BOTTOMVIEW_HEIGHT 44

@interface ELActionSheetContainer()
@property (nonatomic,assign)CGFloat  subViewHeight;
@property (nonatomic,strong)UILabel* titleLabel;
@property (nonatomic,strong)UIButton * cancelButton;
@property (nonatomic,strong)UIView * topView;
@property (nonatomic,strong)UIView * bottomView;
@property (nonatomic,assign)BOOL     isInShow;
@end


@implementation ELActionSheetContainer

-(instancetype)initWithTitle:(NSAttributedString *)title
            andSubViewHeight:(CGFloat)height
                  andSubview:(UIView *)subview
                cancelTarget:(id)target
                 andSelector:(SEL)selector{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _subView = subview;
        self.subViewHeight = height;
        self.backgroundColor = [UIColor colorWithRed:0.945 green:0.945 blue:0.945 alpha:1.00];
        self.topView = [[UIView alloc]initWithFrame:CGRectZero];
        self.bottomView = [[UIView alloc]initWithFrame:CGRectZero];
        
        self.topView.translatesAutoresizingMaskIntoConstraints    = NO;
        self.bottomView.translatesAutoresizingMaskIntoConstraints = NO;
        subview.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self addSubview:self.topView];
        [self addSubview:subview];
        [self addSubview:self.bottomView];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[TOPVIEW]-0-|" options:0 metrics:nil views:@{@"TOPVIEW":self.topView}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[MIDDLEVIEW]-0-|" options:0 metrics:nil views:@{@"MIDDLEVIEW":subview}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[BOTTOMVIEW]-0-|" options:0 metrics:nil views:@{@"BOTTOMVIEW":self.bottomView}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[TOPVIEW(top_height)]-0-[MIDDLEVIEW(height)]-10-[BOTTOMVIEW(bottom_height)]-0-|"
                                                                     options:0
                                                                     metrics:@{@"top_height":@(TOPVIEW_HEIGHT),
                                                                               @"bottom_height":@(BOTTOMVIEW_HEIGHT),
                                                                               @"height":@(height)}
                                                                       views:@{@"TOPVIEW":self.topView,
                                                                               @"BOTTOMVIEW":self.bottomView,
                                                                               @"MIDDLEVIEW":subview}]];
        
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.topView addSubview:self.titleLabel];
        
        [self.topView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[TITLE]-0-|" options:0 metrics:nil views:@{@"TITLE":self.titleLabel}]];
        [self.topView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[TITLE]-0-|" options:0 metrics:nil views:@{@"TITLE":self.titleLabel}]];
        self.titleLabel.attributedText = title;
        
        self.cancelButton = [[UIButton alloc]initWithFrame:CGRectZero];
        NSAttributedString * cancelString = [[NSAttributedString alloc]initWithString:@"取消" attributes:@{NSForegroundColorAttributeName : [UIColor redColor],NSFontAttributeName : [UIFont systemFontOfSize:14]}];
        
        
        [self.cancelButton setAttributedTitle:cancelString forState:UIControlStateNormal];
        [self.cancelButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
        [self.cancelButton addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self.bottomView addSubview:self.cancelButton];
        
        
        [self.bottomView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[CANCEL]-0-|" options:0 metrics:nil views:@{@"CANCEL":self.cancelButton}]];
        [self.bottomView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[CANCEL]-0-|" options:0 metrics:nil views:@{@"CANCEL":self.cancelButton}]];
        
        
        
    }
    return self;

}
-(void)show{
    
}

-(void)showInView:(UIView *)view{
    if (self.isInShow) {
        return;
    }
    [view addSubview:self];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[VIEW]-0-|" options:0 metrics:nil views:@{@"VIEW":self}]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[VIEW]-0-|" options:0 metrics:nil views:@{@"VIEW":self}]];
    self.isInShow = YES;
    CGFloat totalHeight = TOPVIEW_HEIGHT + BOTTOMVIEW_HEIGHT + self.subViewHeight + 10;
    self.transform = CGAffineTransformMakeTranslation(0, totalHeight);
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, 0);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)dismissAction{
    CGFloat totalHeight = TOPVIEW_HEIGHT + BOTTOMVIEW_HEIGHT + self.subViewHeight + 10;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, totalHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.isInShow = NO;
    }];
}


-(void)cancelBtnClick:(UIButton *)sender{
    [self dismissAction];
}



@end
