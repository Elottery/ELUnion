//
//  ELActionSheetContainerController.h
//  Pods
//
//  Created by 金秋成 on 2017/1/7.
//
//

#import <ELUnion/ELBaseViewController.h>


typedef void(^ELActionSheetContainerControllerOPBlock)();

@interface ELActionSheetContainerController : ELBaseViewController
-(instancetype)initWithAttributedTitle:(NSAttributedString *)title
                  andSubView:(UIView *)subView
            andSubViewHeight:(CGFloat)height
      confirmAttributedTitle:(NSAttributedString *)confirmTitle
              confirmHandler:(ELActionSheetContainerControllerOPBlock)confirmHandler
       cancelAttributedTitle:(NSAttributedString *)cancelTitle
               cancelHandler:(ELActionSheetContainerControllerOPBlock)cancelHandler;

-(instancetype)initWithTitle:(NSString *)title
                  andSubView:(UIView *)subView
            andSubViewHeight:(CGFloat)height
                confirmTitle:(NSString *)confirmTitle
              confirmHandler:(ELActionSheetContainerControllerOPBlock)confirmHandler
                 cancelTitle:(NSString *)cancelTitle
               cancelHandler:(ELActionSheetContainerControllerOPBlock)cancelHandler;



@end
