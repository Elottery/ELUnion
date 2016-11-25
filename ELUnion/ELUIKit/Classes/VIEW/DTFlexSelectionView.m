//
//  DTFlexSelectionView.m
//  Pods
//
//  Created by 金秋成 on 2016/11/3.
//
//

#import "DTFlexSelectionView.h"



@interface _DTFlexSelectionViewFlowLayout : UICollectionViewFlowLayout
@property (nonatomic,assign)BOOL open;
@property (nonatomic,assign)CGFloat vItemSpace;
@property (nonatomic,assign)CGFloat hItemSpace;
@property (nonatomic,assign)NSInteger maxItemCountInSingleLine;
@property (nonatomic,assign)CGFloat   collectionSingleLineHeight;



@property (nonatomic,assign)NSInteger itemCount;
@property (nonatomic,strong)NSMutableArray * attArr;


- (CGSize)sizeForOpen:(BOOL)open;


@end

@implementation _DTFlexSelectionViewFlowLayout
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.open = NO;
        self.itemCount = 0;
        self.vItemSpace = 5;
        self.hItemSpace = 5;
        self.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        self.maxItemCountInSingleLine = 4;
        self.collectionSingleLineHeight = 44;
    }
    return self;
}
-(void)prepareLayout{
    [super prepareLayout];
    self.attArr = [NSMutableArray new];
    self.itemCount = [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:0];
    self.itemSize = CGSizeMake((self.collectionView.frame.size.width - self.sectionInset.left - self.sectionInset.right - (self.maxItemCountInSingleLine-1) * self.hItemSpace)/self.maxItemCountInSingleLine  , self.collectionSingleLineHeight - self.sectionInset.top - self.sectionInset.bottom);
    for (NSInteger i = 0; i < self.itemCount; i++) {
        UICollectionViewLayoutAttributes * attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        
        CGFloat x = self.sectionInset.left + (self.hItemSpace + self.itemSize.width) * (i%self.maxItemCountInSingleLine);
        
        CGFloat y = self.sectionInset.top + (self.vItemSpace + self.itemSize.height) * (i/self.maxItemCountInSingleLine);

        CGRect itemFrame = CGRectMake(x, y, self.itemSize.width, self.itemSize.height);
        attr.frame = itemFrame;
        [self.attArr addObject:attr];
    }
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attArr;
}

-(CGSize)collectionViewContentSize{
    return self.collectionView.frame.size;
}


- (CGSize)sizeForOpen:(BOOL)open{
    if (open) {
        CGFloat contentHeight = CGRectGetMaxY([(UICollectionViewLayoutAttributes *)self.attArr.lastObject frame])  + self.sectionInset.bottom;
        return CGSizeMake(self.collectionView.frame.size.width, contentHeight);
    }
    else{
        return CGSizeMake(self.collectionView.frame.size.width, self.collectionSingleLineHeight);
    }
}

@end

#define BTN_HEIGHT 20

@interface DTFlexSelectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic,strong)_DTFlexSelectionViewFlowLayout * flowLayout;
@property (nonatomic,assign)CGFloat minHeight;

@property (nonatomic,assign)BOOL isOpen;

@property (nonatomic,assign)BOOL isAnimationFinished;

@end

@implementation DTFlexSelectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isAnimationFinished = YES;
        self.isOpen = NO;
        self.minHeight = frame.size.height-20;
        
        
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - BTN_HEIGHT) collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self addSubview:_collectionView];
        
        
        _switchBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_collectionView.frame), frame.size.width, BTN_HEIGHT)];
        _switchBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        _switchBtn.backgroundColor = [UIColor redColor];
        [_switchBtn addTarget:self action:@selector(switchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_switchBtn];
        
        
        
        
        
        self.layer.masksToBounds = YES;
    }
    return self;
}

-(void)reloadData{
    [self.collectionView reloadData];
}


-(void)registCellClass:(nullable Class)cellClass{
    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:@"cell"];
}

- (CGSize)sizeForOpen:(BOOL)open{
    return  [self.flowLayout sizeForOpen:open];
}


-(void)switchBtnClick:(UIButton *)sender{
    
    if (self.isAnimationFinished) {
        self.isAnimationFinished = NO;
        
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(flexSelectionView:willSwitchFromSize:toSize:)]) {
            [self.delegate flexSelectionView:self willSwitchFromSize:[self sizeForOpen:self.isOpen] toSize:[self sizeForOpen:!self.isOpen]];
        }
        self.isOpen = !self.isOpen;
        
        CGSize size = [self sizeForOpen:self.isOpen];
        [UIView animateWithDuration:0.28 animations:^{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, size.height + BTN_HEIGHT) ;
           // [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            if (finished) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(flexSelectionView:didSwitchToSize:)]) {
                    [self.delegate flexSelectionView:self didSwitchToSize:[self sizeForOpen:self.isOpen]];
                }
                self.isAnimationFinished = YES;
            }
        }];
    }
    
    
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    if (self.delegate && [self.delegate respondsToSelector:@selector(flexSelectionView:configurCell:atIndexPath:)]) {
        [self.delegate flexSelectionView:self configurCell:cell atIndexPath:indexPath];
    }
    
    return cell;
}






-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.delegate && [self.delegate respondsToSelector:@selector(numberOfTitleInFlexSelectionView:)]) {
        return [self.delegate numberOfTitleInFlexSelectionView:self];
    }
    return 0;
}




//-(UICollectionView *)collectionView{
//    if (!_collectionView) {
//        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
//        _collectionView.backgroundColor = [UIColor whiteColor];
//        _collectionView.delegate = self;
//        _collectionView.dataSource = self;
//    }
//    return _collectionView;
//}

-(_DTFlexSelectionViewFlowLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = [[_DTFlexSelectionViewFlowLayout alloc]init];
    }
    _flowLayout.collectionSingleLineHeight = self.minHeight;
    return _flowLayout;
}

@end
