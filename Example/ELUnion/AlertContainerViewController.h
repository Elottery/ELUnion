//
//  AlertContainerViewController.h
//  ELUIKit
//
//  Created by 金秋成 on 16/10/13.
//  Copyright © 2016年 Nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertContainerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textField;
- (IBAction)showBtnDidClick:(id)sender;

@end
