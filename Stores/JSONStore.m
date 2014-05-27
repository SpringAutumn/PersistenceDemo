//
//  JSONStore.m
//  PersistenceDemo
//
//  Created by Phoenix on 5/27/14.
//  Copyright (c) 2014 intel. All rights reserved.
//

#import "JSONStore.h"
#import "Utility.h"
#import "CodeMonkey.h"

#define kJsonFileName       @"json_data.json"

@implementation JSONStore

+ (JSONStore *)sharedStore {
  static JSONStore *store = nil;
  
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    store = [[JSONStore alloc] init];
  });
  
  return store;
}

- (CodeMonkey*)load {
  NSString *filePath = [[Utility documentsDir] stringByAppendingPathComponent:kJsonFileName];
  NSData *data = [NSData dataWithContentsOfFile:filePath];
  
  NSError *error;
  NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                       options:kNilOptions
                                                         error:&error];
  return [[CodeMonkey alloc] initWithDict:dict];
}

- (void)save:(CodeMonkey *)cm {
  NSString *filePath = [[Utility documentsDir] stringByAppendingPathComponent:kJsonFileName];
  NSDictionary *dict = [cm toDict];
  
  NSError *error;
  NSData *data = [NSJSONSerialization dataWithJSONObject:dict
                                                     options:NSJSONWritingPrettyPrinted
                                                       error:&error];
  if (data == nil) {
    NSLog (@"error serializing to json: %@", error);
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
