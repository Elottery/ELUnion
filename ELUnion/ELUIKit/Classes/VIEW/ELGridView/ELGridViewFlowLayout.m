//
//  ELGridViewFlowLayout.m
//  Elottory
//
//  Created by 金秋成 on 16/7/28.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "ELGridViewFlowLayout.h"

@implementation ELGridViewFlowLayout
{
    NSMutableArray * _attrArr;
    NSUInteger _itemNumber;
    NSUInteger _rowCount;
    CGFloat _itemWith;
    CGFloat _itemHeight;
    
}
-(instancetype)initWithNumberOfInSingleRow:(NSUInteger)numberOfCellInSingleRow andItem:(CGFloat)itemGap{
    self = [super init];
    if (self) {
        _attrArr = [NSMutableArray new];
        _numberOfCellInSingleRow = numberOfCellInSingleRow;
        _itemGap = itemGap;
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _attrArr = [NSMutableArray new];
    }
    return self;
}

-(void)prepareLayout{
    [super prepareLayout];
    _itemNumber = [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:0];
    
    _rowCount = _itemNumber%self.numberOfCellInSingleRow > 0 ? (_itemNumber/self.numberOfCellInSingleRow + 1) : (_itemNumber/self.numberOfCellInSingleRow);
    
    _itemWith   = (self.collectionView.bounds.size.width - ((self.numberOfCellInSingleRow-1) * self.itemGap))  / self.numberOfCellInSingleRow;
    
    _itemHeight = (self.collectionView.bounds.size.height - ((_rowCount-1)*self.itemGap)) / _rowCount;
    
    
    for (NSInteger i = 0; i < _itemNumber; i++) {
        UICollectionViewLayoutAttributes * attr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [_attrArr addObject:attr];
    }
    
}
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes * attr = [super layoutAttributesForItemAtIndexPath:indexPath];
    NSInteger i = indexPath.row;
    attr.frame = CGRectMake((_itemWith + self.itemGap) * (i%self.numberOfCellInSingleRow),
                            (_itemHeight + self.itemGap)*(i/self.numberOfCellInSingleRow) ,
                            _itemWith,
                            _itemHeight);

    return attr;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return _attrArr;
}
- (CGSize)collectionViewContentSize
{
    self.collectionView.contentInset = UIEdgeInsetsZero;
    return self.collectionView.bounds.size;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}
@end
