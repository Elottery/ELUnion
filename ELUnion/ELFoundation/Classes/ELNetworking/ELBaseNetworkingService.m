//
//  ELBaseNetworkingService.m
//  ELNetworking
//
//  Created by 金秋成 on 16/7/8.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "ELBaseNetworkingService.h"
#import "EncryptUtil.h"
#define EL_API_DOMAIN @"cn.intradak.elottery.api"
#define EL_PRECHECK_DOMAIN @"cn.intradak.elottery.precheckapi"


NSString * const ELBaseNetworkingService_JSESSIONID = @"jsessionid";
NSString * const ELBaseNetworkingService_HEADER = @"smthit-api-header";
NSString * const ELBaseNetworkingService_AGENT= @"agent";

@interface ELBaseNetworkingService ()
@property (nonatomic,strong)AFURLSessionManager * sessionManager;
@property (nonatomic,strong)NSURLSessionConfiguration * sessionConfig;
@end

@implementation ELBaseNetworkingService
static ELBaseNetworkingService * _sharedService;
+(instancetype)sharedService{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedService = [[ELBaseNetworkingService alloc]init];
    });
    return _sharedService;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.sessionManager = [[AFURLSessionManager alloc]initWithSessionConfiguration:self.sessionConfig];
        AFJSONResponseSerializer * jsonSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        jsonSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain", nil];
        jsonSerializer.removesKeysWithNullValues = YES;
        
        self.sessionManager.responseSerializer = jsonSerializer;
//        NSString * cerPath = [[NSBundle mainBundle]pathForResource:@"ticai.cn" ofType:@"crt"];
//        NSData * cerData = [NSData dataWithContentsOfFile:cerPath];
#if DEBUG
        AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
        policy.allowInvalidCertificates = YES;//是否允许使用自签名证书
        policy.validatesDomainName = NO;
        self.sessionManager.securityPolicy = policy;
        __weak typeof(self) weakSelf = self;
        [self.sessionManager setSessionDidBecomeInvalidBlock:^(NSURLSession * _Nonnull session, NSError * _Nonnull error) {
            NSLog(@"setSessionDidBecomeInvalidBlock");
        }];
        
        
        [self.sessionManager setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition(NSURLSession*session, NSURLAuthenticationChallenge *challenge, NSURLCredential *__autoreleasing*_credential) {
            NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
            __autoreleasing NSURLCredential *credential =nil;
            if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
                if([weakSelf.sessionManager.securityPolicy evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:challenge.protectionSpace.host]) {
                    credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
                    if(credential) {
                        disposition =NSURLSessionAuthChallengeUseCredential;
                    } else {
                        disposition =NSURLSessionAuthChallengePerformDefaultHandling;
                    }
                } else {
                    disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
                }
            } else {
                // client authentication
                SecIdentityRef identity = NULL;
                SecTrustRef trust = NULL;
                NSString *p12 = [[NSBundle mainBundle] pathForResource:@"ticai.cn"ofType:@"crt"];
                NSFileManager *fileManager =[NSFileManager defaultManager];
                
                if(![fileManager fileExistsAtPath:p12])
                {
                    NSLog(@"client.p12:not exist");
                }
                else
                {
                    NSData *PKCS12Data = [NSData dataWithContentsOfFile:p12];
                    
                    if ([[weakSelf class]extractIdentity:&identity andTrust:&trust fromPKCS12Data:PKCS12Data])
                    {
                        SecCertificateRef certificate = NULL;
                        SecIdentityCopyCertificate(identity, &certificate);
                        const void*certs[] = {certificate};
                        CFArrayRef certArray =CFArrayCreate(kCFAllocatorDefault, certs,1,NULL);
                        credential =[NSURLCredential credentialWithIdentity:identity certificates:(__bridge  NSArray*)certArray persistence:NSURLCredentialPersistencePermanent];
                        disposition =NSURLSessionAuthChallengeUseCredential;
                    }
                }
            }
            *_credential = credential;
            return disposition;
        }];
        
#endif
    }
    return self;
}
+(BOOL)extractIdentity:(SecIdentityRef*)outIdentity andTrust:(SecTrustRef *)outTrust fromPKCS12Data:(NSData *)inPKCS12Data {
    OSStatus securityError = errSecSuccess;
    //client certificate password
    NSDictionary*optionsDictionary = [NSDictionary dictionaryWithObject:@"ticai"
                                                                 forKey:(__bridge id)kSecImportExportPassphrase];
    
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import((__bridge CFDataRef)inPKCS12Data,(__bridge CFDictionaryRef)optionsDictionary,&items);
    
    if(securityError == 0) {
        CFDictionaryRef myIdentityAndTrust =CFArrayGetValueAtIndex(items,0);
        const void*tempIdentity =NULL;
        tempIdentity= CFDictionaryGetValue (myIdentityAndTrust,kSecImportItemIdentity);
        *outIdentity = (SecIdentityRef)tempIdentity;
        const void*tempTrust =NULL;
        tempTrust = CFDictionaryGetValue(myIdentityAndTrust,kSecImportItemTrust);
        *outTrust = (SecTrustRef)tempTrust;
    } else {
        NSLog(@"Failedwith error code %d",(int)securityError);
        return NO;
    }
    return YES;
}


