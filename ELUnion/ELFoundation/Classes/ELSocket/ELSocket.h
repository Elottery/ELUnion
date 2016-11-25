//
//  ELSocket.h
//  Pods
//
//  Created by Nicolas on 2016/10/21.
//
//

#import <Foundation/Foundation.h>
#import "ELSocketMessage.h"
typedef NS_ENUM(NSUInteger, ELSocketConnectionState) {
    ELSocketConnectionState_connecting,
    ELSocketConnectionState_connected,
    ELSocketConnectionState_reconnecting,
    ELSocketConnectionState_disconnected,
};





@class ELSocket;

@protocol ELSocketDelegate <NSObject>

-(void)socket:(ELSocket *)socket didChangeConnectionState:(ELSocketConnectionState)state
                                                    error:(NSError *)error;

-(void)socket:(ELSocket *)socket didRecieveMessage:(ELSocketMessage *)message;

-(void)socket:(ELSocket *)socket didSendMessage:(ELSocketMessage *)message
                                          error:(NSError *)error;

@end

@interface ELSocket : NSObject
@property (nonatomic,strong,readonly)NSString * host;
@property (nonatomic,assign,readonly)NSInteger  port;
@property (nonatomic,strong,readonly)NSString * username;
@property (nonatomic,strong)id <ELSocketDelegate> delegate;

-(instancetype)initWithHost:(NSString *)host andPort:(NSInteger)port;

-(void)connectWithUserName:(NSString *)username andPassword:(NSString *)password;
    
-(void)reconnect;
    
-(void)disconnect;

-(void)sendMessage:(ELSocketMessage *)message;


    
@end
