//
//  UITableViewCell+ELExtension.m
//  Pods
//
//  Created by 金秋成 on 2017/1/2.
//
//

#import "UITableViewCell+ELExtension.h"
#import <objc/runtime.h>

@implementation UITableViewCell (ELExtension)
//@property (nonatomic,assign)BOOL bottomLine;
//@property (nonatomic,assign)BOOL rightLine;
//@property (nonatomic,assign)BOOL leftLine;
//@property (nonatomic,assign)BOOL topLine;

-(ELTableViewCellManager *)cellmanager{
    
    ELTableViewCellManager * manager = objc_getAssociatedObject(self, _cmd);
    
    if (!manager) {
        __weak typeof(self) weakSelf = self;
        manager = [[ELTableViewCellManager alloc]initWithCell:weakSelf];
        objc_setAssociatedObject(self, _cmd, manager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return manager;
}
@end
