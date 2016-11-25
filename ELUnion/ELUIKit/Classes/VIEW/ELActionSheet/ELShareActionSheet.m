//
//  ELShareActionSheet.m
//  Elottory
//
//  Created by 金秋成 on 16/9/3.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "ELShareActionSheet.h"
#import "ELShareActionSheetCell.h"
#import "ELBundleHelper.h"

@interface ELShareActionSheetFlowLayout : UICollectionViewFlowLayout
@property (nonatomic,strong)NSMutableArray * attrs;
@property (nonatomic,assign)NSInteger numberOfItems;
@end

@implementation ELShareActionSheetFlowLayout
-(void)prepareLayout{
    self.attrs = [NSMutableArray new];
    self.itemSize = CGSizeMake(self.collectionView.frame.size.width / 4, self.collectionView.frame.size.height);
    
    self.numberOfItems = [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i <self.numberOfItems; i++) {
        UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        attr.frame = CGRectMake(self.itemSize.width * i, 0, self.itemSize.width, self.itemSize.height);
        [self.attrs addObject:attr];
    }
    
    
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrs;
}

-(CGSize)collectionViewContentSize{
    return  CGSizeMake(self.itemSize.width * self.numberOfItems, self.itemSize.height);
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

@end



@interface ELShareActionSheet ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,assign)CGFloat  subViewHeight;
@property (nonatomic,strong)UILabel* titleLabel;
@property (nonatomic,strong)UIButton * cancelButton;
@property (nonatomic,strong)UIView * topView;
@property (nonatomic,strong)UIView * bottomView;
@property (nonatomic,assign)BOOL     isInShow;
@property (nonatomic,strong)UICollectionView * subview;

@property (nonatomic,strong)NSArray * itemsArr;

//@property (nonatomic,weak)UIView * backgroundMaskView;

@property (nonatomic,copy)ShareActionSheetClick handler;

@end

@implementation ELShareActionSheet

