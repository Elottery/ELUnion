//
//  ELProgressedImageView.m
//  Pods
//
//  Created by 金秋成 on 2016/12/26.
//
//

#import "ELProgressedImageView.h"
@implementation ELProgressedImageView
{
    CGFloat _progress;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.progressLayer.frame = self.bounds;
    self.maskLayer.frame = self.bounds;
    
    
    
    
    
    UIBezierPath * circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)/2) radius:CGRectGetWidth(self.bounds)/2-1.5 startAngle:-M_PI_2 endAngle:M_PI_2*3 clockwise:YES];
    self.progressLayer.path = circlePath.CGPath;
    
    UIBezierPath * maskPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)/2) radius:CGRectGetWidth(self.bounds)/2 startAngle:-M_PI_2 endAngle:M_PI_2*3 clockwise:YES];
    
    
    self.maskLayer.path = maskPath.CGPath;
    self.progressLayer.strokeStart = 0;
    self.progressLayer.strokeEnd   = _progress;
    
    
    
    
    
}

-(void)commonInit{
    _progress = 0;
    self.progressLayer = [[CAShapeLayer alloc]init];
    self.progressLayer.fillColor = [UIColor clearColor].CGColor;
    self.progressLayer.strokeColor = [UIColor whiteColor].CGColor;
    self.progressLayer.lineWidth = 3;
    self.progressLayer.lineCap = @"round";
    self.maskLayer     = [[CAShapeLayer alloc]init];
    [self.layer addSublayer:self.progressLayer];
    self.layer.mask = self.maskLayer;
}
-(void)updateProgress:(CGFloat)progress{
    _progress = progress;
    self.progressLayer.strokeStart = 0;
    self.progressLayer.strokeEnd   = progress;
    
}

@end
