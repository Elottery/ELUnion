//
//  ELTabbar.m
//  ELUIFramework
//
//  Created by 金秋成 on 16/7/16.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "ELTabbar.h"







@interface ELTabbarFlowLayout : UICollectionViewFlowLayout
@property (nonatomic,strong)NSMutableArray * attrArr;
@property (nonatomic,assign)NSInteger        numberOfCell;
@end


@implementation ELTabbarFlowLayout


-(void)prepareLayout{
    self.attrArr = [NSMutableArray new];
    self.numberOfCell = [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:0];
    self.itemSize = CGSizeMake(self.collectionView.frame.size.width/self.numberOfCell, self.collectionView.frame.size.height);
    for (NSInteger i = 0; i < self.numberOfCell; i ++) {
        UICollectionViewLayoutAttributes * attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        attr.frame = CGRectMake(self.itemSize.width * i , 0, self.itemSize.width, self.itemSize.height);
        [self.attrArr addObject:attr];
    }
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrArr;
}

-(CGSize)collectionViewContentSize{
    return self.collectionView.frame.size;
}
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}


@end




@interface ELTabbar ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)NSLayoutConstraint * lastItemTrailingConstraint;

@property (nonatomic,strong)UICollectionView   * collectionView;

@property (nonatomic,strong)ELTabbarFlowLayout * flowLayout;

@property (nonatomic,strong)NSMutableArray * itemsArr;

@end


@implementation ELTabbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _itemsArr = [NSMutableArray new];
        [self addSubview:self.collectionView];
        self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        UIView * line = [[UIView alloc]initWithFrame:CGRectZero];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        line.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:line];
        
        
        
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[LINE]-0-|" options:0 metrics:nil views:@{@"LINE":line}]];
        
        
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[COLLECION]-0-|" options:0 metrics:nil views:@{@"COLLECION":self.collectionView}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[LINE(0.5)]-0-[COLLECION]-0-|" options:0 metrics:nil views:@{@"COLLECION":self.collectionView,@"LINE":line}]];
        
        
    }
    return self;
}

- (void)addBarItem:(ELTabbarItem *)item{
    [_itemsArr addObject:item];
    [self.collectionView reloadData];
}

- (void)removeAllBarItems{
    [self.itemsArr removeAllObjects];
    [self.collectionView reloadData];
}


-(void)removeBarItemAtIndex:(NSUInteger)index{
    [self.itemsArr removeObjectAtIndex:index];
    [self.collectionView reloadData];
}




-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ELTabbarItemView * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    ELTabbarItem * item = [self.itemsArr objectAtIndex:indexPath.row];
    [cell reloadItemViewWithItem:item];
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.itemsArr.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ELTabbarItem * item = [self.itemsArr objectAtIndex:indexPath.row];
    for (ELTabbarItem * obj in self.itemsArr) {
        if (obj != item) {
            obj.selected = NO;
        }
        else{
            obj.selected = YES;
        }
    }
    
    [self.collectionView reloadData];
    
    
    
    if (item.clickHandler) {
        item.clickHandler();
    }
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[ELTabbarItemView class] forCellWithReuseIdentifier:@"cell"];
        
    }
    return _collectionView;
}
-(ELTabbarFlowLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = [[ELTabbarFlowLayout alloc]init];
    }
    return _flowLayout;
}

@end
