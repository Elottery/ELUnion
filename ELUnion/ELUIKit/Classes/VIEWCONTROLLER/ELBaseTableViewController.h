//
//  ELBaseTableViewController.h
//  Elottory
//
//  Created by 金秋成 on 16/8/21.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "ELBaseViewController.h"

@interface ELBaseTableViewController : ELBaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * tableView;

@property (nonatomic,strong)NSLayoutConstraint * topConstaint;
@property (nonatomic,strong)NSLayoutConstraint * leftConstaint;
@property (nonatomic,strong)NSLayoutConstraint * rightConstaint;
@property (nonatomic,strong)NSLayoutConstraint * bottomConstaint;



@property (nonatomic,assign,readonly)NSUInteger currentPage;

@property (nonatomic,assign,readonly)NSInteger loadingPageIndex;

@property (nonatomic,assign)NSInteger  startPage;//第一页的页码，默认为1

@property (nonatomic,assign)NSUInteger pageSize;

@property (nonatomic,assign)BOOL  hasHeader;

@property (nonatomic,assign)BOOL  hasFooter;

-(void)refreshDataAnimated:(BOOL)animated;
//-(void)endRefreshAndReloadTableView:(BOOL)reload;
-(void)endRefreshHeaderAndReloadTableView:(BOOL)reload;
-(void)endRefreshFooterAndReloadTableView:(BOOL)reload;//默认page增加1
-(void)endRefreshFooterAndReloadTableView:(BOOL)reload updatePageCounting:(BOOL)update;

-(void)loadDataAtPageIndex:(NSUInteger)pageIndex withPageSize:(NSUInteger)pageSize;

@end
