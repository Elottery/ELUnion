//
//  ELMessageSendingTaskManager.h
//  Pods
//
//  Created by Nicolas on 2016/10/21.
//
//

#import <Foundation/Foundation.h>
#import "ELMessageSendingTask.h"

typedef void(^ELMessageSendingBlock)(NSError * error , NSInteger tag);

@interface ELMessageSendingTaskManager : NSObject

//@property (nonatomic,assign,readonly)NSInteger maxTag;

-(void)addTaskWithMessageId:(NSString *)messageId
                      block:(ELMessageSendingBlock)block;


-(void)removeTaskOfTag:(NSInteger)tag;

@end
