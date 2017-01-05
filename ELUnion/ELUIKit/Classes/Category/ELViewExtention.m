//
//  ELViewExtention.m
//  Pods
//
//  Created by 金秋成 on 2017/1/5.
//
//

#import "ELViewExtention.h"
#import "ConstantsColors.h"

@implementation ELViewExtention
{
    UIView          * managingView;
    UIView          * bottomLine;
    UIView          * topLine;
}

-(instancetype)initWithView:(UIView *)view{
    self = [super init];
    if (self) {
        managingView = view;
        
    }
    return self;
}

-(void)setBottomLine:(BOOL)hasLine{
    
    if (hasLine) {
        if (!bottomLine) {
            bottomLine = [[UIView alloc]initWithFrame:CGRectZero];
            bottomLine.translatesAutoresizingMaskIntoConstraints = NO;
            bottomLine.backgroundColor = ELColor05;
            [managingView addSubview:bottomLine];
            [managingView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[LINE]-0-|" options:0 metrics:nil views:@{@"LINE":bottomLine}]];
            [managingView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[LINE(HEIGHT)]-0-|" options:0 metrics:@{@"HEIGHT":@(1.0/[[UIScreen mainScreen] scale])} views:@{@"LINE":bottomLine}]];
        }
    }
    else{
        if (bottomLine) {
            [bottomLine removeFromSuperview];
            bottomLine = nil;
        }
    }
    
}

-(void)setTopLine:(BOOL)hasLine{
    if (hasLine) {
        if (!topLine) {
            topLine = [[UIView alloc]initWithFrame:CGRectZero];
            topLine.translatesAutoresizingMaskIntoConstraints = NO;
            topLine.backgroundColor = ELColor05;
            [managingView addSubview:topLine];
            [managingView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[LINE]-0-|" options:0 metrics:nil views:@{@"LINE":topLine}]];
            [managingView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[LINE(HEIGHT)]" options:0 metrics:@{@"HEIGHT":@(1.0/[[UIScreen mainScreen] scale])} views:@{@"LINE":topLine}]];
        }
    }
    else{
        if (topLine) {
            [topLine removeFromSuperview];
            topLine = nil;
        }
    }
}

@end
