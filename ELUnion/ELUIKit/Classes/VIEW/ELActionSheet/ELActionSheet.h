//
//  ELActionSheet.h
//  Elottory
//
//  Created by 金秋成 on 16/7/31.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ELActionSheetBlock)(NSInteger index);

typedef void(^ELActionSheetCancelBlock)();

@interface ELActionSheet : UIView
//titles 可以是string  也可以是attributedString
-(instancetype)initWithTitles:(NSArray *)titles
                   andHandler:(ELActionSheetBlock)handler;

-(instancetype)initWithTitles:(NSArray *)titles
                   andHandler:(ELActionSheetBlock)handler
             andCancelHandler:(ELActionSheetCancelBlock)cancelHandler;


-(void)showInView:(UIView *)view;

-(void)show;

@end
