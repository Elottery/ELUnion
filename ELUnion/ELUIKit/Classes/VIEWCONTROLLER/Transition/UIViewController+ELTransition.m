//
//  UIViewController+ELTransition.m
//  Pods
//
//  Created by 金秋成 on 2016/11/16.
//
//

#import "UIViewController+ELTransition.h"
#import <objc/runtime.h>

@implementation UIViewController (ELTransition)
-(void)setEl_transitionDelegate:(ELModalAnimationTransitionDelegate *)el_transitionDelegate{
    objc_setAssociatedObject(self, @selector(el_transitionDelegate), el_transitionDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(ELModalAnimationTransitionDelegate *)el_transitionDelegate{
    return  objc_getAssociatedObject(self, _cmd);
}

- (void)el_presentViewController:(UIViewController *)viewController
               withAnimationType:(ELViewControllerTransitionAnimationType)type
               animationComplete:(ELTransitionCompeleteBlock)complete{
    viewController.modalPresentationStyle = UIModalPresentationCustom;
    self.el_transitionDelegate = [[ELModalAnimationTransitionDelegate alloc]init];
    self.el_transitionDelegate.presentType = type;
    viewController.transitioningDelegate = self.el_transitionDelegate;
    [self presentViewController:viewController animated:YES completion:^{
        if (complete) {
            complete();
        }
    }];
    
}

- (void)el_dismissViewControllerWithAnimationType:(ELViewControllerTransitionAnimationType)type
                                animationComplete:(ELTransitionCompeleteBlock)complete{
    
    if ([self.transitioningDelegate isKindOfClass:[ELModalAnimationTransitionDelegate class]]) {
        [(ELModalAnimationTransitionDelegate *)self.transitioningDelegate setDismissType:type];
        [self dismissViewControllerAnimated:YES completion:^{
            if (complete) {
                complete();
            }
        }];
    }
}
@end
