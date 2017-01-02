//
//  UIView+ELExtention.h
//  Elottory
//
//  Created by 金秋成 on 16/7/31.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import <UIKit/UIKit.h>




typedef NS_ENUM(NSUInteger, ELExtentsionLoadingState) {
    ELExtentsionLoadingState_prepareLoading,
    ELExtentsionLoadingState_loading,
    ELExtentsionLoadingState_finishLoading,
};

typedef NS_ENUM(NSUInteger, ELExtentsionLoadingProgressStyle) {
    ELExtentsionLoadingProgressStyle_circle,
    ELExtentsionLoadingProgressStyle_square,
};


@interface UIView (ELExtention)
@property (nonatomic,assign)CGFloat el_width;
@property (nonatomic,assign)CGFloat el_height;
@property (nonatomic,assign)CGFloat el_top;
@property (nonatomic,assign)CGFloat el_bottom;
@property (nonatomic,assign)CGFloat el_left;
@property (nonatomic,assign)CGFloat el_right;
@property (nonatomic,assign)CGFloat el_centerX;
@property (nonatomic,assign)CGFloat el_centerY;
@property (nonatomic,assign)CGSize  el_size;


@property (nonatomic,assign)BOOL bottomLine;
@property (nonatomic,assign)BOOL rightLine;
@property (nonatomic,assign)BOOL leftLine;
@property (nonatomic,assign)BOOL topLine;



#pragma -mark loading
//@property (nonatomic,assign)ELExtentsionLoadingState loadingState;
//@property (nonatomic,assign)ELExtentsionLoadingProgressStyle progressStyle;
//@property (nonatomic,strong)UIColor * borderColor;
//-(void)uploadProgress:(CGFloat)progress;


@end
