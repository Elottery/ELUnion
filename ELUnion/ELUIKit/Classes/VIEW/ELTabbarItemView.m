//
//  ELTabbarItemView.m
//  Elottory
//
//  Created by 金秋成 on 16/7/17.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "ELTabbarItemView.h"

@implementation ELTabbarItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[TITLE_LABEL]-0-|" options:0 metrics:nil views:@{@"TITLE_LABEL":_titleLabel}]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:-5]];
        
       
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_imageView];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_titleLabel attribute:NSLayoutAttributeTop multiplier:1 constant:-10]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_imageView attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:5]];
        
        
        
        _badgeView = [[UILabel alloc]initWithFrame:CGRectZero];
        _badgeView.backgroundColor = [UIColor greenColor];
        _badgeView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_badgeView];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_badgeView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_imageView attribute:NSLayoutAttributeTrailing multiplier:1 constant:5]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_badgeView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_imageView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_badgeView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:5]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_badgeView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:5]];
        
    }
    return self;
}

-(void)reloadItemViewWithItem:(ELTabbarItem *)item{
    _item = item;
    self.titleLabel.text      = item.title;
    self.titleLabel.font      = item.titleFont;
    self.titleLabel.textColor = item.titleColor;
    if (item.itemBadgeType == ELTabbarItemBadgeType_DOT) {
        self.badgeView.hidden = NO;
        self.badgeView.backgroundColor = item.badgeBackgroundColor;
        
    }
    else if(item.itemBadgeType == ELTabbarItemBadgeType_NUMBER){
        self.badgeView.hidden = NO;
        self.badgeView.backgroundColor = item.badgeBackgroundColor;
        
    }
    else if(item.itemBadgeType == ELTabbarItemBadgeType_NONE){
        self.badgeView.hidden = YES;
    }
    
    
    
    if (item.imageUrl) {
        
    }
    else{
        self.imageView.image       = item.image;
    }
    self.selected = item.selected;
}

-(void)setSelected:(BOOL)selected{
    
    if (selected) {
        if (_item.selectedImageUrl) {
            
        }
        else{
            self.imageView.image = _item.selectedImage;
        }
        
        self.titleLabel.textColor = _item.selectedTitleColor;
        
        
    }
    else{
        if (_item.imageUrl) {
            
        }
        else{
            self.imageView.image       = _item.image;
        }
        self.titleLabel.textColor = _item.titleColor;
    }
    [super setSelected:selected];
}



@end
