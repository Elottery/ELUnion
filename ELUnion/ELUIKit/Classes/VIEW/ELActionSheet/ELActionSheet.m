//
//  ELActionSheet.m
//  Elottory
//
//  Created by 金秋成 on 16/7/31.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "ELActionSheet.h"
#define BTN_HEIGHT 44

@interface _ELActionSheetCell : UITableViewCell
@property (nonatomic,strong)UIView * topLine;
@property (nonatomic,strong)UIView * bottomLine;
@property (nonatomic,strong)UILabel * titleLabel;
@end

@implementation _ELActionSheetCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.bottomLine = [[UIView alloc]initWithFrame:CGRectZero];
        self.bottomLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.bottomLine.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.bottomLine];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[bottom]-0-|" options:0 metrics:nil views:@{@"bottom":_bottomLine}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[bottom(0.5)]-0-|" options:0 metrics:nil views:@{@"bottom":_bottomLine}]];
        
        
        self.topLine = [[UIView alloc]initWithFrame:CGRectZero];
        self.topLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.topLine.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.topLine];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[top]-0-|" options:0 metrics:nil views:@{@"top":_topLine}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[top(0.5)]" options:0 metrics:nil views:@{@"top":_topLine}]];
        
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.titleLabel.textColor = [UIColor colorWithRed:0.396 green:0.396 blue:0.396 alpha:1.00];
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self addSubview:self.titleLabel];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[title]-0-|" options:0 metrics:nil views:@{@"title":_titleLabel}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0.5-[title]-0.5-|" options:0 metrics:nil views:@{@"title":_titleLabel}]];
        
        
        
        
    }
    return self;
}


@end


@interface ELActionSheet ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UILabel* titleLabel;
@property (nonatomic,strong)UIButton * cancelButton;
@property (nonatomic,strong)UIView * topView;
@property (nonatomic,strong)UIView * bottomView;
@property (nonatomic,strong)NSLayoutConstraint * middleViewHeight;


@property (nonatomic,strong)UITableView * middleView;
@property (nonatomic,assign)CGFloat       middleViewMaxHeight;

@property (nonatomic,strong)NSArray   * titles;


@property (nonatomic,copy)ELActionSheetBlock handler;

@property (nonatomic,copy)ELActionSheetCancelBlock cancelHandler;

@end

@implementation ELActionSheet

-(instancetype)initWithTitles:(NSArray *)titles
                   andHandler:(ELActionSheetBlock)handler
             andCancelHandler:(ELActionSheetCancelBlock)cancelHandler{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.handler = handler;
        self.cancelHandler = cancelHandler;
        self.titles = titles;
        self.backgroundColor = [UIColor colorWithRed:0.945 green:0.945 blue:0.945 alpha:1.00];
        self.topView = [[UIView alloc]initWithFrame:CGRectZero];
        self.topView.backgroundColor = [UIColor whiteColor];
        self.bottomView = [[UIView alloc]initWithFrame:CGRectZero];
        
        self.topView.translatesAutoresizingMaskIntoConstraints    = NO;
        self.bottomView.translatesAutoresizingMaskIntoConstraints = NO;
        
        
        [self addSubview:self.middleView];
        [self addSubview:self.topView];
        [self addSubview:self.bottomView];
        
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[TOPVIEW]-0-|" options:0 metrics:nil views:@{@"TOPVIEW":self.topView}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[MIDDLEVIEW]-0-|" options:0 metrics:nil views:@{@"MIDDLEVIEW":self.middleView}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[BOTTOMVIEW]-0-|" options:0 metrics:nil views:@{@"BOTTOMVIEW":self.bottomView}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[TOPVIEW(top_height)]-0-[MIDDLEVIEW]-10-[BOTTOMVIEW(bottom_height)]-0-|"
                                                                     options:0
                                                                     metrics:@{@"top_height":@(30),
                                                                               @"bottom_height":@(44),
                                                                               @"height":@(titles.count * BTN_HEIGHT)}
                                                                       views:@{@"TOPVIEW":self.topView,
                                                                               @"BOTTOMVIEW":self.bottomView,
                                                                               @"MIDDLEVIEW":self.middleView}]];
        
        self.middleViewHeight = [NSLayoutConstraint constraintWithItem:self.middleView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:1];
        [self addConstraint:self.middleViewHeight];
        
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


-(instancetype)initWithTitles:(NSArray *)titles
                   andHandler:(ELActionSheetBlock)handler{
    ELActionSheet * selfObj = [[ELActionSheet alloc]initWithTitles:titles andHandler:handler andCancelHandler:nil];
    return selfObj;
}


-(void)show{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [self showInView:window];
}

-(void)showInView:(UIView *)view{
    
    
    self.middleViewMaxHeight = view.bounds.size.height / 2 - 30 - 44 - 10;
    
    
    
    [view addSubview:self];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[VIEW]-0-|" options:0 metrics:nil views:@{@"VIEW":self}]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[VIEW]-0-|" options:0 metrics:nil views:@{@"VIEW":self}]];
    
    CGFloat middleViewHeight = 0;
    
    if (self.middleViewMaxHeight < self.titles.count * BTN_HEIGHT) {
        middleViewHeight = self.middleViewMaxHeight;
        self.middleView.scrollEnabled = YES;
    }
    else{
        middleViewHeight = self.titles.count * BTN_HEIGHT;
        self.middleView.scrollEnabled = NO;
    }
    self.middleViewHeight.constant = middleViewHeight;
    
    
    CGFloat totalHeight = 30 + 44 + middleViewHeight + 10;
    self.transform = CGAffineTransformMakeTranslation(0, totalHeight);
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, 0);
        
    } completion:^(BOOL finished) {
        
    }];
    
    
    
    
}

-(void)dismissActionSheet{
   
    CGFloat middleViewHeight = self.middleViewMaxHeight < self.titles.count * BTN_HEIGHT ? self.middleViewMaxHeight : self.titles.count * BTN_HEIGHT;
    CGFloat totalHeight = 30 + 44 + middleViewHeight + 10;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, totalHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
   
}

-(void)cancelBtnClick:(UIButton *)sender{
    if (self.cancelHandler) {
        self.cancelHandler();
    }
//    [self dismissActionSheet];
}

//-(void)backgroundMaskViewTap:(UITapGestureRecognizer *)tap{
//    [self dismissActionSheet];
//}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    _ELActionSheetCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    id title = self.titles[indexPath.row];
    if ([title isKindOfClass:[NSAttributedString class]]) {
        cell.titleLabel.attributedText = title;
    }
    else{
        cell.titleLabel.text = title;
    }
    if (indexPath.row == self.titles.count -1) {
        cell.bottomLine.hidden = NO;
    }
    else{
        cell.bottomLine.hidden = YES;
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BTN_HEIGHT;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.handler) {
        self.handler(indexPath.row);
    }
//    [self dismissActionSheet];
}



-(UITableView *)middleView{
    if (!_middleView) {
        _middleView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _middleView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _middleView.translatesAutoresizingMaskIntoConstraints = NO;
        [_middleView registerClass:[_ELActionSheetCell class] forCellReuseIdentifier:@"cell"];
        _middleView.delegate = self;
        _middleView.dataSource = self;
        
    }
    return _middleView;
}



@end
