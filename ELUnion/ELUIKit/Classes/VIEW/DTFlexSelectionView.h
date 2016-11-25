//
//  DTFlexSelectionView.h
//  Pods
//
//  Created by 金秋成 on 2016/11/3.
//
//

#import <UIKit/UIKit.h>


@class DTFlexSelectionView;

@protocol DTFlexSelectionViewDelegate <NSObject>

-(void)flexSelectionView:(DTFlexSelectionView *)view configurCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

-(NSInteger)numberOfTitleInFlexSelectionView:(DTFlexSelectionView *)view;



@optional
-(void)flexSelectionView:(DTFlexSelectionView *)view willSwitchFromSize:(CGSize)fromSize toSize:(CGSize)toSize;

-(void)flexSelectionView:(DTFlexSelectionView *)view didSwitchToSize:(CGSize)destinationSize;

@end





@interface DTFlexSelectionView : UIView
@property (nonatomic,strong,readonly)UIButton * switchBtn;
//默认为NO
@property (nonatomic,weak)id<DTFlexSelectionViewDelegate> delegate;

//必须注册一个cell
-(void)registCellClass:(nullable Class)cellClass;

-(void)reloadData;

-(CGSize)sizeForOpen:(BOOL)open;

@end
