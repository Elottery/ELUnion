//
//  ELActionSheetViewController.m
//  Pods
//
//  Created by 金秋成 on 2016/11/27.
//
//

#import "ELActionSheetViewController.h"
#import "ELActionSheet.h"
@interface ELActionSheetViewController ()
@property (nonatomic,strong)ELActionSheet * actionSheet;


@property (nonatomic,strong)NSArray * titles;
@property (nonatomic,copy)ELActionSheetViewControllerClickBlock click;
@property (nonatomic,copy)ELActionSheetViewControllerCancelBlock  cancel;
@end

@implementation ELActionSheetViewController
-(instancetype)initWithTitles:(NSArray *)titles
                     didClick:(ELActionSheetViewControllerClickBlock)click
                       cancel:(ELActionSheetViewControllerCancelBlock)cancel{
    self = [super init];
    if (self) {
        self.click = click;
        self.cancel = cancel;
        self.titles = titles;
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.actionSheet showInView:self.view];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:0.4];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(ELActionSheet *)actionSheet{
    if (!_actionSheet) {
        __weak typeof(self) weakSelf = self;
        _actionSheet = [[ELActionSheet alloc]initWithTitles:self.titles andHandler:^(NSInteger index) {
            [self el_dismissViewControllerWithAnimationType:ELViewControllerTransitionAnimationTypeNoneAnimation animationComplete:^{
                if (weakSelf.click) {
                    weakSelf.click(index);
                }
            }];
        } andCancelHandler:^{
            
            [self el_dismissViewControllerWithAnimationType:ELViewControllerTransitionAnimationTypeNoneAnimation animationComplete:^{
                if (weakSelf.cancel) {
                    weakSelf.cancel();
                }
            }];
        }];
    }
    return _actionSheet;
}

-(void)el_dismissViewControllerWithAnimationType:(ELViewControllerTransitionAnimationType)type animationComplete:(ELTransitionCompeleteBlock)complete{
    [self.actionSheet dismissActionSheet];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [super el_dismissViewControllerWithAnimationType:type animationComplete:complete];
    });
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    __weak typeof(self) weakSelf = self;
    [self el_dismissViewControllerWithAnimationType:ELViewControllerTransitionAnimationTypeNoneAnimation animationComplete:^{
        if (weakSelf.cancel) {
            weakSelf.cancel();
        }
    }];
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
