//
//  ELSocketMessage.h
//  Pods
//
//  Created by Nicolas on 2016/10/21.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ELSocketMessageSendState) {
    ELSocketMessageSendSuccess = 1 << 0,
    ELSocketMessageSendFail    = 1 << 1,
    ELSocketMessageSending     = 1 << 2,
};

@interface ELSocketMessage : NSObject

@property (nonatomic,strong)NSString * messageID;


//+(NSArray<ELSocketMessage *> *)getMessagesByState:(ELSocketMessageSendState)state
//                                         offset:(NSInteger)offset
//                                          limit:(NSInteger)limit;

@end
