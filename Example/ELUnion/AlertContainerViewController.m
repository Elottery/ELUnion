//
//  AlertContainerViewController.m
//  ELUIKit
//
//  Created by 金秋成 on 16/10/13.
//  Copyright © 2016年 Nicolas. All rights reserved.
//

#import "AlertContainerViewController.h"
#import <ELUnion/ELAlertContainerView.h>
@interface AlertContainerViewController ()

@end

@implementation AlertContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)showBtnDidClick:(id)sender {
    NSInteger btnCount = [self.textField.text integerValue];
    
    //title
    NSAttributedString * title = [[NSAttributedString alloc]initWithString:@"title"];
    //内部视图  子视图
    UIView * subView = [[UIView alloc]init];
    subView.backgroundColor = [UIColor redColor];
    
    
    ELAlertContainerView * alert = [[ELAlertContainerView alloc]initWithTitle:title andSubview:subView andSubViewRatio:2];
    

    NSMutableArray * arr = [NSMutableArray new];
    for (NSInteger i = 0; i < btnCount; i ++) {
        
        NSAttributedString * btnTitle = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"btn%ld",(long)i]];
        
        ELAlertContainerViewActionItem * item = [ELAlertContainerViewActionItem actionWithTitle:btnTitle andBackgroundColor:[UIColor whiteColor] andHandler:^{
            
        }];
        [arr addObject:item];
    }
    
    //添加按钮属性
    [alert addItems:arr];
    
    //show
    [alert showInView:self.view];

}
@end
