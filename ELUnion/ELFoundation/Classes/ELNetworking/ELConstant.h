//
//  ELConstant.h
//  ELNetworking
//
//  Created by 金秋成 on 16/8/19.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#ifndef ELConstant_h
#define ELConstant_h

typedef NS_ENUM(NSUInteger, ELResponseStatus) {
    ELResponseStatus_Error = 500,
    ELResponseStatus_Success = 200,
    ELResponseStatus_NotLogin = 501,
};

typedef NS_ENUM(NSUInteger, ELRequestDataType) {
    ELRequestDataType_JSON,
    ELRequestDataType_XML,
};



#endif /* ELConstant_h */
