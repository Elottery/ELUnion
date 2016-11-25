//
//  ELGridView.m
//  Elottory
//
//  Created by 金秋成 on 16/7/25.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "ELGridView.h"
#import "ELGridViewFlowLayout.h"

@interface _ELGridViewCell : UICollectionViewCell

@property (nonatomic,assign)NSUInteger row;

@property (nonatomic,assign)NSUInteger line;

@property (nonatomic,strong)UIImageView * imageView;

@property (nonatomic,strong)UILabel * label;


@property (nonatomic,strong,readonly)ELGridViewCellItem * item;

@property (nonatomic,strong)NSLayoutConstraint * containerTop;

@property (nonatomic,strong)NSLayoutConstraint * containerBottom;

@property (nonatomic,strong)NSLayoutConstraint * containerLeading;

@property (nonatomic,strong)NSLayoutConstraint * containerTrailing;


@property (nonatomic,strong)NSLayoutConstraint * imageTop;

@property (nonatomic,strong)NSLayoutConstraint * imageBottom;

@property (nonatomic,strong)NSLayoutConstraint * imageLeading;

@property (nonatomic,strong)NSLayoutConstraint * imageTrailing;


@property (nonatomic,strong)NSLayoutConstraint * titleTop;

@property (nonatomic,strong)NSLayoutConstraint * titleBottom;

@property (nonatomic,strong)NSLayoutConstraint * titleLeading;

@property (nonatomic,strong)NSLayoutConstraint * titleTrailing;



@end


@implementation _ELGridViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        _label = [[UILabel alloc]initWithFrame:CGRectZero];
        _label.translatesAutoresizingMaskIntoConstraints = NO;
        
        UIView * contentSubview = [[UIView alloc]initWithFrame:CGRectZero];
        contentSubview.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:contentSubview];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:contentSubview attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:contentSubview attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
 
        
        
        
        
        
        [contentSubview addSubview:_imageView];
        [contentSubview addSubview:_label];
        
        
        
        
        self.imageTop = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:contentSubview attribute:NSLayoutAttributeTop multiplier:1 constant:0];
        
        self.imageBottom = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:contentSubview attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        
        self.imageLeading = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:contentSubview attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
        
        self.imageTrailing = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_label attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
        
        
        [contentSubview addConstraints:@[self.imageTop,self.imageBottom,self.imageLeading,self.imageTrailing]];
        
        
        self.titleTop = [NSLayoutConstraint constraintWithItem:_label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:contentSubview attribute:NSLayoutAttributeTop multiplier:1 constant:0];
        self.titleBottom = [NSLayoutConstraint constraintWithItem:_label attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:contentSubview attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        self.titleTrailing = [NSLayoutConstraint constraintWithItem:_label attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:contentSubview attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
        [contentSubview addConstraints:@[self.titleTop,self.titleBottom,self.titleTrailing]];
        
        
        
        
        
        
    }
    return self;
}

-(void)setupWithItem:(ELGridViewCellItem *)item{
    
    self.containerTop.constant = item.imageEdgeInset.top < item.labelEdgeInset.top ? item.imageEdgeInset.top : item.labelEdgeInset.top;
    self.containerLeading.constant = item.imageEdgeInset.left;
    self.containerTrailing.constant = -item.labelEdgeInset.right;
    self.containerBottom.constant = item.imageEdgeInset.bottom < item.labelEdgeInset.bottom ? item.imageEdgeInset.bottom : item.labelEdgeInset.bottom;

    self.imageTrailing.constant = -(item.imageEdgeInset.right > item.labelEdgeInset.left ? item.imageEdgeInset.right : item.labelEdgeInset.left);
    
    self.imageView.image = item.image;
    self.label.text = item.title;
}


@end


@interface ELGridView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UICollectionView * collectionView;

@property (nonatomic,strong)ELGridViewFlowLayout * flowLayout;

@end

@implementation ELGridView


-(instancetype)initWithNumberOfCellForEachRow:(NSUInteger)numberOfCell{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _numberOfCellForEachRow = numberOfCell;
        _items = [NSMutableArray arrayWithCapacity:1];
        [self addSubview:self.collectionView];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[collection]-0-|"
                                                                     options:0 metrics:nil
                                                                       views:@{@"collection":self.collectionView}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[collection]-0-|"
                                                                     options:0 metrics:nil
                                                                       views:@{@"collection":self.collectionView}]];
        
        
        UIView * spTopView = [[UIView alloc]initWithFrame:CGRectZero];
        spTopView.translatesAutoresizingMaskIntoConstraints = NO;
        spTopView.backgroundColor = [UIColor colorWithRed:0.784 green:0.780 blue:0.800 alpha:1.00];
        
        
        UIView * spBottomView = [[UIView alloc]initWithFrame:CGRectZero];
        spBottomView.translatesAutoresizingMaskIntoConstraints = NO;
        spBottomView.backgroundColor = [UIColor colorWithRed:0.784 green:0.780 blue:0.800 alpha:1.00];
        
        [self addSubview:spTopView];
        [self addSubview:spBottomView];
        
        
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[sptop]-0-|"
                                                                     options:0 metrics:nil
                                                                       views:@{@"sptop":spTopView}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[sptop(0.5)]"
                                                                     options:0 metrics:nil
                                                                       views:@{@"sptop":spTopView}]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[spbottom]-0-|"
                                                                     options:0 metrics:nil
                                                                       views:@{@"spbottom":spBottomView}]];

        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[spbottom(0.5)]-0-|"
                                                                     options:0 metrics:nil
                                                                       views:@{@"spbottom":spBottomView}]];
        
        
        
    }
    return self;
}

-(void)addItem:(ELGridViewCellItem *)item{
    [_items addObject:item];
}
-(void)reloadItems{
    [self.collectionView reloadData];
}
-(void)setBackgroundColor:(UIColor *)backgroundColor{
    [super setBackgroundColor:backgroundColor];
    self.collectionView.backgroundColor = backgroundColor;
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.items.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    _ELGridViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    ELGridViewCellItem * item = [self.items objectAtIndex:indexPath.row];
    cell.label.textColor = item.titleColor;
    cell.label.font      = item.titleFont;
    [cell setupWithItem:item];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ELGridViewCellItem * item = [self.items objectAtIndex:indexPath.row];
    if (item.handler) {
        item.handler();
    }
}


-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        [_collectionView registerClass:[_ELGridViewCell class] forCellWithReuseIdentifier:@"cell"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

-(ELGridViewFlowLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = [[ELGridViewFlowLayout alloc]init];
        _flowLayout.numberOfCellInSingleRow = self.numberOfCellForEachRow;
        _flowLayout.itemGap = 0.5;
        _flowLayout.sectionInset = UIEdgeInsetsZero;
        _flowLayout.footerReferenceSize = CGSizeZero;
        _flowLayout.headerReferenceSize = CGSizeZero;
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
        
    }
    return _flowLayout;
}

-(void)dealloc{
    
}


@end
