//
//  ELTableViewCellManager.m
//  Pods
//
//  Created by 金秋成 on 2017/1/2.
//
//

#import "ELTableViewCellManager.h"
#import "ConstantsColors.h"
@implementation ELTableViewCellManager
{
    UITableViewCell * managingCell;
    UIView          * bottomLine;
    UIView          * topLine;
}
-(instancetype)initWithCell:(UITableViewCell *)cell{
    self = [super init];
    if (self) {
        managingCell = cell;
        
    }
    return self;
}

-(void)setBottomLine:(BOOL)hasLine{
    
    if (hasLine) {
        if (!bottomLine) {
            bottomLine = [[UIView alloc]initWithFrame:CGRectZero];
            bottomLine.translatesAutoresizingMaskIntoConstraints = NO;
            bottomLine.backgroundColor = ELColor05;
            [managingCell.contentView addSubview:bottomLine];
            [managingCell addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[LINE]-0-|" options:0 metrics:nil views:@{@"LINE":bottomLine}]];
            [managingCell addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[LINE(HEIGHT)]-0-|" options:0 metrics:@{@"HEIGHT":@(1.0/[[UIScreen mainScreen] scale])} views:@{@"LINE":bottomLine}]];
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
            [managingCell.contentView addSubview:topLine];
            [managingCell addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[LINE]-0-|" options:0 metrics:nil views:@{@"LINE":topLine}]];
            [managingCell addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[LINE(HEIGHT)]" options:0 metrics:@{@"HEIGHT":@(1.0/[[UIScreen mainScreen] scale])} views:@{@"LINE":topLine}]];
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
