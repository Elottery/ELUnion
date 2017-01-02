//
//  ELTableViewCellManager.h
//  Pods
//
//  Created by 金秋成 on 2017/1/2.
//
//

#import <UIKit/UIKit.h>

@interface ELTableViewCellManager : NSObject

-(instancetype)initWithCell:(UITableViewCell *)cell;

-(void)setBottomLine:(BOOL)hasLine;

-(void)setTopLine:(BOOL)hasLine;

@end
