//
//  ELShareService.h
//  Elottory
//
//  Created by 金秋成 on 16/9/3.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ELPlatform.h"

typedef void(^ELShareServiceComplete)(BOOL success,NSError *error);

@interface ELShareService : NSObject

@property (nonatomic,strong)NSMutableArray * platformsArr;

+(instancetype)sharedService;

+(void)registerWXApp:(NSString *)appIdentifier;

+(void)registerQQApp:(NSString *)appIdentifier;

+(BOOL)handleUrl:(NSURL *)url;

-(NSArray *)enablePlatforms;

-(void)shareToPlatform:(ELShareService_Platform_Type)type
            andSubtype:(ELShareService_Platform_SubType)subtype
             withTitle:(NSString *)title
                andUrl:(NSString *)url
       andThunailImage:(NSData *)thumnailImage
             compelete:(ELShareServiceComplete)complete;

@end
