//
//  ELLoadingBase.m
//  Pods
//
//  Created by 金秋成 on 2016/11/29.
//
//

#import "ELLoadingBase.h"

@interface ELLoadingBase ()
@property (nonatomic,strong)CAShapeLayer * circleLayer;
@property (nonatomic,strong)UIActivityIndicatorView * indicatorView;
@end

@implementation ELLoadingBase
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
    self.circleLayer = [CAShapeLayer layer];
    self.circleLayer.strokeStart = 0;
    self.circleLayer.strokeEnd = 0;
    self.circleLayer.fillColor = [UIColor clearColor].CGColor;
    
    self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [self.layer addSublayer:self.circleLayer];
    [self addSubview:self.indicatorView];
    self.indicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.indicatorView
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1
                                                      constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.indicatorView
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1
                                                      constant:0]];
    
}


- (void)drawRect:(CGRect)rect {
    self.circleLayer.frame = rect;
    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:rect];
    self.circleLayer.path = path.CGPath;
    self.circleLayer.strokeColor = [UIColor blackColor].CGColor;
    self.circleLayer.lineWidth = 3;
    self.circleLayer.strokeEnd = self.progress;
}

-(void)setProgress:(CGFloat)progress{
    if (progress > 1 || progress <0) {
        return;
    }
    _progress = progress;
    [self setNeedsDisplay];
}




@end
