//
//  ObjectArchiveStore.m
//  PersistenceDemo
//
//  Created by Phoenix on 5/27/14.
//  Copyright (c) 2014 intel. All rights reserved.
//

#import "ObjectArchiveStore.h"
#import "CodeMonkey.h"
#import "Utility.h"

@implementation ObjectArchiveStore

+ (ObjectArchiveStore *)sharedStore {
  static ObjectArchiveStore *store = nil;
  
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    store = [[ObjectArchiveStore alloc] init];
  });
  
  return store;
}

- (CodeMonkey*)load {
    return nil;
}

- (void)save:(CodeMonkey *)cm {
  
}

@end
