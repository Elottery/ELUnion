//
//  ELShareViewController.m
//  Pods
//
//  Created by 金秋成 on 2016/11/11.
//
//

#import "ELShareViewController.h"
#import "ELShareActionSheet.h"
#import "UIViewController+ELTransition.h"


@interface ELShareViewController ()
@property (nonatomic,strong)ELShareActionSheet * actionSheet;
@end

@implementation ELShareViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.actionSheet showInView:self.view];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:0.4];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
//    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(ELShareActionSheet *)actionSheet{
    if (!_actionSheet) {
        __weak typeof(self) weakSelf = self;
        _actionSheet = [[ELShareActionSheet alloc]initWithHandler:^(NSInteger index, ELPlatform *platform, ELShareActionSheet *actionSheet,BOOL isCancel) {
            if (isCancel) {
                [weakSelf el_dismissViewControllerWithAnimationType:ELViewControllerTransitionAnimationTypeNoneAnimation animationComplete:^{
                    
                }];
            }
            else{
                [[ELShareService sharedService]shareToPlatform:platform.platform andSubtype:platform.subPlatform withTitle:weakSelf.shareTitle andUrl:weakSelf.shareURL andThunailImage:weakSelf.titleImage?UIImagePNGRepresentation(weakSelf.titleImage) : nil compelete:^(BOOL success, NSError *error) {
                    if (weakSelf.complete) {
                        weakSelf.complete(success,error);
                    }
                    [weakSelf el_dismissViewControllerWithAnimationType:ELViewControllerTransitionAnimationTypeNoneAnimation animationComplete:^{
                        
                    }];
                }];
            }
        }];
    }
    return _actionSheet;
}

-(void)el_dismissViewControllerWithAnimationType:(ELViewControllerTransitionAnimationType)type animationComplete:(ELTransitionCompeleteBlock)complete{
    [self.actionSheet dismissAction];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [super el_dismissViewControllerWithAnimationType:type animationComplete:complete];
    });
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self el_dismissViewControllerWithAnimationType:ELViewControllerTransitionAnimationTypeNoneAnimation animationComplete:^{
        
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
