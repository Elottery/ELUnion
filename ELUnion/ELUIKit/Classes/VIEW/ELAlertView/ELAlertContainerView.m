//
//  ELAlertContainerView.m
//  Elottory
//
//  Created by 金秋成 on 16/9/15.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "ELAlertContainerView.h"

@interface ELAlertContainerViewFlowLayout : UICollectionViewFlowLayout
@property (nonatomic,assign)NSInteger itemCount;
@property (nonatomic,strong)NSMutableArray * attrArr;

@end

@implementation ELAlertContainerViewFlowLayout

-(void)prepareLayout{
    [super prepareLayout];
    _attrArr = [NSMutableArray new];
    _itemCount = [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:0];
    if (_itemCount > 3) {
        self.itemSize = CGSizeMake(self.collectionView.frame.size.width, 44);
        for (NSInteger i = 0; i < _itemCount; i++) {
            CGRect frame = CGRectMake(0, self.itemSize.height * i, self.itemSize.width, self.itemSize.height);
            UICollectionViewLayoutAttributes * attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            attr.frame = frame;
            [_attrArr addObject:attr];
        }
    }
    else{
        self.itemSize = CGSizeMake(self.collectionView.frame.size.width/_itemCount, 44);
        for (NSInteger i = 0; i < _itemCount; i++) {
            CGRect frame = CGRectMake(self.itemSize.width * i, 0, self.itemSize.width, self.itemSize.height);
            UICollectionViewLayoutAttributes * attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            attr.frame = frame;
            [_attrArr addObject:attr];
        }
    }
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrArr;
}
-(CGSize)collectionViewContentSize{
    if (_itemCount > 3) {
        return CGSizeMake(self.collectionView.frame.size.width, 44 * _itemCount);
    }
    else{
        return CGSizeMake(self.collectionView.frame.size.width, 44);
    }
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

@end



@interface ELAlertContainerViewActionItem ()
@property (nonatomic,strong)NSAttributedString * title;
@property (nonatomic,strong)UIColor            * itemBackgroundColor;


@end


@implementation ELAlertContainerViewActionItem

+(instancetype)actionWithTitle:(NSAttributedString *)title
            andBackgroundColor:(UIColor *)backgroundColor
                    andHandler:(ELAlertContainerViewActionItemHandler)handler{
    ELAlertContainerViewActionItem * item = [[ELAlertContainerViewActionItem alloc]init];
    item.title = title;
    item.itemBackgroundColor = backgroundColor;
    item.handler = handler;
    
    item.highlitedBackgroundColor = [UIColor lightGrayColor];
    item.highlitedTitle           = title;
    
    
    return item;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.itemBackgroundColor = [UIColor whiteColor];
        self.title = [[NSAttributedString alloc]initWithString:@"item" attributes:@{}];
        
    }
    return self;
}
@end


@interface ELAlertContainerViewButtonCell : UICollectionViewCell
-(void)bindItem:(ELAlertContainerViewActionItem *)item;
@end

@implementation ELAlertContainerViewButtonCell
{
    UILabel * _titleLabel;
    ELAlertContainerViewActionItem * _item;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_titleLabel];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[TITLE]-15-|" options:0 metrics:0 views:@{@"TITLE":_titleLabel}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[TITLE]-15-|" options:0 metrics:0 views:@{@"TITLE":_titleLabel}]];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


-(void)bindItem:(ELAlertContainerViewActionItem *)item{
    _item = item;
    _titleLabel.attributedText = item.title;
    self.backgroundColor = item.itemBackgroundColor;
}


-(void)setHighlighted:(BOOL)highlighted{
    if (highlighted) {
        _titleLabel.attributedText = _item.highlitedTitle;
        self.backgroundColor = _item.highlitedBackgroundColor;
    }
    else{
        _titleLabel.attributedText = _item.title;
        self.backgroundColor = _item.itemBackgroundColor;
    }
    [super setHighlighted:highlighted];
}



@end



@interface ELAlertContainerView ()<UICollectionViewDelegate ,UICollectionViewDataSource>

@property (nonatomic,strong)NSAttributedString *title;
@property (nonatomic,strong)NSMutableArray<ELAlertContainerViewActionItem *> * itemsArr;


@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UIView  * subView;
@property (nonatomic,strong)UICollectionView * bottomArea;

@property (nonatomic,strong)UIView             * backgroundView;

@property (nonatomic,strong)NSLayoutConstraint * subViewBottomConstraint;

@property (nonatomic,strong)NSLayoutConstraint * bottomAreaHeight;

@end