-   (void)request:(ELReturnRequestBlock)requestBlock
    withUserToken:(ELReturnStringBlock)token
         didStart:(ELNormalBlock)startBlock
   uploadProgress:(ELProgressBlock)uploadProgressBlock
 downloadProgress:(ELProgressBlock)downloadProgressBlock
        didFinish:(ELResponseBlock)responseBlock{
    id<ELRequestProtocol> req = requestBlock();
    //用户唯一标识
    NSString * tokenStr = token();
    NSURLRequest * request = [self URLRequestWithRequest:req andToken:tokenStr];
    //如果该请求需要登陆权限 同时用户表示为空时  不进行网络请求 并返回error
    if ([req needTokenAuth] && (tokenStr == nil || tokenStr.length == 0)) {
        NSError * error = [NSError errorWithDomain:EL_PRECHECK_DOMAIN
                                              code:501
                                          userInfo:@{NSLocalizedFailureReasonErrorKey:@"请登录"}];
        responseBlock(nil,error);
        return;
    }
    
    NSURLSessionDataTask * dataTask = [self.sessionManager dataTaskWithRequest:request
                                                                uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
                                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                                        uploadProgressBlock(uploadProgress);
                                                                    });
                                                                }
                                                              downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
                                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                                      downloadProgressBlock(downloadProgress);
                                                                  });
                                                              }
                                                             completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                                                 
                                                                 if (error) {
                                                                     responseBlock(nil,error);
                                                                 }
                                                                 else{
                                                                     id<ELResponseProtocol> resp = [self responseWithResponseObj:responseObject andRequest:req];
                                                                     if (resp.status == 200) {
                                                                         
                                                                     }
                                                                     else if(resp.status == 500){
                                                                         error = [NSError errorWithDomain:EL_API_DOMAIN code:500 userInfo:@{NSLocalizedFailureReasonErrorKey:resp.memo,@"protocol-id":[req protocolId]}];
                                                                     }
                                                                     else if (resp.status == 501) {
                                                                         error = [NSError errorWithDomain:EL_API_DOMAIN code:501 userInfo:@{NSLocalizedFailureReasonErrorKey:resp.memo,@"protocol-id":[req protocolId]}];
                                                                     }
                                                                     else{
                                                                         error = [NSError errorWithDomain:EL_API_DOMAIN code:resp.status userInfo:@{NSLocalizedFailureReasonErrorKey:resp.memo,@"protocol-id":[req protocolId]}];
                                                                     }
                                                                     responseBlock(resp,error);
                                                                 }
                                                             }];
    startBlock();
    [dataTask resume];
}


-(NSURLRequest *)URLRequestWithRequest:(id<ELRequestProtocol>)request andToken:(NSString *)token{
    
    NSData  * requestData = nil;
    if ([request respondsToSelector:@selector(isFileData)]&&[request isFileData]) {
        requestData = [request fileData];
    }
    else{
        requestData = [[request toJSONString] dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    //组装请求
    NSMutableURLRequest * URLRequest = nil;
    NSString * URLStr = [NSString stringWithFormat:@"%@",self.defaultConfig.HOST];
    URLRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLStr] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:40];
    
    [URLRequest setHTTPMethod:@"POST"];
    if (token) {
        [URLRequest setValue:token forHTTPHeaderField:ELBaseNetworkingService_JSESSIONID];
    }
    [URLRequest setValue:[self wokeHeaderWithProtocolId:[request protocolId]] forHTTPHeaderField:ELBaseNetworkingService_HEADER];
    [URLRequest setValue:[self agent] forHTTPHeaderField:ELBaseNetworkingService_AGENT];
    [URLRequest setHTTPBody:requestData];
    return URLRequest;
}

-(id<ELResponseProtocol>)responseWithResponseObj:(id)responseObj andRequest:(id<ELRequestProtocol>)req{
    return [[req responseClass]responseWithDictionary:responseObj];
}

-(NSString *)wokeHeaderWithProtocolId:(NSString *)protocolId{
    NSString * woke = [NSString stringWithFormat:@"client-version:%@;protocol-id:%@;c-time=%ld;",
                       self.defaultConfig.clientVersion,
                       protocolId,
                       (long)[NSDate timeIntervalSinceReferenceDate]];
    return woke;
}

-(NSString *)agent{
    return  [NSString stringWithFormat:@"%@-%@",[UIDevice currentDevice].systemName,[UIDevice currentDevice].systemVersion];
}






@end
