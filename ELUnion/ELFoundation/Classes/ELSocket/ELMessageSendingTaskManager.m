//
//  ELMessageSendingTaskManager.m
//  Pods
//
//  Created by Nicolas on 2016/10/21.
//
//

#import "ELMessageSendingTaskManager.h"



@interface ELMessageSendingTaskManager ()
@property (nonatomic,strong)NSMutableArray<NSDictionary *> * tasks;
@end

@implementation ELMessageSendingTaskManager


- (instancetype)init
{
    self = [super init];
    if (self) {
        _tasks = [NSMutableArray new];
    }
    return self;
}


-(void)addTaskWithMessageId:(NSString *)messageId
                      block:(ELMessageSendingBlock)block{
    @synchronized (_tasks) {
        for (NSDictionary * dict in self.tasks) {
            NSString * msgId = dict[@"msgId"];
            if ([msgId isEqualToString:messageId]) {
                NSError * error = [NSError errorWithDomain:@"com.elottery.socket.task" code:500 userInfo:@{NSLocalizedDescriptionKey:@"任务正在执行"}];
                block(error,[dict[@"tag"] integerValue]);
                return;
            }
        }
        
        
        NSInteger tag = 0;
        NSDictionary * dict = self.tasks.lastObject;
        if (dict) {
            tag = [dict[@"tag"] integerValue];
        }
        
        [_tasks addObject:@{@"msgId" : messageId, @"tag" : @(tag)}];
        block(nil,tag);
        
        
    }
}


-(void)removeTaskOfTag:(NSInteger)tag{
    @synchronized (_tasks) {
        for (NSDictionary * dict in self.tasks) {
            NSInteger savedTag = [dict[@"tag"] integerValue];
            if (savedTag == tag) {
                [self.tasks removeObject:dict];
            }
        }
    }
}




@end
