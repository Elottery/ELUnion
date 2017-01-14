//
//  ELLoadingView.m
//  Elottory
//
//  Created by 金秋成 on 16/7/18.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "ELLoadingView.h"
//#import "ELFlexiableButton.h"
//#import "UIView+ELFlexable.h"
#import "ELBundleHelper.h"
#import "ConstantsColors.h"
#import "ELSuccessView.h"
#define Default_Font        [UIFont systemFontOfSize:14]
#define Default_Text_Color  UIColorFromRGB(0x999999)

@interface _ELLoadingViewEmptyView : UIView

@end

@implementation _ELLoadingViewEmptyView


@end


@interface _ELLoadingViewLoadingView : UIView
@property (nonatomic,strong)UIActivityIndicatorView * indicatorView;
@property (nonatomic,strong)UILabel                 * loadingLabel;
@end


@implementation _ELLoadingViewLoadingView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.loadingLabel = [[UILabel alloc]init];
        
        self.indicatorView.translatesAutoresizingMaskIntoConstraints = NO;
        self.loadingLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.indicatorView];
        [self addSubview:self.loadingLabel];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.indicatorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.indicatorView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:-10]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.loadingLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=20)-[label]-(>=20)-|" options:0 metrics:nil views:@{@"label":self.loadingLabel}]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[indicator]-10-[label]-(>=20)-|" options:0 metrics:nil views:@{@"label":self.loadingLabel,@"indicator":self.indicatorView}]];
    }
    return self;
}
@end


@interface _ELLoadingViewFailView : UIView
{
    CAShapeLayer * boardLayer;
}
@property (nonatomic,strong)ELSuccessView * failImageView;
@property (nonatomic,strong)UILabel     * failLabel;
@property (nonatomic,strong)UIButton    * failButton;
@end

@implementation _ELLoadingViewFailView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.failLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        self.failImageView = [[ELSuccessView alloc]initWithFrame:CGRectZero];
        self.failImageView.viewType = ELSuccessViewType_Error;
        self.failImageView.strokeColor = Default_Text_Color;
        self.failButton    = [UIButton buttonWithType:UIButtonTypeCustom];
        self.failButton.contentEdgeInsets = UIEdgeInsetsMake(10, 20, 10, 20);
        self.failLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.failImageView.translatesAutoresizingMaskIntoConstraints = NO;
        self.failButton.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self addSubview:self.failButton];
        [self addSubview:self.failLabel];
        [self addSubview:self.failImageView];
        
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.failLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.failLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.failButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.failImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=20)-[label]-(>=20)-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"label":self.failLabel}]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[image(40)]"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"image":self.failImageView}]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=20)-[button]-(>=20)-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"button":self.failButton}]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[image(40)]-10-[label]-20-[button]-(>=20)-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"label":self.failLabel,
                                                                               @"image":self.failImageView,
                                                                               @"button":self.failButton}]];
        
        
        [self layoutIfNeeded];
        
//        self.failButton.layer.borderColor = Default_Text_Color.CGColor;
//        self.failButton.layer.borderWidth = 1;
//        self.failButton.layer.cornerRadius = 5;
//        self.failButton.layer.masksToBounds = YES;
        
        
        boardLayer = [[CAShapeLayer alloc]init];
        boardLayer.strokeColor = Default_Text_Color.CGColor;
        boardLayer.lineWidth = 1;
        boardLayer.fillColor = [UIColor clearColor].CGColor;
        [self.failButton.layer addSublayer:boardLayer];
        
        
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    boardLayer.frame = self.failButton.bounds;
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.failButton.bounds cornerRadius:3];
    boardLayer.path = path.CGPath;
    
    
    
}


@end



@interface ELLoadingView ()
@property (nonatomic,strong)NSMutableDictionary * viewStateMapping;
@end

@implementation ELLoadingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(0xffffff);
        self.hidden = YES;
    }
    return self;
}


-(void)startLoading{
    self.hidden = NO;
    [self clearAllSubviewsFromSuperView];
    
    UIView * view = [self subviewForState:ELLoadingViewState_Loading];
    [self addSubview:view];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(loadingView:viewForState:)]) {
        if ( [self.delegate respondsToSelector:@selector(loadingView:didAddSubView:forState:)]) {
            [self.delegate loadingView:self didAddSubView:view forState:ELLoadingViewState_Loading];
        }
    }
    else{
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[VIEW]-20-|" options:0 metrics:nil views:@{@"VIEW":view}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[VIEW]-20-|" options:0 metrics:nil views:@{@"VIEW":view}]];
    }
}

-(void)stopLoading{
    self.hidden = YES;
}

-(void)didMoveToSuperview{
    [super didMoveToSuperview];
    
}

