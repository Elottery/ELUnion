//
//  DTUltimateViewController.m
//  Pods
//
//  Created by 金秋成 on 2016/11/9.
//
//

#import "DTUltimateViewController.h"

@interface DTUltimateViewController ()
@property (nonatomic,strong)UIView * privateView;
@property (nonatomic,strong)id<UIViewControllerContextTransitioning> context;
@end

@implementation DTUltimateViewController


-(instancetype)initWithType:(DTViewControllerType)type{
    self = [super init];
    if (self) {
        _dt_viewControllerType = type;
        
        
        
        
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.privateView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView *)privateView{
    if (!_privateView) {
        _privateView = [[UIView alloc]initWithFrame:self.view.bounds];
        _privateView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _privateView;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
