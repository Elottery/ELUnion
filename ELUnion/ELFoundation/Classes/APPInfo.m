//
//  APPInfo.m
//  Elottory
//
//  Created by 金秋成 on 16/8/19.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "APPInfo.h"

@implementation APPInfo
+(NSString *)APIHOST{
#if DEBUG
    return @"http://101.200.76.234:58080/mobile";
#else
    return @"https://app.nmg.ticai.cn";
#endif
}
+(NSString *)apiVersion{
    return @"1.0";
}

+(NSString *)clientVersion{
    return @"1.0";
}
@end
