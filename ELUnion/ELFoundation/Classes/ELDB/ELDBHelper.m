//
//  ELDBHelper.m
//  Elottory
//
//  Created by 金秋成 on 16/9/7.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "ELDBHelper.h"

@interface ELDBHelper ()
{
    NSManagedObjectContext * _context;
}

@property (nonatomic,strong)NSPersistentStoreCoordinator * coordinator;
@property (nonatomic,strong)NSManagedObjectModel         * model;
@property (nonatomic,strong)NSPersistentStore            * store;
@property (nonatomic,strong)NSArray<NSManagedObjectModel *> * models;
@end

@implementation ELDBHelper

-(instancetype)initWithDBFilePath:(NSURL *)filePath{
    ELDBHelper * helper = [[ELDBHelper alloc]initWithDBFilePath:filePath andModels:nil];
    return helper;
}

-(instancetype)initWithDBFilePath:(NSURL *)filePath andModels:(NSArray<NSManagedObjectModel *> *)models;{
    
    self = [super init];
    if (self) {
        self.models = models;
        [self loadStoreWithDBFilePath:filePath];
    }
    return self;
}




-(void)loadStoreWithDBFilePath:(NSURL *)filePath{
    NSError * error = nil;
    _store = [self.coordinator addPersistentStoreWithType:NSSQLiteStoreType
                                            configuration:nil
                                                      URL:filePath
                                                  options:nil
                                                    error:&error];
    if (error) {
        NSLog(@"创建store时出错 %@",error);
    }
    else{
        NSLog(@"数据库文件创建成功 : %@ ",filePath);
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

-(void)asyncSaveContext{
    if ([self.backgroundContext hasChanges]) {
        [self.backgroundContext performBlock:^{
            NSError * error = nil;
            if (![self.backgroundContext save:&error]) {
                NSLog(@"background 保存失败%@",error);
            }
            else{
                [self.context save:nil];
            }
        }];
    }
}

-(NSManagedObjectModel *)model{
    if (!_model) {
        if (self.models) {
            _model = [NSManagedObjectModel modelByMergingModels:self.models];
        }
        else{
            _model = [NSManagedObjectModel mergedModelFromBundles:nil];
        }
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
-(NSManagedObjectContext *)backgroundContext{
    if (!_backgroundContext) {
        _backgroundContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        _backgroundContext.parentContext = self.context;
    }
    return _backgroundContext;
}

@end
