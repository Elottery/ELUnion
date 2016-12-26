//
//  ELProgressedImageView.h
//  Pods
//
//  Created by 金秋成 on 2016/12/26.
//
//

#import <UIKit/UIKit.h>

@interface ELProgressedImageView : UIImageView

@property (nonatomic,strong)CAShapeLayer * progressLayer;
@property (nonatomic,strong)CAShapeLayer * maskLayer;

-(void)updateProgress:(CGFloat)progress;

@end
