//
//  ELNavigationBar.m
//  ELUIFramework
//
//  Created by 金秋成 on 16/7/16.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "ELNavigationBar.h"
#import "ELBundleHelper.h"


@implementation ELNavigationBar
{
    UILabel * _titleLabel;
    UIView  * _titleView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _backBtn = [[UIButton alloc]initWithFrame:CGRectZero];
        _backBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_backBtn];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_backBtn attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:-10]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_backBtn attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:10]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_backBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:25]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_backBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:25]];
    }
    return self;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_titleLabel];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:-10]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    }
    return _titleLabel;
}

-(UIView *)titleView{
    if (!_titleView) {
        _titleView = [[UIView alloc]initWithFrame:CGRectZero];
        _titleView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_titleView];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:-10]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    }
    return _titleView;
}


-(void)setBackBtnType:(ELNavigationBar_BackBtn_type)backBtnType{
    _backBtnType = backBtnType;
    switch (backBtnType) {
        case ELNavigationBar_BackBtn_type_NONE:
            _backBtn.hidden = YES;
            break;
        case ELNavigationBar_BackBtn_type_CROSS:
            _backBtn.hidden = NO;
            [_backBtn setImage:[ELBundleHelper el_imageNamed:@"Close-white"] forState:UIControlStateNormal];
            [_backBtn setImage:[ELBundleHelper el_imageNamed:@"Close-white"] forState:UIControlStateHighlighted];
            break;
        case ELNavigationBar_BackBtn_type_ARROW:
            _backBtn.hidden = NO;
            [_backBtn setImage:[ELBundleHelper el_imageNamed:@"Arrow-left-white@2x"] forState:UIControlStateNormal];
            [_backBtn setImage:[ELBundleHelper el_imageNamed:@"Arrow-left-white@2x"] forState:UIControlStateHighlighted];
            break;
        default:
            break;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
