//
//  ELPaoMaDeng.h
//  Elottory
//
//  Created by 金秋成 on 16/7/30.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ELPaoMaDeng;

@protocol ELPaoMaDengDelegate <NSObject>

-(NSString *)paomadengView:(ELPaoMaDeng *)paomadeng titleForIndex:(NSUInteger)index;

-(NSUInteger )numberOfRowInPaomadeng;

@optional

/**
 *  点击事件
 *
 *  @param paomadeng
 *  @param index
 */
-(void)paomadeng:(ELPaoMaDeng *)paomadeng didSelectAtIndex:(NSUInteger)index;

/**
 *  返回自定义view，视图完全由自己控制，
 *  如果没有实现该协议方法，则默认一共一个简单的view 内部类（ELPaoMaDengCell）
 *  @param paomadeng
 *  @param index
 *  @return 自定义view
 */
-(UIView *)paomadengView:(ELPaoMaDeng *)paomadeng viewForIndex:(NSUInteger)index;

@end


@interface ELPaoMaDeng : UIView

@property (nonatomic,assign)NSTimeInterval rollingTime;

@property (nonatomic,strong)id<ELPaoMaDengDelegate> delegate;

-(void)reloadData;

@end