-(instancetype)initWithHandler:(ShareActionSheetClick)handler{
    ELShareActionSheet * sheet = [self initWithFrame:CGRectZero];
    sheet.handler = handler;
    return sheet;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.subViewHeight = 80;
        self.itemsArr = [[ELShareService sharedService]enablePlatforms];
        
        
        self.backgroundColor = [UIColor colorWithRed:0.945 green:0.945 blue:0.945 alpha:1.00];
        self.topView = [[UIView alloc]initWithFrame:CGRectZero];
        self.topView.backgroundColor = [UIColor whiteColor];
        self.bottomView = [[UIView alloc]initWithFrame:CGRectZero];
        
        self.topView.translatesAutoresizingMaskIntoConstraints    = NO;
        self.bottomView.translatesAutoresizingMaskIntoConstraints = NO;
        self.subview.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self addSubview:self.topView];
        [self addSubview:self.subview];
        [self addSubview:self.bottomView];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[TOPVIEW]-0-|" options:0 metrics:nil views:@{@"TOPVIEW":self.topView}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[MIDDLEVIEW]-0-|" options:0 metrics:nil views:@{@"MIDDLEVIEW":self.subview}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[BOTTOMVIEW]-0-|" options:0 metrics:nil views:@{@"BOTTOMVIEW":self.bottomView}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[TOPVIEW(top_height)]-0-[MIDDLEVIEW(height)]-10-[BOTTOMVIEW(bottom_height)]-0-|"
                                                                     options:0
                                                                     metrics:@{@"top_height":@(30),
                                                                               @"bottom_height":@(44),
                                                                               @"height":@(self.subViewHeight)}
                                                                       views:@{@"TOPVIEW":self.topView,
                                                                               @"BOTTOMVIEW":self.bottomView,
                                                                               @"MIDDLEVIEW":self.subview}]];
        
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor colorWithRed:0.396 green:0.396 blue:0.396 alpha:1.00];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.topView addSubview:self.titleLabel];
        
        [self.topView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[TITLE]-0-|" options:0 metrics:nil views:@{@"TITLE":self.titleLabel}]];
        [self.topView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[TITLE]-0-|" options:0 metrics:nil views:@{@"TITLE":self.titleLabel}]];
        self.titleLabel.text = @"请选择";
        
        self.cancelButton = [[UIButton alloc]initWithFrame:CGRectZero];
        NSAttributedString * cancelString = [[NSAttributedString alloc]initWithString:@"取消" attributes:@{NSForegroundColorAttributeName : [UIColor redColor],NSFontAttributeName : [UIFont systemFontOfSize:16]}];
        self.cancelButton.backgroundColor = [UIColor whiteColor];
        
        [self.cancelButton setAttributedTitle:cancelString forState:UIControlStateNormal];
        [self.cancelButton addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self.bottomView addSubview:self.cancelButton];
        
        
        [self.bottomView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[CANCEL]-0-|" options:0 metrics:nil views:@{@"CANCEL":self.cancelButton}]];
        [self.bottomView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[CANCEL]-0-|" options:0 metrics:nil views:@{@"CANCEL":self.cancelButton}]];
    }
    return self;
}


-(void)showInView:(UIView *)view{
    if (self.isInShow) {
        return;
    }
    
    
    
//    backgroundMaskView
//    UIView * backgroundMaskView = [[UIView alloc]initWithFrame:CGRectZero];
//    backgroundMaskView.backgroundColor = [UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:0.50];
//    backgroundMaskView.translatesAutoresizingMaskIntoConstraints = NO;
//    [view addSubview:backgroundMaskView];
//    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[BACKVIEW]-0-|" options:0 metrics:nil views:@{@"BACKVIEW":backgroundMaskView}]];
//    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[BACKVIEW]-0-|" options:0 metrics:nil views:@{@"BACKVIEW":backgroundMaskView}]];
//    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissAction)];
//    [backgroundMaskView addGestureRecognizer:tap];
    
//    self.backgroundMaskView = backgroundMaskView;
    
    
    [view addSubview:self];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[VIEW]-0-|" options:0 metrics:nil views:@{@"VIEW":self}]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[VIEW]-0-|" options:0 metrics:nil views:@{@"VIEW":self}]];
    self.isInShow = YES;
    CGFloat totalHeight = 30 + 44 + self.subViewHeight + 10;
    self.transform = CGAffineTransformMakeTranslation(0, totalHeight);
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, 0);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)dismissAction{
    CGFloat totalHeight = 30 + 44 + self.subViewHeight + 10;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, totalHeight);

    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.isInShow = NO;
    }];
}


-(void)cancelBtnClick:(UIButton *)sender{
    self.handler(-1,nil,self,YES);
//    [self dismissAction];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ELShareActionSheetCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    ELPlatform * p = [self.itemsArr objectAtIndex:indexPath.row];
    cell.titleLabel.text = p.detailTitle;
    switch (p.subPlatform) {
        case ELShareService_Platform_WECHAT_SESSION:
            cell.imageView.image = [ELBundleHelper el_imageNamed:@"wx_friend"];
            break;
        case ELShareService_Platform_WECHAT_TIMELINE:
            cell.imageView.image = [ELBundleHelper el_imageNamed:@"wx_timeline"];
            break;
            
        case ELShareService_Platform_QQ_SESSION:
            cell.imageView.image = [ELBundleHelper el_imageNamed:@"qq_friend"];
            break;
        case ELShareService_Platform_QQ_ZONE:
            cell.imageView.image = [ELBundleHelper el_imageNamed:@"qq_zone"];
        default:
            break;
    }
    
    
    
    return cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.itemsArr.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.handler) {
        ELPlatform * p = [self.itemsArr objectAtIndex:indexPath.row];
        self.handler(indexPath.row,p,self,NO);
    }
}





-(UICollectionView *)subview{
    if (!_subview) {
        ELShareActionSheetFlowLayout * flowLayout = [[ELShareActionSheetFlowLayout alloc]init];
    
        
        _subview = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _subview.backgroundColor = [UIColor whiteColor];
        [_subview registerNib:[ELBundleHelper el_nibNamed:@"ELShareActionSheetCell"] forCellWithReuseIdentifier:@"cell"];
        _subview.translatesAutoresizingMaskIntoConstraints = NO;
        _subview.dataSource = self;
        _subview.delegate = self;
    }
    return _subview;
}


@end
