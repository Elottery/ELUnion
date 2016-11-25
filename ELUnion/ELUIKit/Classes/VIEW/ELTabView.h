//
//  ELTabView.h
//  Pods
//
//  Created by 金秋成 on 2016/11/21.
//
//

#import <UIKit/UIKit.h>


typedef NSArray<NSString *> *(^ELTabViewReturnBlock)(NSUInteger titleIndex);

typedef void(^ELTabViewClickBlock)(NSUInteger titleIndex,NSUInteger bodyIndex);


@interface ELTabView : UIView

//@property (nonatomic,assign)NSUInteger cellCountOfSingleLine;

@property (nonatomic,copy)ELTabViewReturnBlock dataSource;

@property (nonatomic,copy)ELTabViewClickBlock  delegate;

@property (nonatomic,assign,getter=selectedIndex)NSInteger selectIndex;

@property (nonatomic,strong)NSArray<NSString *> * tabTitles;

@property (nonatomic,strong)NSArray<NSString *> * bodyTitles;

@end
