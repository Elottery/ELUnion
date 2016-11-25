//
//  ELScrollTitleBarFlowLayout.m
//  PageViewControllerDemo
//
//  Created by Nicolas on 16/8/23.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "ELScrollTitleBarFlowLayout.h"

@interface ELScrollTitleBarFlowLayout ()
@property (nonatomic,strong)NSMutableArray * itemAttr;
//@property (nonatomic,assign)CGSize           contentSize;
@end


@implementation ELScrollTitleBarFlowLayout

-(void)prepareLayout{
    [super prepareLayout];
    self.itemAttr = [NSMutableArray new];
    NSUInteger titleCount = [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:0];
    UIEdgeInsets inset = UIEdgeInsetsZero;
    for (NSUInteger i = 0; i < titleCount; i++) {
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes * attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        NSAttributedString * title = [self.titleBarDelegate flowLayout:self titleForIndexPath:indexPath];
        CGFloat  height = self.collectionView.frame.size.height;
        CGRect titleBounds = [title boundingRectWithSize:CGSizeMake(10000, self.collectionView.frame.size.height) options:0 context:nil];
        if (self.titleBarDelegate && [self.titleBarDelegate respondsToSelector:@selector(edgeInsetForTitleAtIndex:)] ) {
            inset = [self.titleBarDelegate edgeInsetForTitleAtIndex:indexPath];
        }
        if (_itemAttr.count == 0) {
            attr.frame = CGRectMake(self.titleGap, 0, titleBounds.size.width+inset.left + inset.right, height);
        }
        else{
            UICollectionViewLayoutAttributes * lastAttr = _itemAttr.lastObject;
            attr.frame = CGRectMake(CGRectGetMaxX(lastAttr.frame)+self.titleGap, 0, titleBounds.size.width+inset.left + inset.right, height);
        }
        [_itemAttr addObject:attr];
    }
    
    
    
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes * attr = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:elementKind withIndexPath:indexPath];
    attr.zIndex = -1;
    attr.frame = CGRectMake(0, 10, 10,20);
    return attr;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.itemAttr;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    if (self.collectionView.bounds.size.width != newBounds.size.width) {
        return YES;
    }
    return NO;
}



-(CGSize)collectionViewContentSize{
    UICollectionViewLayoutAttributes * attr = self.itemAttr.lastObject;
    CGSize size = CGSizeMake(CGRectGetMaxX(attr.frame)+self.titleGap, self.collectionView.frame.size.height);
    if (self.titleBarDelegate && [self.titleBarDelegate respondsToSelector:@selector(flowLayout:didChangeContentSize:)]) {
        [self.titleBarDelegate flowLayout:self didChangeContentSize:size];
    }
    return size;
}

-(CGRect)rectForIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"(((((((((((((( %ld",indexPath.row);
    if (indexPath.row < self.itemAttr.count) {
        UICollectionViewLayoutAttributes * attr = [self.itemAttr objectAtIndex:indexPath.row];
        return attr.frame;
    }
    return CGRectZero;
}

-(CGPoint)contentOffsetForIndexPath:(NSIndexPath *)indexPath{
    
}


@end
