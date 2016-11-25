//
//  CommonSelectionViewFlowLayout.m
//  BetSelectionDemo
//
//  Created by 金秋成 on 16/9/14.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "CommonSelectionViewFlowLayout.h"

@interface CommonSelectionViewFlowLayout ()
@property (nonatomic,assign)CGFloat hSpace;
@property (nonatomic,assign)CGFloat vSpace;
@property (nonatomic,assign)NSInteger cellCountInSingleRow;//一行里包含的cell的数量
@property (nonatomic,assign)NSInteger cellCountInSingleLie;//一列里包含的cell的数量

@property (nonatomic,strong)NSMutableArray * attrArr;

@end


@implementation CommonSelectionViewFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hSpace = 0.5;
        self.vSpace = 0.5;
        
    }
    return self;
}

-(void)prepareLayout{
    [super prepareLayout];
    self.attrArr = [NSMutableArray new];
    //计算itemsize
    self.cellCountInSingleRow = [self.delegate cellCountInSingleRow];
    self.cellCountInSingleLie = [self.delegate cellCountInSingleLie];
    
    CGFloat itemWidth  = (self.collectionView.frame.size.width - self.hSpace * (self.cellCountInSingleRow+1))/self.cellCountInSingleRow;
    CGFloat itemHeight = (self.collectionView.frame.size.height - self.vSpace * (self.cellCountInSingleLie+1))/self.cellCountInSingleLie;
    self.itemSize = CGSizeMake(itemWidth, itemHeight);
    
    NSArray * viewModelArr = [self.delegate viewModelsOfFlowLayout];

    
    NSInteger currentHCellCount = 0;
    for (NSInteger i = 0; i < viewModelArr.count; i++) {
        id<SelectionViewModelProtocol> vm = viewModelArr[i];
        UICollectionViewLayoutAttributes * lastAttr = self.attrArr.lastObject;
        
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat w = 0;
        CGFloat h = 0;
        
        
        if (!lastAttr) {
            x = self.hSpace;
            currentHCellCount = vm.cellSpan;
            y = self.vSpace;
        }
        else{
            
            if (currentHCellCount >= self.cellCountInSingleRow) {
                x = self.hSpace ;
                currentHCellCount = vm.cellSpan;
                y = CGRectGetMaxY(lastAttr.frame) + self.vSpace;
                
            }
            else{
                x= CGRectGetMaxX(lastAttr.frame)+self.hSpace;
                currentHCellCount += vm.cellSpan;
                y = CGRectGetMinY(lastAttr.frame);
            }
        }
        
        
        
        
        w = self.itemSize.width * vm.cellSpan + self.hSpace * (vm.cellSpan -1);
        h = self.itemSize.height;
        
        CGRect rect = CGRectMake(x, y, w, h);
        
        UICollectionViewLayoutAttributes * newAttr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        newAttr.frame = rect;
        [self.attrArr addObject:newAttr];
        
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
