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


#define kArchiveFileName    @"archive_data.archive"
#define kArchiveKey         @"kArchiveCodeMonkey"

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
    NSString *filePath = [[Utility documentsDir] stringByAppendingPathComponent:kArchiveFileName];
    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
    NSKeyedUnarchiver *cmUnarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];

    CodeMonkey *cm = [cmUnarchiver decodeObjectForKey:kArchiveKey];
    [cmUnarchiver finishDecoding];
    return cm;
}

- (void)save:(CodeMonkey *)cm {
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *cmArchiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [cmArchiver encodeObject:cm forKey:kArchiveKey];
    [cmArchiver finishEncoding];

    NSString *filePath = [[Utility documentsDir] stringByAppendingPathComponent:kArchiveFileName];
    NSError *error;
    BOOL writeStatus = [data writeToFile: filePath
                                 options: NSDataWritingAtomic
                                   error: &error];
    if (!writeStatus) {
        NSLog (@"error writing to file: %@", error);
        return;
    }
}

@end
