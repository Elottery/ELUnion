//
//  ELSocket.m
//  Pods
//
//  Created by Nicolas on 2016/10/21.
//
//

#import "ELSocket.h"
#import "ELSocketConstant.h"
#import "ELMessageSendingTaskManager.h"
#import "GCDAsyncSocket.h"


#import <CoreData/CoreData.h>

@interface ELSocket ()<GCDAsyncSocketDelegate>

@property (nonatomic,strong)GCDAsyncSocket * socket;
@property (nonatomic,strong)dispatch_queue_t socketQueue;
@property (nonatomic,strong)dispatch_queue_t delegateQueue;
@property (nonatomic,strong)ELMessageSendingTaskManager * taskManager;





@property (nonatomic,strong,readonly)NSString * password;


#pragma -mark db parts
//@property (nonatomic,strong)ELDBHelper * dbHelper;

@property (nonatomic,strong)NSManagedObjectContext       * context;
@property (nonatomic,strong)NSPersistentStoreCoordinator * coordinator;
@property (nonatomic,strong)NSManagedObjectModel         * model;
@property (nonatomic,strong)NSPersistentStore            * store;

@property (nonatomic,strong)NSURL * dbURL;

@property (nonatomic,strong)NSArray * dbModels;


@end

@implementation ELSocket

-(instancetype)initWithHost:(NSString *)host andPort:(NSInteger)port{
    self = [super init];
    if (self) {
        _host = host;
        _port = port;
        
        self.socketQueue = dispatch_queue_create("com.elottery.socketqueue", DISPATCH_QUEUE_CONCURRENT);
        self.delegateQueue = dispatch_queue_create("com.elottery.delegatequeue", DISPATCH_QUEUE_CONCURRENT);
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(becomeActive) name:UIApplicationWillEnterForegroundNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(resignActive) name:UIApplicationWillTerminateNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(resignActive) name:UIApplicationDidEnterBackgroundNotification object:nil];
    }
    return self;
}


-(void)dealloc{
    
}


#pragma -mark public method

-(void)connectWithUserName:(NSString *)username
               andPassword:(NSString *)password{
    if (_username == nil) {
        _username = username;
        _password = password;
        NSError * error = nil;
        if (![self.socket connectToHost:self.host onPort:self.port error:&error]) {
            NSLog(@"%@ %@",NSStringFromClass([self class]),error);
        }
    }
    else{
        NSLog(@"token 不能为空");
    }
}

-(void)reconnect{
    [self connectWithUserName:self.username andPassword:self.password];
}

-(void)disconnect{
    [self.socket disconnectAfterReadingAndWriting];
}

-(void)sendMessage:(ELSocketMessage *)message{
    __weak typeof(self) weakSelf = self;
    
    [self.taskManager addTaskWithMessageId:message.messageID block:^(NSError *error, NSInteger tag) {
        if (!error) {
            [weakSelf.socket writeData:[NSData data] withTimeout:ELSocketSendMessageTimeout tag:tag];
        }
    }];
}


#pragma -mark private method
-(void)loadStore{
    NSError * error = nil;
    _store = [self.coordinator addPersistentStoreWithType:NSSQLiteStoreType
                                            configuration:nil
                                                      URL:self.dbURL
                                                  options:nil
                                                    error:&error];
    if (error) {
        NSLog(@"创建store时出错 %@",error);
    }
    else{
        NSLog(@"数据库文件创建成功 : %@ ",_dbURL);
    }
}


-(void)saveContext{
    if ([self.context hasChanges]) {
        NSError * error = nil;
        if (![self.context save:&error]) {
            NSLog(@"coredata 保存失败%@",error);
        }
        NSLog(@"########%@",error);
    }
}


#pragma -mark GCDAsyncSocketDelegate

