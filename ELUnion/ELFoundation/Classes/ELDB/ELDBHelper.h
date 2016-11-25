//
//  ELDBHelper.h
//  Elottory
//
//  Created by 金秋成 on 16/9/7.
//  Copyright © 2016年 金秋成. All rights reserved.
//


#import <CoreData/CoreData.h>

@interface ELDBHelper : NSObject

@property (nonatomic,strong,readonly)NSURL * dbFilePath;

@property (nonatomic,strong,readonly)NSManagedObjectContext  * context;

-(instancetype)initWithDBFilePath:(NSURL *)filePath;

-(instancetype)initWithDBFilePath:(NSURL *)filePath
                        andModels:(NSArray<NSManagedObjectModel *> *)models;
/**
 *  进入后台时会自动调用。
 */
-(void)saveContext;

@end
