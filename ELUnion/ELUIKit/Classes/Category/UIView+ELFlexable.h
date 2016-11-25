//
//  UIView+ELFlexable.h
//  Elottory
//  用于AUTOLAYOUT情况下 内边距的调整。
//  比如label在不设置宽度约束的情况下 上下左右内边距为0 这里可以初始化时设置内边距
//  Created by 金秋成 on 16/7/19.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ELFlexable)

@property (nonatomic,assign)UIEdgeInsets edge;
@property (nonatomic,assign)CGFloat      conerRatio;

/**
 *  初始化
 *
 *  @param edge  上下左右的内边距
 *  @param ratio 圆角比例  取值范围0~1  没有圆为0 全圆为1
 *
 */
-(instancetype)initWithEdge:(UIEdgeInsets)edge cornerRatio:(CGFloat)ratio;


/**
 *  初始化
 *
 *  @param edge  上下左右的内边距  无圆角
 *
 */
-(instancetype)initWithEdge:(UIEdgeInsets)edge;
@end