- (nullable dispatch_queue_t)newSocketQueueForConnectionFromAddress:(NSData *)address onSocket:(GCDAsyncSocket *)sock{
    NSLog(@"%@ -- %@",NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    return self.socketQueue;
}
- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket{
    NSLog(@"%@ -- %@",NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    NSLog(@"%@ -- %@",NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToUrl:(NSURL *)url{
    NSLog(@"%@ -- %@",NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSLog(@"%@ -- %@",NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}
- (void)socket:(GCDAsyncSocket *)sock didReadPartialDataOfLength:(NSUInteger)partialLength tag:(long)tag{
    NSLog(@"%@ -- %@",NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    NSLog(@"%@ -- %@",NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}

- (void)socket:(GCDAsyncSocket *)sock didWritePartialDataOfLength:(NSUInteger)partialLength tag:(long)tag{
    NSLog(@"%@ -- %@",NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}


- (NSTimeInterval)socket:(GCDAsyncSocket *)sock shouldTimeoutReadWithTag:(long)tag
                 elapsed:(NSTimeInterval)elapsed
               bytesDone:(NSUInteger)length{
    NSLog(@"%@ -- %@",NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    return 20;
}
- (NSTimeInterval)socket:(GCDAsyncSocket *)sock shouldTimeoutWriteWithTag:(long)tag
                 elapsed:(NSTimeInterval)elapsed
               bytesDone:(NSUInteger)length{
    NSLog(@"%@ -- %@",NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    return 20;
}

- (void)socketDidCloseReadStream:(GCDAsyncSocket *)sock{
    NSLog(@"%@ -- %@",NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(nullable NSError *)err{
    NSLog(@"%@ -- %@",NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}

- (void)socketDidSecure:(GCDAsyncSocket *)sock{
    NSLog(@"%@ -- %@",NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}

- (void)socket:(GCDAsyncSocket *)sock didReceiveTrust:(SecTrustRef)trust
completionHandler:(void (^)(BOOL shouldTrustPeer))completionHandler{
    NSLog(@"%@ -- %@",NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}

- (void)becomeActive{
    [self loadStore];
}

- (void)resignActive{
    [self saveContext];
}

-(GCDAsyncSocket *)socket{
    if (!_socket) {
        _socket = [[GCDAsyncSocket alloc] initWithDelegate:self
                                             delegateQueue:self.delegateQueue
                                               socketQueue:self.socketQueue];
    }
    return _socket;
}

-(ELMessageSendingTaskManager *)taskManager{
    if (!_taskManager) {
        _taskManager = [[ELMessageSendingTaskManager alloc]init];
    }
    return _taskManager;
}

//-(ELDBHelper *)dbHelper{
//    if (!_dbHelper) {
//        _dbHelper = [[ELDBHelper alloc]initWithDBFilePath:self.dbURL andModels:self.dbModels];
//    }
//    return _dbHelper;
//}


-(NSURL *)dbURL{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString * dbPath = [docDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite",self.username]];
    _dbURL = [NSURL URLWithString:dbPath];
    return _dbURL;
}

-(NSArray *)dbModels{
    if (!_dbModels) {
        NSString * resoucePath = [[NSBundle mainBundle]pathForResource:@"SocketDBModel" ofType:@"xcdatamodeld"];
        NSManagedObjectModel * model = [[NSManagedObjectModel alloc] initWithContentsOfURL:[NSURL URLWithString:resoucePath]];
        _dbModels = @[model];
    }
    return _dbModels;
}

-(NSManagedObjectModel *)model{
    if (!_model) {
        _model = [NSManagedObjectModel mergedModelFromBundles:nil];
    }
    return _model;
}

-(NSPersistentStoreCoordinator *)coordinator{
    if (!_coordinator) {
        _coordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:self.model];
    }
    return _coordinator;
}

-(NSManagedObjectContext *)context{
    if (!_context) {
        _context = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_context setPersistentStoreCoordinator:self.coordinator];
        
    }
    return _context;
}

@end
