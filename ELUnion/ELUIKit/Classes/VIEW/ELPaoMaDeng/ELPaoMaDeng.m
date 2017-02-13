//
//  ELPaoMaDeng.m
//  Elottory
//
//  Created by 金秋成 on 16/7/30.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "ELPaoMaDeng.h"

@interface ELPaoMaDengCell : UIControl
@property (nonatomic,strong)UILabel * label;
@end


@implementation ELPaoMaDengCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc]initWithFrame:frame];
        self.label.font = [UIFont systemFontOfSize:10];
//        self.label.textColor = [UIColor blackColor];
        self.label.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.label];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[label]-0-|" options:0 metrics:nil views:@{@"label":self.label}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[label]-0-|" options:0 metrics:nil views:@{@"label":self.label}]];
    }
    return self;
}

@end

@interface ELPaoMaDeng ()
@property (nonatomic,strong)UIScrollView * scrollView;
@property (nonatomic,strong)ELPaoMaDengCell  * rowView_1;
@property (nonatomic,strong)ELPaoMaDengCell  * rowView_2;
@property (nonatomic,strong)NSTimer * timer;
@property (nonatomic,assign)NSUInteger rowNumber;
@property (nonatomic,assign)NSUInteger index;
@end

@implementation ELPaoMaDeng

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.index = 0;
        self.rollingTime = 2;
        self.scrollView = [[UIScrollView alloc]initWithFrame:frame];
        self.scrollView.scrollEnabled = NO;
        self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.scrollView];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[scrollView]-10-|" options:0 metrics:nil views:@{@"scrollView":self.scrollView}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[scrollView]-0-|" options:0 metrics:nil views:@{@"scrollView":self.scrollView}]];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width  = self.scrollView.frame.size.width;
    CGFloat height = self.scrollView.frame.size.height;
    self.scrollView.contentSize = CGSizeMake(width, height*2);
    if (!self.rowView_1) {
        self.rowView_1 = [[ELPaoMaDengCell alloc]initWithFrame:CGRectMake(0, 0, width, height)];
        self.rowView_1.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.rowView_1.backgroundColor = [UIColor whiteColor];
        [self.rowView_1 addTarget:self action:@selector(didSelectCell:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:self.rowView_1];
    }
    if (!self.rowView_2) {
        self.rowView_2 = [[ELPaoMaDengCell alloc]initWithFrame:CGRectMake(0, height, width, height)];
        self.rowView_2.backgroundColor = [UIColor whiteColor];
        self.rowView_2.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.scrollView addSubview:self.rowView_2];
        [self.rowView_2 addTarget:self action:@selector(didSelectCell:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)didSelectCell:(ELPaoMaDengCell *)cell{
    if (self.delegate && [self.delegate respondsToSelector:@selector(paomadeng:didSelectAtIndex:)]) {
        NSUInteger numberOfRow = [self.delegate numberOfRowInPaomadeng];
        if (numberOfRow == 0) {
            return;
        }
        [self.delegate paomadeng:self didSelectAtIndex:self.index%numberOfRow];
    }
}


-(void)reloadData{
    self.index = 0;
//    [self.rowView_1 removeFromSuperview];
//    [self.rowView_2 removeFromSuperview];

    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }

    if (self.delegate  &&
        [self.delegate respondsToSelector:@selector(numberOfRowInPaomadeng)]) {
        _rowNumber = [self.delegate numberOfRowInPaomadeng];
        [self.timer fire];
    }
}

-(void)startChangeView{
   __block NSString * title = nil;
    NSUInteger numberOfRow = [self.delegate numberOfRowInPaomadeng];
    if (numberOfRow == 0) {
        return;
    }
    title = [self.delegate paomadengView:self titleForIndex:self.index%numberOfRow];
    CGFloat height = self.scrollView.frame.size.height;
    
    if (self.scrollView.contentOffset.y == 0) {
        [UIView animateWithDuration:0.2 animations:^{
            self.scrollView.contentOffset = CGPointMake(0, height);
            self.rowView_2.label.text = title;
        } completion:^(BOOL finished) {
            self.index++;
            self.scrollView.contentOffset = CGPointMake(0, 0);
            self.rowView_1.label.text = title;
            title = [self.delegate paomadengView:self titleForIndex:self.index%numberOfRow];
            self.rowView_2.label.text = title;
        }];
    }
}

-(NSTimer *)timer{
    __weak typeof(self) weakSelf = self;
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:weakSelf.rollingTime target:weakSelf selector:@selector(startChangeView) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}
@end
