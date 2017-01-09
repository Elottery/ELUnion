//
//  ELScrollTitleBar.m
//  PageViewControllerDemo
//
//  Created by Nicolas on 16/8/23.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "ELScrollTitleBar.h"
#import "ELScrollTitleBarFlowLayout.h"
#import "ELScrollTitleCell.h"
#import "ConstantsColors.h"
#import "ELBundleHelper.h"
@interface ELScrollTitleBar ()<UICollectionViewDelegate,UICollectionViewDataSource,ELScrollTitleBarFlowLayoutDelegate>

@property (nonatomic,strong)UICollectionView * frontCollectionView;
@property (nonatomic,strong)UIScrollView     * scrollView;
@property (nonatomic,strong)ELScrollTitleBarFlowLayout * frontCollectionViewFlowlayout;
@property (nonatomic,assign)NSInteger   currentIndex;
@property (nonatomic,strong)NSMutableArray * selectinRecordArr;

@property (nonatomic,assign)NSInteger   titleCount;

@end


@implementation ELScrollTitleBar





- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
        
        
        
        
        
        
        
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
//        [self commonInit];
    }
    return self;
}


-(void)commonInit{
    self.frontCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.frontCollectionView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[front]-0-|" options:0 metrics:nil views:@{@"front":self.frontCollectionView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[front]-3-|" options:0 metrics:nil views:@{@"front":self.frontCollectionView}]];
    
    UIView * seperatorView = [[UIView alloc]initWithFrame:CGRectZero];
    seperatorView.translatesAutoresizingMaskIntoConstraints = NO;
    seperatorView.backgroundColor = ELColor05;
    [self addSubview:seperatorView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[sv]-0-|" options:0 metrics:nil views:@{@"sv":seperatorView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[sv(0.5)]-0-|" options:0 metrics:nil views:@{@"sv":seperatorView}]];
    
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.scrollView];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[CURSOR]-0-|" options:0 metrics:nil views:@{@"CURSOR":self.scrollView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[CURSOR(3)]-0.5-|" options:0 metrics:nil views:@{@"CURSOR":self.scrollView}]];
}



-(void)setSelectedIndex:(NSInteger)selectedIndex{
    [self setSelectedIndex:selectedIndex animated:NO];
}


-(void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated{
    
    [self.frontCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0 ] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:animated];
    
    ELScrollTitleCell * cell = [self.frontCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0]];
    cell.titleLabel.attributedText = [self.datasource scrollTitleBar:self titleForIndex:_selectedIndex];
    
    _selectedIndex = selectedIndex;
    
    cell = [self.frontCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0]];
    cell.titleLabel.attributedText = [self.datasource scrollTitleBar:self selectedTitleForIndex:_selectedIndex];
    [self setCursorAtIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0] animated:animated];
    
//    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollTitleBar:didSelectIndex:)]) {
//        [self.delegate scrollTitleBar:self didSelectIndex:selectedIndex];
//    }
}


-(void)reloadCursor{
    
    [self setCursorAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:0] animated:NO];
}


-(void)setCursorAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated{
    
    if (self.titleCount > 0 && indexPath.row < self.titleCount ) {
        self.cursourView.hidden = NO;
        CGRect rect =  [self.frontCollectionViewFlowlayout rectForIndexPath:indexPath];
        
        if (animated) {
            [UIView animateWithDuration:0.28 animations:^{
                self.cursourView.frame = CGRectMake(rect.origin.x, 0, rect.size.width, 3);
            }];
        }
        else{
            self.cursourView.frame = CGRectMake(rect.origin.x, 0, rect.size.width, 3);
        }
    }
    else{
        self.cursourView.hidden = YES;
    }
    
    
}


-(void)reloadData{
    self.titleCount = [self.datasource numberOfTitleScrollTitleBar:self];
    [self.frontCollectionView reloadData];
    [self reloadCursor];
}

-(void)updateContentOffsetX:(CGFloat)x{
    
}

-(void)endUpdateContentOffset{
    
}

#pragma mark -flowlayoutdelegate
-(NSAttributedString *)flowLayout:(ELScrollTitleBarFlowLayout *)layout titleForIndexPath:(NSIndexPath *)indexPath{
    return  [self.datasource scrollTitleBar:self titleForIndex:indexPath.row];
}


-(UIEdgeInsets)edgeInsetForTitleAtIndex:(NSIndexPath *)indexPath{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

-(void)flowLayout:(ELScrollTitleBarFlowLayout *)layout didChangeContentSize:(CGSize)size{
    self.scrollView.contentSize = CGSizeMake(size.width, 3);
    [self reloadCursor];
}

#pragma mark -collectionviewdatasource

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ELScrollTitleCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row == self.selectedIndex) {
        cell.titleLabel.attributedText = [self.datasource scrollTitleBar:self selectedTitleForIndex:indexPath.row];
    }
    else{
        cell.titleLabel.attributedText = [self.datasource scrollTitleBar:self titleForIndex:indexPath.row];
    }
    
    return cell;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.titleCount;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}



#pragma mark -collectionviewdelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self setSelectedIndex:indexPath.row animated:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollTitleBar:didSelectIndex:)]) {
        [self.delegate scrollTitleBar:self didSelectIndex:indexPath.row];
    }
    
    
}








-(void)setCursourBackgroundColor:(UIColor *)cursourBackgroundColor{
//    self.frontCollectionView.backgroundColor = cursourBackgroundColor;
    self.cursourView.backgroundColor = cursourBackgroundColor;
}
-(UIColor *)cursourBackgroundColor{
    return self.cursourView.backgroundColor;
}

#pragma mark -scrollview
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.frontCollectionView) {
        self.scrollView.contentOffset = self.frontCollectionView.contentOffset;
    }
}


-(UICollectionView *)frontCollectionView{
    if (!_frontCollectionView) {
        _frontCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.frontCollectionViewFlowlayout];
        _frontCollectionView.backgroundColor = [UIColor whiteColor];
        _frontCollectionView.showsVerticalScrollIndicator = NO;
        _frontCollectionView.showsHorizontalScrollIndicator = NO;
        [_frontCollectionView registerNib:[ELBundleHelper el_nibNamed:@"ELScrollTitleCell"] forCellWithReuseIdentifier:@"cell"];

        _frontCollectionView.delegate = self;
        _frontCollectionView.dataSource = self;
    }
    return _frontCollectionView;
}

-(ELScrollTitleBarFlowLayout *)frontCollectionViewFlowlayout{
    if (!_frontCollectionViewFlowlayout) {
        _frontCollectionViewFlowlayout = [[ELScrollTitleBarFlowLayout alloc]init];
        _frontCollectionViewFlowlayout.titleBarDelegate = self;
        _frontCollectionViewFlowlayout.titleGap = 10;
    }
    return _frontCollectionViewFlowlayout;
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
        _scrollView.delegate = self;
        _scrollView.scrollEnabled = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [_scrollView addSubview:self.cursourView];
    }
    return _scrollView;
}
-(UIView *)cursourView{
    if (!_cursourView) {
        _cursourView = [[UIView alloc]initWithFrame:CGRectZero];
        _cursourView.backgroundColor = [UIColor blackColor];
    }
    return _cursourView;
}


@end
