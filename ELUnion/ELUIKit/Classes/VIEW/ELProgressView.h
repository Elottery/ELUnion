//
//  ELProgressView.h
//  ProgressViewDemo
//
//  Created by 金秋成 on 16/8/28.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELProgressView : UIView

@property (nonatomic,assign)CGFloat progress;//0~1

@property (nonatomic,strong)UIColor * progressColor;

-(void)setProgress:(CGFloat)progress animated:(BOOL)animated;

@end
