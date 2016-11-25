//
//  ELAlertContainerView.h
//  Elottory
//
//  Created by 金秋成 on 16/9/15.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ELAlertContainerViewActionItemHandler)();

@interface ELAlertContainerViewActionItem : NSObject

@property (nonatomic,copy)  ELAlertContainerViewActionItemHandler handler;
@property (nonatomic,strong)UIColor              * highlitedBackgroundColor;
@property (nonatomic,strong)NSAttributedString   * highlitedTitle;

+(instancetype)actionWithTitle:(NSAttributedString *)title
            andBackgroundColor:(UIColor *)backgroundColor
                    andHandler:(ELAlertContainerViewActionItemHandler)handler;

@end




@interface ELAlertContainerView : UIView

-(instancetype)initWithTitle:(NSAttributedString *)title
                  andSubview:(UIView *)subview
             andSubViewRatio:(CGFloat)ratio;//subview的宽高比 比如:1/2

-(void)addItems:(NSArray<ELAlertContainerViewActionItem *> *)itemsArr;

-(void)showInView:(UIView *)view;

@end
