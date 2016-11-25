//
//  ELProgressView.m
//  ProgressViewDemo
//
//  Created by 金秋成 on 16/8/28.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "ELProgressView.h"

@implementation ELProgressView
{
    UIView * _progressView;
    CGFloat  _totalWidth;
    CGFloat  _totalProgressAnimationInterval;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(void)commonInit{
    _progressColor = [UIColor redColor];
    _totalProgressAnimationInterval = 2.0;
    _progressView = [[UIView alloc]init];
    _progressView.backgroundColor = _progressColor;
    [self addSubview:_progressView];
}

-(void)setProgressColor:(UIColor *)progressColor{
    _progressColor = progressColor;
    _progressView.backgroundColor = progressColor;
    

}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect rect = _progressView.frame;
    rect.size.height = self.bounds.size.height;
    rect.size.width  = self.bounds.size.width * _progress;
    _progressView.frame = rect;
}



-(void)setProgress:(CGFloat)progress{
    [self setProgress:progress animated:NO];
    
}

-(void)setProgress:(CGFloat)progress animated:(BOOL)animated{
    [self layoutIfNeeded];
    _progress = progress;
    CGFloat timeInterval      = _totalProgressAnimationInterval * progress;
    if (animated) {
        [UIView animateWithDuration:timeInterval
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             _progressView.frame = CGRectMake(0, 0, self.frame.size.width*progress, self.frame.size.height);
        } completion:^(BOOL finished) {
            
        }];
    }
    else{
        _progressView.frame = CGRectMake(0, 0, self.frame.size.width*progress, self.frame.size.height);
    }
    
    
}

@end
