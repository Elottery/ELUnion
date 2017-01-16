//
//  ELDBHelper.m
//  Elottory
//
//  Created by 金秋成 on 16/9/7.
//  Copyright © 2016年 金秋成. All rights reserved.
//

#import "ELDBHelper.h"
#import <HYFileManager.h>
@interface ELDBHelper ()
{
    NSManagedObjectContext * _context;
}

@property (nonatomic,strong)NSPersistentStoreCoordinator * coordinator;
@property (nonatomic,strong)NSManagedObjectModel         * model;
@property (nonatomic,strong)NSPersistentStore            * store;
@property (nonatomic,strong)NSArray<NSManagedObjectModel *> * models;
@property (nonatomic,strong)NSURL   * filePathURL;
@end

@implementation ELDBHelper

-(instancetype)initWithDBFilePath:(NSURL *)filePath{
    ELDBHelper * helper = [[ELDBHelper alloc]initWithDBFilePath:filePath andModels:nil];
    return helper;
}

-(instancetype)initWithDBFilePath:(NSURL *)filePath andModels:(NSArray<NSManagedObjectModel *> *)models;{
    
    self = [super init];
    if (self) {
        self.filePathURL = filePath;
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

- (BOOL)isMigrationNecessary{
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    if (![[NSFileManager defaultManager] fileExistsAtPath:self.filePathURL.path]) {
        NSLog(@"SKIPPED MIGRATION: Source database missing.");
        return NO;
    }
    NSError *error = nil;
    NSDictionary *sourceMetadata =
    [NSPersistentStoreCoordinator metadataForPersistentStoreOfType:NSSQLiteStoreType
                                                               URL:self.filePathURL error:&error];
    NSManagedObjectModel *destinationModel = _coordinator.managedObjectModel;
    if ([destinationModel isConfiguration:nil
              compatibleWithStoreMetadata:sourceMetadata]) {
            NSLog(@"SKIPPED MIGRATION: Source is already compatible");
        return NO;
    }
    return YES;
}

- (BOOL)migrateStore:(NSURL*)sourceStore {
    BOOL success = NO;
    NSError *error = nil;
    
    // STEP 1 - Gather the Source, Destination and Mapping Model
    NSDictionary *sourceMetadata = [NSPersistentStoreCoordinator
                                    metadataForPersistentStoreOfType:NSSQLiteStoreType
                                    URL:sourceStore
                                    error:&error];
    
    NSManagedObjectModel *sourceModel =
    [NSManagedObjectModel mergedModelFromBundles:nil
                                forStoreMetadata:sourceMetadata];
    
    NSManagedObjectModel *destinModel = _model;
    
    NSMappingModel *mappingModel =
    [NSMappingModel mappingModelFromBundles:nil
                             forSourceModel:sourceModel
                           destinationModel:destinModel];
    
    // STEP 2 - Perform migration, assuming the mapping model isn't null
    if (mappingModel) {
        NSError *error = nil;
        NSMigrationManager *migrationManager =
        [[NSMigrationManager alloc] initWithSourceModel:sourceModel
                                       destinationModel:destinModel];
        [migrationManager addObserver:self
                           forKeyPath:@"migrationProgress"
                              options:NSKeyValueObservingOptionNew
                              context:NULL];
        
        NSURL *destinStore = [[NSURL URLWithString:[HYFileManager tmpDir]]URLByAppendingPathComponent:@"Temp.sqlite"];
        
        success =
        [migrationManager migrateStoreFromURL:sourceStore
                                         type:NSSQLiteStoreType options:nil
                             withMappingModel:mappingModel
                             toDestinationURL:destinStore
                              destinationType:NSSQLiteStoreType
                           destinationOptions:nil
                                        error:&error];
        if (success) {
            // STEP 3 - Replace the old store with the new migrated store
            if ([self replaceStore:sourceStore withStore:destinStore]) {
                    NSLog(@"SUCCESSFULLY MIGRATED %@ to the Current Model",sourceStore.path);
                [migrationManager removeObserver:self
                                      forKeyPath:@"migrationProgress"];
            }
        }
        else {
            NSLog(@"FAILED MIGRATION: %@",error);
        }
    }
    else {
        NSLog(@"FAILED MIGRATION: Mapping Model is null");
    }
    return YES; // indicates migration has finished, regardless of outcome
}
- (BOOL)replaceStore:(NSURL*)old withStore:(NSURL*)new {
    
    BOOL success = NO;
    NSError *Error = nil;
    if ([[NSFileManager defaultManager]
         removeItemAtURL:old error:&Error]) {
        
        Error = nil;
        if ([[NSFileManager defaultManager]
             moveItemAtURL:new toURL:old error:&Error]) {
            success = YES;
        }
        else {
            NSLog(@"FAILED to re-home new store %@", Error);
        }
    }
    else {
            NSLog(@"FAILED to remove old store %@: Error:%@", old, Error);
    }
    return success;
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
