//
//  ELSuccessView.m
//  Pods
//
//  Created by 金秋成 on 2017/1/12.
//
//

#import "ELSuccessView.h"

@implementation ELSuccessView
{
    CAShapeLayer *layer;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        layer = [[CAShapeLayer alloc] init];
        //内部填充颜色
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.lineCap = @"round";
        layer.lineJoin = @"round";
        //线条颜色
        layer.strokeColor = [UIColor colorWithRed:0.396 green:0.396 blue:0.396 alpha:1.00].CGColor;
        [self.layer addSublayer:layer];
        
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    [self drawSuccessLine];
}


- (void)drawSuccessLine{
    layer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    switch (self.viewType) {
        case ELSuccessViewType_Success:
        {
            
            UIBezierPath *path = [UIBezierPath bezierPath];
            
            //对号第一部分直线的起始
            [path moveToPoint:CGPointMake(0, self.frame.size.height/2)];
            CGPoint p1 = CGPointMake(self.frame.size.width/8.0*3, self.frame.size.height/6.0*5);
            [path addLineToPoint:p1];
            
            //对号第二部分起始
            CGPoint p2 = CGPointMake(self.frame.size.width, self.frame.size.height/8);
            [path addLineToPoint:p2];

            
            //线条宽度
            layer.lineWidth = 4;
            layer.path = path.CGPath;
        }
            break;
        case ELSuccessViewType_Warning:
        {
            
        }
            break;
        case ELSuccessViewType_Error:
        {
            UIBezierPath *path = [UIBezierPath bezierPath];
            
            //对号第一部分直线的起始
            [path moveToPoint:CGPointMake(4, 4)];
            [path addLineToPoint:CGPointMake(self.frame.size.width-4, self.frame.size.height-4)];
            
            [path moveToPoint:CGPointMake(self.frame.size.width-4, 4)];
            [path addLineToPoint:CGPointMake(4, self.frame.size.height-4)];
            //线条宽度
            layer.lineWidth = 4;
            layer.path = path.CGPath;
        }
            break;
        default:
            break;
    }
    
    
    
}

-(void)setStrokeColor:(UIColor *)strokeColor{
    _strokeColor = strokeColor;
    layer.strokeColor = strokeColor.CGColor;
}


//intrinsicContentSize
-(CGSize)intrinsicContentSize{
    return self.frame.size;
}

@end
