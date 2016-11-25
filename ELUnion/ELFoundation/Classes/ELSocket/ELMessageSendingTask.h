//
//  ELMessageSendingTask.h
//  Pods
//
//  Created by Nicolas on 2016/10/21.
//
//

#import <Foundation/Foundation.h>
#import "ELSocketMessage.h"


@interface ELMessageSendingTask : NSObject

@property (nonatomic,assign)NSInteger tag;

@property (nonatomic,assign)float progress;

@property (nonatomic,strong)ELSocketMessage * message;

@end
