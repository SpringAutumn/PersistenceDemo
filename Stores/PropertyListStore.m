//
//  PropertyListStore.m
//  PersistenceDemo
//
//  Created by Phoenix on 5/27/14.
//  Copyright (c) 2014 intel. All rights reserved.
//

#import "PropertyListStore.h"
#import "CodeMonkey.h"
#import "Utility.h"

#define kPlistFileName      @"plist_data.plist"

@implementation PropertyListStore

+ (PropertyListStore *)sharedStore {
  static PropertyListStore *store = nil;
  
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    store = [[PropertyListStore alloc] init];
  });

  return store;
}

- (CodeMonkey*)load {
  NSString *filePath = [[Utility documentsDir] stringByAppendingPathComponent:kPlistFileName];
  NSData *data = [NSData dataWithContentsOfFile:filePath];

  NSString *error;
  NSPropertyListFormat format;
  NSDictionary *dict = [NSPropertyListSerialization propertyListFromData:data
                                                        mutabilityOption:NSPropertyListImmutable
                                                                  format:&format
                                                        errorDescription:&error];
  return [[CodeMonkey alloc] initWithDict:dict];
}

- (void)save:(CodeMonkey *)cm {
  NSString *filePath = [[Utility documentsDir] stringByAppendingPathComponent:kPlistFileName];
  NSDictionary *dict = [cm toDict];
  
  NSError *error;
  NSData *data = [NSPropertyListSerialization dataWithPropertyList: dict
                                                            format: NSPropertyListXMLFormat_v1_0
                                                           options: 0
                                                             error: &error];
  if (data == nil) {
    NSLog (@"error serializing to xml: %@", error);
    return;
  }
  BOOL writeStatus = [data writeToFile: filePath
                               options: NSDataWritingAtomic
                                 error: &error];
  if (!writeStatus) {
    NSLog (@"error writing to file: %@", error);
    return;
  }
}

@end
