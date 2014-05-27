//
//  SQLiteStore.m
//  PersistenceDemo
//
//  Created by Phoenix on 5/27/14.
//  Copyright (c) 2014 intel. All rights reserved.
//

#import "SQLiteStore.h"

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
    return nil;
}

- (void)save:(CodeMonkey *)cm {
  
}

@end
