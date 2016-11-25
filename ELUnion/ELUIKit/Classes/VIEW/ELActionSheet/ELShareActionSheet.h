//
//  ELShareActionSheet.h
//  Elottory
//
//  Created by 金秋成 on 16/9/3.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELShareService.h"

@class ELShareActionSheet;

typedef void(^ShareActionSheetClick)(NSInteger index , ELPlatform * platform,ELShareActionSheet * actionSheet,BOOL isCancel);

@interface ELShareActionSheet : UIView

-(instancetype)initWithHandler:(ShareActionSheetClick)handler;

-(void)showInView:(UIView *)view;

-(void)dismissAction;
@end
