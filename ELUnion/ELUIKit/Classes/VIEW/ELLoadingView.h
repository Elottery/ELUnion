//
//  ELLoadingView.h
//  Elottory
//
//  Created by 金秋成 on 16/7/18.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, ELLoadingViewState) {
    ELLoadingViewState_Loading,
    ELLoadingViewState_Fail,
    ELLoadingViewState_Empty,
};


@class ELLoadingView;


@protocol ELLoadingViewIndicatorActivityProtocol <NSObject>

- (void)startAnimating;

- (void)stopAnimating;

@end


@protocol ELLoadingViewDelegate <NSObject>

@optional


//Default ELLoadingViewState_Loading ： @“加载中”    ELLoadingViewState_Fail ： @“加载失败”
- (NSAttributedString *)loadingView:(ELLoadingView *)loadingView titleForState:(ELLoadingViewState)state;

//默认：“重新加载”
- (NSAttributedString *)reloadButtonTitleForloadingView:(ELLoadingView *)loadingView;

//有默认图片
- (void)loadingView:(ELLoadingView *)loadingView failImageView:(UIImageView *)imageView;

- (void)didClickReloadLoadingView:(ELLoadingView *)loadingView;





#pragma -mark 以下优先级为最高  如果一下代理方法实现  上述的所有代理方法将不生效
//水平垂直 居中显示
- (UIView *)loadingView:(ELLoadingView *)loadingView viewForState:(ELLoadingViewState)state;

//subview添加到loadingview之后的回调，可以做一些自动布局的处理
- (void)loadingView:(ELLoadingView *)loadingView didAddSubView:(UIView *)subview forState:(ELLoadingViewState)state;
@end


@interface ELLoadingView : UIView

@property (nonatomic,assign,readonly)ELLoadingViewState loadingViewState;

@property (nonatomic,weak) id<ELLoadingViewDelegate>delegate;

-(void)startLoading;

-(void)stopLoading;

-(void)failLoading;

@end
