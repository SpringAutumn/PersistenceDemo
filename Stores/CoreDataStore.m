//
//  CoreDataStore.m
//  PersistenceDemo
//
//  Created by Phoenix on 5/27/14.
//  Copyright (c) 2014 intel. All rights reserved.
//

#import "CoreDataStore.h"

@implementation CoreDataStore

+ (CoreDataStore *)sharedStore {
  static CoreDataStore *store = nil;
  
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    store = [[CoreDataStore alloc] init];
  });
  
  return store;
}

- (CodeMonkey*)load {
    return nil;
}

- (void)save:(CodeMonkey *)cm {
  
}

@end
