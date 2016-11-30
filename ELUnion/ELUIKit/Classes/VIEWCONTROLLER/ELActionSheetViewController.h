//
//  ELActionSheetViewController.h
//  Pods
//
//  Created by 金秋成 on 2016/11/27.
//
//

#import <ELUnion/ELBaseViewController.h>

typedef void(^ELActionSheetViewControllerCancelBlock)();
typedef void(^ELActionSheetViewControllerClickBlock)(NSInteger index);


@interface ELActionSheetViewController : ELBaseViewController
-(instancetype)initWithTitles:(NSArray *)titles
                     didClick:(ELActionSheetViewControllerClickBlock)click
                       cancel:(ELActionSheetViewControllerCancelBlock)cancel;

@end
