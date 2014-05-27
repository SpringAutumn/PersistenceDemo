//
//  SQLiteStore.m
//  PersistenceDemo
//
//  Created by Phoenix on 5/27/14.
//  Copyright (c) 2014 intel. All rights reserved.
//

#import "SQLiteStore.h"
#import "Utility.h"
#import "FMDatabase.h"
#import "CodeMonkey.h"

#define kDatabaseFileName   @"sqlite_data.db"

@interface SQLiteStore ()

@property (nonatomic, strong) FMDatabase *db;
@property (nonatomic, assign) int64_t latestId;

- (BOOL)openDatabase;
- (void)closeDatabase;
@end

@implementation SQLiteStore

+ (SQLiteStore *)sharedStore {
  static SQLiteStore *store = nil;
  
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    store = [[SQLiteStore alloc] init];
  });
  
  return store;
}

- (CodeMonkey*)load {
    if (self.latestId == -1) {
        return nil;
    }

    if ([self openDatabase]) {
        CodeMonkey *cm = [[CodeMonkey alloc] init];
        NSString * sql = @"SELECT * FROM CodeMonkey WHERE id=:id";
        FMResultSet * rs = [self.db executeQuery:sql, @(self.latestId)];
        while ([rs next]) {
            int cmId = [rs intForColumn:@"id"];
            NSString * name = [rs stringForColumn:@"name"];
            NSString * manifest = [rs stringForColumn:@"manifest"];
            NSInteger LOC = [rs intForColumn:@"LOC"];
            NSLog(@"CodeMonkey id = %d, name = %@, manifest = %@, LOC = %d", cmId, name, manifest, LOC);
            cm.name = name;
            cm.manifest = manifest;
            cm.linesOfCode = LOC;
        }
        [self closeDatabase];
        return cm;
    }
    return nil;
}

- (void)save:(CodeMonkey *)cm {
    if ([self openDatabase]) {
        NSString * sql = @"INSERT INTO CodeMonkey (name, manifest, LOC) VALUES (:name,:manifest,:LOC) ";
        BOOL result = [self.db executeUpdate:sql, cm.name, cm.manifest, @(cm.linesOfCode)];
        if (!result) {
            NSLog(@"Save data failure");
            self.latestId = -1;
        } else {
            NSLog(@"Save data success");
            self.latestId = [self.db lastInsertRowId];
        }
        [self closeDatabase];
    }
}

- (BOOL)openDatabase {
    NSString *filePath = [[Utility documentsDir] stringByAppendingPathComponent:kDatabaseFileName];
    self.db = [FMDatabase databaseWithPath:filePath];
    BOOL state = [self.db open];
    if (state) {
        NSString * sql = @"CREATE TABLE IF NOT EXISTS 'CodeMonkey' ('id' INTEGER PRIMARY KEY AUTOINCREMENT, 'name' VARCHAR(50), 'manifest' VARCHAR(100), 'LOC' INTEGER)";
        BOOL result = [self.db executeUpdate:sql];
        if (!result) {
            NSLog(@"Create table failure");
        } else {
            NSLog(@"Create table success");
        }
    }
    return state;
}

- (void)closeDatabase {
    [self.db close];
}
@end
