//
//  ELShareService.m
//  Elottory
//
//  Created by 金秋成 on 16/9/3.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "ELShareService.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"

@interface ELShareService()<WXApiDelegate,TencentSessionDelegate,QQApiInterfaceDelegate>

@property (nonatomic,strong)TencentOAuth   * tencentOAuth;
@property (nonatomic,copy)ELShareServiceComplete complete;
-(void)addEnablePlatform:(ELPlatform *)platformInfo;
@end


@implementation ELShareService

static ELShareService * _sharedService;


+(instancetype)sharedService{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedService = [[ELShareService alloc]init];
    });
    return _sharedService;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.platformsArr = [NSMutableArray new];
    }
    return self;
}


+(void)registerWXApp:(NSString *)appId{
//    if ([WXApi isWXAppInstalled]) {
    
        [WXApi registerApp:appId];
        ELPlatform * p = [[ELPlatform alloc]init];
        p.platform    = ELShareService_Platform_WECHAT;
        p.subPlatform = ELShareService_Platform_WECHAT_SESSION;
        p.title       = @"微信";
        p.detailTitle = @"微信好友";
        
        [[[self sharedService] platformsArr]addObject:p];
        
        
        p             = [[ELPlatform alloc]init];
        p.platform    = ELShareService_Platform_WECHAT;
        p.subPlatform = ELShareService_Platform_WECHAT_TIMELINE;
        p.title       = @"微信";
        p.detailTitle = @"微信朋友圈";
        [[[self sharedService] platformsArr]addObject:p];
//    }
}

+(void)registerQQApp:(NSString *)appId{
//    if ([TencentOAuth iphoneQQInstalled]) {
        TencentOAuth *tencentOAuth = [[TencentOAuth alloc] initWithAppId:appId
                                                             andDelegate:self];
        
        ELPlatform *p = [[ELPlatform alloc]init];
        p.platform    = ELShareService_Platform_QQ;
        p.subPlatform = ELShareService_Platform_QQ_SESSION;
        p.title       = @"QQ";
        p.detailTitle = @"QQ好友";
        [[[self sharedService] platformsArr]addObject:p];
        
        p             = [[ELPlatform alloc]init];
        p.platform    = ELShareService_Platform_QQ;
        p.subPlatform = ELShareService_Platform_QQ_ZONE;
        p.title       = @"QQ";
        p.detailTitle = @"QQ空间";
        [[[self sharedService] platformsArr]addObject:p];
//    }
}

-(NSArray *)enablePlatforms{
    return self.platformsArr;
}


+(BOOL)handleUrl:(NSURL *)url{
    
//    if ([url.absoluteString containsString:@"wechat"]) {
//        return [WXApi handleOpenURL:url delegate:[self sharedService]];
//    }
//    else{
//        return [TencentOAuth HandleOpenURL:url];
//    }
    BOOL tencentResult = [QQApiInterface  handleOpenURL:url delegate:[self sharedService]];
    BOOL wxResult      = [WXApi handleOpenURL:url delegate:[self sharedService]];
    return tencentResult || wxResult;
}



-(void)shareToPlatform:(ELShareService_Platform_Type)type
            andSubtype:(ELShareService_Platform_SubType)subtype
             withTitle:(NSString *)title
                andUrl:(NSString *)url
       andThunailImage:(NSData *)thumnailImage
             compelete:(ELShareServiceComplete)complete{
    self.complete = complete;
    if (type == ELShareService_Platform_WECHAT) {
        
//        if (![WXApi isWXAppInstalled]) {
//            NSError * error = [NSError errorWithDomain:@"share" code:500 userInfo:@{NSLocalizedDescriptionKey:@"您的设备没有安装微信"}];
//            self.complete(NO,error);
//            return;
//        }
        
        SendMessageToWXReq * req = [[SendMessageToWXReq alloc]init];
        WXMediaMessage * message = [WXMediaMessage message];
        message.title = title;
        WXWebpageObject * webObject = [WXWebpageObject object];
        webObject.webpageUrl = url;
        message.mediaObject = webObject;
        message.thumbData = thumnailImage;
        req.message = message;
        if (subtype == ELShareService_Platform_WECHAT_SESSION) {
            req.scene = WXSceneSession;
        }
        else{
            req.scene = WXSceneTimeline;
        }
        
        [WXApi sendReq:req];
    }
    else{

        
        QQApiNewsObject * shareObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:url] title:title description:@""   previewImageData:thumnailImage];
        
        SendMessageToQQReq * req = [SendMessageToQQReq reqWithContent:shareObj];
        req.type = ESENDMESSAGETOQQREQTYPE;
        QQApiSendResultCode resultCode;
        if (subtype == ELShareService_Platform_QQ_SESSION) {
            resultCode = [QQApiInterface sendReq:req];
            NSLog(@"%d",resultCode);
        }
        else{
            resultCode = [QQApiInterface SendReqToQZone:req];
            
        }
        
        switch (resultCode)
        {
            case EQQAPIQQNOTINSTALLED:
            {
                NSLog(@"未安装手机QQ");
                break;
            }
            case EQQAPISENDFAILD:
            {
                NSLog(@"分享失败");
                break;
            }
            default:
            {
                break;
            }
        }
        
        
    }
}

-(void) onReq:(BaseReq*)req{
    
}

-(void) onResp:(id)response{
    if ([response isKindOfClass:[QQBaseResp class]]) {//qq
        QQBaseResp * resp = (QQBaseResp *)response;
        if ([resp.result isEqualToString:@"0"]) {//成功
            if (self.complete) {
                self.complete(YES,nil);
            }
        }
        else{
            if (self.complete) {
                NSError * error = [NSError errorWithDomain:@"share" code:[resp.result integerValue] userInfo:@{NSLocalizedFailureReasonErrorKey:resp.errorDescription?:@"分享失败"}];
                self.complete(NO,error);
            }
        }
    }
    else{
        BaseResp * resp = (BaseResp *)response;
        if (resp.errCode == 0) {//成功
            if (self.complete) {
                self.complete(YES,nil);
            }
        }
        else{
            if (self.complete) {
                NSError * error = [NSError errorWithDomain:@"share" code:resp.errCode userInfo:@{NSLocalizedFailureReasonErrorKey:resp.errStr?:@"分享失败"}];
                self.complete(NO,error);
            }
        }
    }
    
}

@end
