//
//  CommonSelectionView.m
//  BetSelectionDemo
//
//  Created by 金秋成 on 16/9/14.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "CommonSelectionView.h"
#import "CommonSelectionViewCell.h"
#import "CommonSelectionViewFlowLayout.h"
#import "ELBundleHelper.h"
@interface CommonSelectionView ()<UICollectionViewDataSource,UICollectionViewDelegate,CommonSelectionViewFlowLayoutDelegate>
@property (nonatomic,strong)NSArray<id<SelectionViewModelProtocol>> * viewModels;
@property (nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic,strong)CommonSelectionViewFlowLayout * selectionViewLayout;
@end


@implementation CommonSelectionView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

#pragma mark -init
-(void)commonInit{
    [self addSubview:self.collectionView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[collection]-0-|" options:0 metrics:nil views:@{@"collection":self.collectionView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[collection]-0-|" options:0 metrics:nil views:@{@"collection":self.collectionView}]];
}
#pragma mark -method
-(void)reloadData{
    if (self.delegate && [self.delegate respondsToSelector:@selector(viewModelsOfSelectionView:)]) {
        self.viewModels = [self.delegate viewModelsOfSelectionView:self];
        [self.collectionView reloadData];
    }
}


#pragma mark -flowlayout delegate
-(NSInteger)cellCountInSingleRow{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cellCountInSingleRowInSelectionView:)]) {
        return [self.delegate cellCountInSingleRowInSelectionView:self];
    }
    return 0;
}

-(NSInteger)cellCountInSingleLie{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cellCountInSingleLieInSelectionView:)]) {
        return  [self.delegate cellCountInSingleLieInSelectionView:self];
    }
    return 0;
}
-(NSArray<id<SelectionViewModelProtocol>> *)viewModelsOfFlowLayout{
    return  self.viewModels;
}




#pragma mark -collectionView delegate
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CommonSelectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    id<SelectionViewModelProtocol> model = self.viewModels[indexPath.row];
    [cell bindViewModel:model];
    return cell;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.viewModels.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    id<SelectionViewModelProtocol> model = self.viewModels[indexPath.row];
    if (model.enable) {
        model.selected = !model.selected;
        [collectionView reloadData];
        if (model.selectHandler) {
            model.selectHandler(model,indexPath.row);
        }
        else{
            if (self.delegate &&
                [self.delegate respondsToSelector:@selector(commonSelectionView:didSelectItemAtIndex:andViewModel:)]) {
                [self.delegate commonSelectionView:self didSelectItemAtIndex:indexPath.row andViewModel:model];
            }
        }
    }
}

#pragma mark -getter
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.selectionViewLayout];
        _collectionView.backgroundColor = [UIColor colorWithRed:0.894 green:0.894 blue:0.894 alpha:1.00];
        [_collectionView registerNib:[ELBundleHelper el_nibNamed:@"CommonSelectionViewCell"] forCellWithReuseIdentifier:@"cell"];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

-(CommonSelectionViewFlowLayout *)selectionViewLayout{
    if (!_selectionViewLayout) {
        _selectionViewLayout = [[CommonSelectionViewFlowLayout alloc]init];
        _selectionViewLayout.delegate = self;
    }
    return _selectionViewLayout;
}


@end
