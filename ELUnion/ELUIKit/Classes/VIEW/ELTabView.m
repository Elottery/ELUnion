//
//  ELTabView.m
//  Pods
//
//  Created by 金秋成 on 2016/11/21.
//
//

#import "ELTabView.h"

#import "ConstantsColors.h"

#define countOfCellAtSingleLine 3


@interface _ELBodyCell : UICollectionViewCell
@property (nonatomic,strong)UILabel * titleLabel;
@end

@implementation _ELBodyCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        self.titleLabel.textColor = UIColorFromRGB(0x656565);
        self.titleLabel.font = ELTextSize22pt;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.titleLabel];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[TITLE]-0-|" options:0 metrics:nil views:@{@"TITLE":self.titleLabel}]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[TITLE]-0-|" options:0 metrics:nil views:@{@"TITLE":self.titleLabel}]];
        
        
    }
    return self;
}

@end


@interface _TitleFlowLayout : UICollectionViewFlowLayout
@property (nonatomic,strong)NSMutableArray * attrArr;
@property (nonatomic,assign)NSInteger itemCount;
-(CGRect)rectForItemAtIndexPath:(NSIndexPath *)indexPath;

@end


@implementation _TitleFlowLayout

-(void)prepareLayout{
    [super prepareLayout];
    self.collectionView.contentInset = UIEdgeInsetsZero;
    self.itemCount = [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:0];
    self.attrArr = [NSMutableArray new];
    self.itemSize = CGSizeMake(self.collectionView.frame.size.width / self.itemCount, self.collectionView.frame.size.height);
    for (NSInteger i = 0; i < self.itemCount; i++) {
        UICollectionViewLayoutAttributes * attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        attr.frame = CGRectMake(self.itemSize.width * i, 0, self.itemSize.width, self.itemSize.height);
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


-(CGRect)rectForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [self.attrArr[indexPath.row] frame];
}

@end


@interface _BodyFlowLayout : UICollectionViewFlowLayout
@property (nonatomic,strong)NSMutableArray * attrArr;
@property (nonatomic,assign)NSInteger itemCount;
-(CGRect)rectForItemAtIndexPath:(NSIndexPath *)indexPath;
@end


@implementation _BodyFlowLayout
-(void)prepareLayout{
    self.collectionView.contentInset = UIEdgeInsetsZero;
    self.itemCount = [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:0];
    self.attrArr = [NSMutableArray new];

    NSInteger lineCount = self.itemCount%countOfCellAtSingleLine > 0 ? self.itemCount/countOfCellAtSingleLine+1 : self.itemCount/countOfCellAtSingleLine;
    
    NSInteger sparateWidthCount = self.itemCount < countOfCellAtSingleLine ?  self.itemCount : countOfCellAtSingleLine;
    self.itemSize = CGSizeMake(self.collectionView.frame.size.width / sparateWidthCount, self.collectionView.frame.size.height/lineCount);
    for (NSInteger i = 0; i < self.itemCount; i++) {
        UICollectionViewLayoutAttributes * attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        attr.frame = CGRectMake(self.itemSize.width * (i%countOfCellAtSingleLine), self.itemSize.height * (i/countOfCellAtSingleLine) , self.itemSize.width, self.itemSize.height);
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


-(CGRect)rectForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [self.attrArr[indexPath.row] frame];
}
@end


@interface _ELTitleCell : UICollectionViewCell
@property (nonatomic,strong)UILabel * titleLabel;
@end

@implementation _ELTitleCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[UILabel alloc]initWithFrame:self.bounds];
        self.titleLabel.textColor = UIColorFromRGB(0x656565);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
//        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        
        
        [self addSubview:self.titleLabel];
    }
    return self;
}


-(void)setSelected:(BOOL)selected{
    if (selected) {
        self.titleLabel.textColor = ELColor01;
    }
    else{
        self.titleLabel.textColor = UIColorFromRGB(0x656565);
    }
}


@end


@interface ELTabView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView * titleCollectionView;
@property (nonatomic,strong)UICollectionView * bodyCollectionView;

