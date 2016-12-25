//
//  ELBaseTableViewController.m
//  Elottory
//
//  Created by 金秋成 on 16/8/21.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "ELBaseTableViewController.h"
#import "MJRefresh.h"

@interface ELBaseTableViewController ()




@end

@implementation ELBaseTableViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _currentPage = 1;
        _loadingPageIndex    = 1;
        _startPage   = 1;
        _pageSize    = 15;
        _hasFooter = YES;
        _hasHeader = YES;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
}

#pragma mark -SETUPVIEW
-(void)setupTableView{
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    [self.view insertSubview:self.tableView atIndex:0];

    
    _topConstaint = [NSLayoutConstraint constraintWithItem:self.tableView
                                                 attribute:NSLayoutAttributeTop
                                                 relatedBy:NSLayoutRelationEqual
                                                    toItem:self.view
                                                 attribute:NSLayoutAttributeTop
                                                multiplier:1
                                                  constant:0];
    
    
    _bottomConstaint = [NSLayoutConstraint constraintWithItem:self.tableView
                                                 attribute:NSLayoutAttributeBottom
                                                 relatedBy:NSLayoutRelationEqual
                                                    toItem:self.view
                                                 attribute:NSLayoutAttributeBottom
                                                multiplier:1
                                                  constant:0];
    
    _leftConstaint = [NSLayoutConstraint constraintWithItem:self.tableView
                                                    attribute:NSLayoutAttributeLeading
                                                    relatedBy:NSLayoutRelationEqual
                                                       toItem:self.view
                                                    attribute:NSLayoutAttributeLeading
                                                   multiplier:1
                                                     constant:0];
    
    _rightConstaint = [NSLayoutConstraint constraintWithItem:self.tableView
                                                  attribute:NSLayoutAttributeTrailing
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:self.view
                                                  attribute:NSLayoutAttributeTrailing
                                                 multiplier:1
                                                   constant:0];
    [self.view addConstraints:@[_topConstaint,_bottomConstaint,_leftConstaint,_rightConstaint]];
    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[TABLEVIEW]-0-|" options:0 metrics:nil views:@{@"TABLEVIEW":self.tableView}]];
//    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[navigationBar]-0-[TABLEVIEW]-0-|" options:0 metrics:nil views:@{@"TABLEVIEW":self.tableView,@"navigationBar":self.el_navigationBar}]];
}

#pragma mark -DELEGATE

#pragma mark -tableviewdelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}


#pragma mark -GETTER_LAZY

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        self.hasFooter = _hasFooter;
        self.hasHeader = _hasHeader;
        
    }
    return _tableView;
}

-(void)setHasFooter:(BOOL)hasFooter{
    _hasFooter = hasFooter;
    if (hasFooter) {
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    }
    else{
        _tableView.mj_footer = nil;
    }
}

-(void)setHasHeader:(BOOL)hasHeader{
    if (hasHeader) {
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    }
    else{
        _tableView.mj_header = nil;
    }
}


-(void)headerRefresh{
    _currentPage      =  self.startPage;
    _loadingPageIndex =  self.startPage;
    [self loadDataAtPageIndex:_currentPage withPageSize:_pageSize];
}

-(void)footerRefresh{
    _loadingPageIndex++;
    [self loadDataAtPageIndex:_loadingPageIndex withPageSize:_pageSize];
}

-(void)loadDataAtPageIndex:(NSUInteger)pageIndex withPageSize:(NSUInteger)pageSize{
    
}


-(void)refreshDataAnimated:(BOOL)animated{
    if (animated) {
        [self.tableView.mj_header beginRefreshing];
    }
    else{
        [self headerRefresh];
    }
}




//-(void)endRefreshAndReloadTableView:(BOOL)reload{
//    [self endRefreshHeaderAndReloadTableView:reload];
//    [self endRefreshFooterAndReloadTableView:reload];
//}
-(void)endRefreshHeaderAndReloadTableView:(BOOL)reload{
    [self.tableView.mj_header endRefreshing];
    if (reload) {
        [self.tableView reloadData];
    }
    
}
-(void)endRefreshFooterAndReloadTableView:(BOOL)reload{
    [self endRefreshFooterAndReloadTableView:reload updatePageCounting:YES];
}
-(void)endRefreshFooterAndReloadTableView:(BOOL)reload updatePageCounting:(BOOL)update{
    if (update) {
        _currentPage = self.loadingPageIndex;
    }
    else{
        _loadingPageIndex = _currentPage;
    }
    
    if (reload) {
        [self.tableView reloadData];
    }
    [self.tableView.mj_footer endRefreshing];
}



#pragma mark -MEMORY_WARNING
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