@implementation ELAlertContainerView
-(instancetype)initWithTitle:(NSAttributedString *)title
                  andSubview:(UIView *)subview
             andSubViewRatio:(CGFloat)ratio{
    self = [super init];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.subView = subview;
        self.itemsArr = [NSMutableArray new];
        if (title) {
            self.titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
            self.titleLabel.attributedText = title;
            self.titleLabel.backgroundColor = [UIColor whiteColor];
            self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:self.titleLabel];

            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[titleLabel]-0-|"
                                                                        options:0
                                                                        metrics:nil
                                                                           views:@{@"titleLabel":self.titleLabel}]];
            
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[titleLabel(30)]"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:@{@"titleLabel":self.titleLabel}]];
        }
        
        [self addSubview:self.subView];
        self.subView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[SUBVIEW]-0-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"SUBVIEW":self.subView}]];
        
        if (self.titleLabel) {
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[titleLabel]-0-[SUBVIEW]"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:@{@"SUBVIEW":self.subView,
                                                                                   @"titleLabel":self.titleLabel}]];
            
            
        }
        else{
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[SUBVIEW]"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:@{@"SUBVIEW":self.subView}]];
        }
        
        
        self.subViewBottomConstraint = [NSLayoutConstraint constraintWithItem:self.subView
                                                                    attribute:NSLayoutAttributeBottom
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self
                                                                    attribute:NSLayoutAttributeBottom
                                                                   multiplier:1
                                                                     constant:0];
        
        [self addConstraint:self.subViewBottomConstraint];
        
        
        
        [self.subView addConstraint:[NSLayoutConstraint constraintWithItem:self.subView
                                                                 attribute:NSLayoutAttributeWidth
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.subView
                                                                 attribute:NSLayoutAttributeHeight
                                                                multiplier:ratio
                                                                  constant:0]];
        
        
        
    }
    return self;
}

-(void)addItems:(NSArray<ELAlertContainerViewActionItem *> *)itemsArr{
    CGFloat bottomAreaHeight = 44;
    if (!_bottomArea) {
        _bottomArea = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[[ELAlertContainerViewFlowLayout alloc]init]];
        _bottomArea.translatesAutoresizingMaskIntoConstraints = NO;
        [_bottomArea registerClass:[ELAlertContainerViewButtonCell class] forCellWithReuseIdentifier:@"cell"];
        _bottomArea.delegate = self;
        _bottomArea.dataSource = self;
        [self addSubview:_bottomArea];
        
        
        [self removeConstraint: self.subViewBottomConstraint];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[SUBVIEW]-0-[BOTTOM]-0-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"SUBVIEW":self.subView,
                                                                               @"BOTTOM":_bottomArea}]];
        
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[BOTTOM]-0-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"BOTTOM":_bottomArea}]];
        
        
        
        
        self.bottomAreaHeight = [NSLayoutConstraint constraintWithItem:_bottomArea attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:bottomAreaHeight];
        [self addConstraint:self.bottomAreaHeight];
        
        
    }
    
    
    
    
    
    [self.itemsArr addObjectsFromArray:itemsArr];
    
    
    
    if (_itemsArr.count > 3) {
        bottomAreaHeight = 44 * _itemsArr.count;
    }
    
    self.bottomAreaHeight.constant = bottomAreaHeight;

    [self.bottomArea reloadData];
}

-(void)showInView:(UIView *)view{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc]init];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = 0;
        _backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
        UITapGestureRecognizer  * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissView)];
        [_backgroundView addGestureRecognizer:tap];
        [view addSubview:_backgroundView];
        [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[BG]-0-|" options:0 metrics:nil views:@{@"BG":_backgroundView}]];
        [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[BG]-0-|" options:0 metrics:nil views:@{@"BG":_backgroundView}]];
    }
    
    
    
    
    
    [view addSubview:self];
    
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[view]-30-|" options:0 metrics:nil views:@{@"view":self}]];
    
    
    
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1
                                                      constant:0]];
    self.transform = CGAffineTransformMakeScale(0, 0);
    
    
    [UIView animateWithDuration:0.2 animations:^{
        _backgroundView.alpha = .5f;
        self.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius  = 20.f;
    }];
    
    
    
    
}


-(void)dismissView{
    [UIView animateWithDuration:0.2 animations:^{
        _backgroundView.alpha = .0f;
        self.transform = CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.backgroundView removeFromSuperview];
        _backgroundView = nil;
    }];
}





#pragma mark -CollectionViewDelegate
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ELAlertContainerViewButtonCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    ELAlertContainerViewActionItem * item = self.itemsArr[indexPath.row];
    
    [cell bindItem:item];
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.itemsArr.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ELAlertContainerViewActionItem * item = self.itemsArr[indexPath.row];
    if (item.handler) {
        item.handler();
    }
    [self dismissView];
}

#pragma mark -getter

-(void)getHeight{
    
}



@end
