//
//  ELScrollTitleBarFlowLayout.h
//  PageViewControllerDemo
//
//  Created by Nicolas on 16/8/23.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ELScrollTitleBarFlowLayout;

@protocol ELScrollTitleBarFlowLayoutDelegate <NSObject>

-(NSAttributedString *)flowLayout:(ELScrollTitleBarFlowLayout *)layout titleForIndexPath:(NSIndexPath *)indexPath;

-(void)flowLayout:(ELScrollTitleBarFlowLayout *)layout didChangeContentSize:(CGSize)size;

@optional

-(UIEdgeInsets)edgeInsetForTitleAtIndex:(NSIndexPath *)indexPath;

@end


@interface ELScrollTitleBarFlowLayout : UICollectionViewLayout
@property (nonatomic,assign)CGFloat titleGap;

@property (nonatomic,weak)id<ELScrollTitleBarFlowLayoutDelegate> titleBarDelegate;

-(CGRect)rectForIndexPath:(NSIndexPath *)indexPath;

-(CGPoint)contentOffsetForIndexPath:(NSIndexPath *)indexPath;

@end