@property (nonatomic,assign)CGRect titleRect;
@property (nonatomic,assign)CGRect targetTitleRect;
@property (nonatomic,assign)CGFloat distance;

@property (nonatomic,strong)CAShapeLayer * maskLayer;

@end


@implementation ELTabView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _selectIndex = -1;
        
        [self commonInit];
        
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self commonInit];
}

-(void)commonInit{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.titleCollectionView];
    [self addSubview:self.bodyCollectionView];
    self.titleCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.bodyCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[title]-0-|" options:0 metrics:nil views:@{@"title":_titleCollectionView}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[body]-0-|" options:0 metrics:nil views:@{@"body":_bodyCollectionView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[title(20)]-0-[body]-0-|" options:0 metrics:nil views:@{@"body":_bodyCollectionView,@"title":_titleCollectionView}]];
    
    self.titleRect  = CGRectZero;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.selectedIndex != -1) {
        self.selectIndex = self.selectedIndex;
    }
    
//    [self drawMaskLayer];
}

- (void)drawRect:(CGRect)rect {
    
}

- (void)drawMaskLayer{
    [self layoutIfNeeded];
    if (!CGRectIsEmpty(self.titleRect)) {
        CGRect rect = self.bounds;
        CGMutablePathRef linePath =nil;
        
        linePath =CGPathCreateMutable();
        
        
        CGPathMoveToPoint(linePath,NULL, self.titleRect.origin.x, self.titleRect.size.height);//设置起点
        CGPathAddLineToPoint(linePath,NULL, self.titleRect.origin.x, self.titleRect.origin.y);
        CGPathAddLineToPoint(linePath,NULL, self.titleRect.origin.x +self.titleRect.size.width, self.titleRect.origin.y);
        
        CGPathAddLineToPoint(linePath,NULL, self.titleRect.origin.x +self.titleRect.size.width, self.titleRect.size.height);
        CGPathAddLineToPoint(linePath,NULL, rect.size.width, self.titleRect.size.height);
        CGPathAddLineToPoint(linePath,NULL, rect.size.width, rect.size.height);
        CGPathAddLineToPoint(linePath,NULL, 0, rect.size.height);
        CGPathAddLineToPoint(linePath,NULL, 0, self.titleRect.size.height);
        CGPathAddLineToPoint(linePath,NULL, self.titleRect.origin.x, self.titleRect.size.height);
        self.maskLayer.frame = rect;
        self.maskLayer.path = linePath;
        CGPathRelease(linePath);
    }
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == self.titleCollectionView) {
        return self.tabTitles.count;
    }
    else{
        return self.bodyTitles.count;
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.titleCollectionView) {
        
        NSString * title = self.tabTitles[indexPath.row];
        
        _ELTitleCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"titleCell" forIndexPath:indexPath];
        cell.titleLabel.text = title;
        return cell;
    }
    else{
        NSString * title = self.bodyTitles[indexPath.row];
        _ELBodyCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"bodyCell" forIndexPath:indexPath];
        cell.titleLabel.text = title;
        return cell;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == self.titleCollectionView) {
        if (self.dataSource) {
            self.bodyTitles = self.dataSource(indexPath.row);
        }
        [collectionView deselectItemAtIndexPath:indexPath animated:NO];
        [self setSelectIndex:indexPath.row animated:NO];
        if (self.titleDelegate) {
            self.titleDelegate(indexPath.row);
        }
    }
    else{
        if (self.delegate) {
            self.delegate(self.selectIndex,indexPath.row);
            [collectionView deselectItemAtIndexPath:indexPath animated:NO];
        }
    }
    
}

-(UICollectionView *)titleCollectionView{
    if (!_titleCollectionView) {
        _TitleFlowLayout * layout = [[_TitleFlowLayout alloc]init];
        
        _titleCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _titleCollectionView.allowsSelection = YES;
        _titleCollectionView.backgroundColor = [UIColor whiteColor];
        [_titleCollectionView registerClass:[_ELTitleCell class] forCellWithReuseIdentifier:@"titleCell"];
        _titleCollectionView.delegate = self;
        _titleCollectionView.dataSource = self;
        _titleCollectionView.showsVerticalScrollIndicator = NO;
        _titleCollectionView.showsHorizontalScrollIndicator = NO;
    }
    return _titleCollectionView;
}