-(void)failLoading{
    self.hidden = NO;
    [self clearAllSubviewsFromSuperView];
    UIView * view = [self subviewForState:ELLoadingViewState_Fail];
    [self addSubview:view];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(loadingView:viewForState:)]) {
        if ( [self.delegate respondsToSelector:@selector(loadingView:didAddSubView:forState:)]) {
            [self.delegate loadingView:self didAddSubView:view forState:ELLoadingViewState_Fail];
        }
        
    }
    else{
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[VIEW]-20-|" options:0 metrics:nil views:@{@"VIEW":view}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[VIEW]-20-|" options:0 metrics:nil views:@{@"VIEW":view}]];
    }
    
    
}



-(void)removeSubviewForState:(ELLoadingViewState)state{
    UIView * view = [self.viewStateMapping objectForKey:@(state)];
    if (view) {
        [self.viewStateMapping removeObjectForKey:@(state)];
    }
}

-(void)addSubview:(UIView *)view forState:(ELLoadingViewState)state{
    [self removeSubviewForState:state];
    [self.viewStateMapping setObject:view forKey:@(state)];
}

//跟代理无关  只在本实例中查找
-(UIView *)subviewForState:(ELLoadingViewState)state{
    UIView * view = [self.viewStateMapping objectForKey:@(state)];
    if (!view) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadingView:viewForState:)]) {
            view = [self.delegate loadingView:self viewForState:state];
        }
        else{
            view = [self defaultViewForState:state];
        }
        [self addSubview:view forState:state];
    }
    return view;
}

-(UIView *)defaultViewForState:(ELLoadingViewState)state{
    switch (state) {
        case ELLoadingViewState_Loading:
        {
            NSAttributedString * str = nil;
            if (self.delegate && [self.delegate respondsToSelector:@selector(loadingView:titleForState:)]) {
               str = [self.delegate loadingView:self titleForState:ELLoadingViewState_Loading];
            }
            else{
                str = [[NSAttributedString alloc]initWithString:@"加载中..."
                                                     attributes:@{NSForegroundColorAttributeName : Default_Text_Color,
                                                                  NSFontAttributeName :Default_Font }];
            }
            _ELLoadingViewLoadingView * loading = [[_ELLoadingViewLoadingView alloc]initWithFrame:CGRectZero];
            loading.loadingLabel.attributedText = str;
            [loading.indicatorView startAnimating];
            loading.translatesAutoresizingMaskIntoConstraints = NO;
            return loading;
            
        }
            break;
        case ELLoadingViewState_Fail:
        {
            
            _ELLoadingViewFailView * failLoading = [[_ELLoadingViewFailView alloc]initWithFrame:CGRectZero];
            
            failLoading.translatesAutoresizingMaskIntoConstraints = NO;
            
            NSAttributedString * str = nil;
            if (self.delegate && [self.delegate respondsToSelector:@selector(loadingView:titleForState:)]) {
                str = [self.delegate loadingView:self titleForState:ELLoadingViewState_Fail];
            }
            else{
                str = [[NSAttributedString alloc]initWithString:@"加载失败"
                                                     attributes:@{NSForegroundColorAttributeName : Default_Text_Color,
                                                                  NSFontAttributeName :Default_Font }];
            }
            failLoading.failLabel.attributedText = str;
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(loadingView:failImageView:)]) {
                [self.delegate loadingView:self failImageView:failLoading.failImageView];
            }
            
            NSAttributedString * btnstr = nil;
            if (self.delegate && [self.delegate respondsToSelector:@selector(reloadButtonTitleForloadingView:)]) {
                btnstr = [self.delegate reloadButtonTitleForloadingView:self];
            }
            else{
                btnstr = [[NSAttributedString alloc]initWithString:@"重新加载" attributes:@{NSForegroundColorAttributeName : Default_Text_Color,
                                                                                                        NSFontAttributeName :Default_Font }];
            }
            [failLoading.failButton setAttributedTitle:btnstr forState:UIControlStateNormal];
            [failLoading.failButton addTarget:self action:@selector(reloadBtnClick) forControlEvents:UIControlEventTouchUpInside];
            return failLoading;
        }
            break;
        default:
            return nil;
            break;
    }
}

-(void)reloadBtnClick{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickReloadLoadingView:)]) {
        [self.delegate didClickReloadLoadingView:self];
    }
}

-(void)clearAllSubviewsFromSuperView{
    for (UIView * sv in self.viewStateMapping.allValues) {
        [sv removeFromSuperview];
    }
}

-(NSMutableDictionary *)viewStateMapping{
    if (!_viewStateMapping) {
        _viewStateMapping = [[NSMutableDictionary alloc]init];
    }
    return _viewStateMapping;
}






@end