-(UICollectionView *)bodyCollectionView{
    if (!_bodyCollectionView) {
        _BodyFlowLayout * layout = [[_BodyFlowLayout alloc]init];
        _bodyCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        [_bodyCollectionView registerClass:[_ELBodyCell class] forCellWithReuseIdentifier:@"bodyCell"];
        
        _bodyCollectionView.backgroundColor = [UIColor whiteColor];
        _bodyCollectionView.delegate = self;
        _bodyCollectionView.dataSource = self;
    }
    return _bodyCollectionView;
}

-(void)setSelectIndex:(NSInteger)selectIndex{
    [self setSelectIndex:selectIndex animated:NO];
}

-(void)setSelectIndex:(NSInteger)selectIndex animated:(BOOL)animated{
    _selectIndex = selectIndex;
    if (animated) {
        self.targetTitleRect = [(_TitleFlowLayout *)self.titleCollectionView.collectionViewLayout rectForItemAtIndexPath:[NSIndexPath indexPathForRow:selectIndex inSection:0]];
        self.distance = self.targetTitleRect.origin.x - self.titleRect.origin.x;
        
        
        CADisplayLink * displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(tiktoc:)];
        [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    else{
        if (self.dataSource) {
            self.bodyTitles = self.dataSource(selectIndex);
            [self.bodyCollectionView reloadData];
        }
        self.titleRect = [(_TitleFlowLayout *)self.titleCollectionView.collectionViewLayout rectForItemAtIndexPath:[NSIndexPath indexPathForRow:selectIndex inSection:0]];
        [self drawMaskLayer];
        [self.titleCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    }
    
}



-(void)tiktoc:(CADisplayLink *)displayLink{
    if (self.distance > 0) {
        if (self.targetTitleRect.origin.x <= self.titleRect.origin.x) {
            [displayLink invalidate];
            self.titleRect = self.targetTitleRect;
            [self drawMaskLayer];
            [self.bodyCollectionView reloadData];
            [self.titleCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
        }
        else{
            CGFloat distancePerSecond = (self.distance)*displayLink.duration / 0.2;
            self.titleRect = CGRectMake(self.titleRect.origin.x+distancePerSecond, self.titleRect.origin.y, self.titleRect.size.width, self.titleRect.size.height);
            [self drawMaskLayer];
        }
    }
    else{
        if (self.targetTitleRect.origin.x >= self.titleRect.origin.x) {
            [displayLink invalidate];
            self.titleRect = self.targetTitleRect;
            [self drawMaskLayer];
            [self.bodyCollectionView reloadData];
            [self.titleCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
            
        }
        else{
            CGFloat distancePerSecond = (self.distance)*displayLink.duration / 0.2;
            self.titleRect = CGRectMake(self.titleRect.origin.x+distancePerSecond, self.titleRect.origin.y, self.titleRect.size.width, self.titleRect.size.height);
            [self drawMaskLayer];
        }
    }
}

-(void)setTabTitles:(NSArray<NSString *> *)tabTitles{
    _tabTitles = tabTitles;
}

-(void)reloadData{
    [self.titleCollectionView reloadData];
}


-(CAShapeLayer *)maskLayer{
    if (!_maskLayer) {
        _maskLayer = [CAShapeLayer layer];
        _maskLayer.strokeColor = [UIColor colorWithRed:0.898 green:0.898 blue:0.898 alpha:1.00].CGColor;
        _maskLayer.fillColor   = [UIColor clearColor].CGColor;
        _maskLayer.lineWidth=1;
        _maskLayer.lineJoin=kCALineJoinRound;
        [self.layer addSublayer:_maskLayer];
    }
    return _maskLayer;
}



@end
