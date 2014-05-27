//
//  CodeMonkey.m
//  PersistenceDemo
//
//  Created by Phoenix on 5/27/14.
//  Copyright (c) 2014 intel. All rights reserved.
//

#import "CodeMonkey.h"

@implementation CodeMonkey

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.name forKey:@"name"];
  [aCoder encodeObject:self.manifest forKey:@"manifest"];
  [aCoder encodeInt64:self.linesOfCode forKey:@"linesOfCode"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  _name = [[aDecoder decodeObjectForKey:@"name"] copy];
  _manifest = [[aDecoder decodeObjectForKey:@"manifest"] copy];
  _linesOfCode = [aDecoder decodeInt64ForKey:@"linesOfCode"];

  return self;
}

- (NSDictionary *)toDict {
  NSMutableDictionary *dict = [NSMutableDictionary dictionary];
  dict[@"name"] = self.name;
  dict[@"manifest"] = self.manifest;
  dict[@"linesOfCode"] = @(self.linesOfCode);

  return dict;
}

- (id)initWithDict:(NSDictionary *)dict {
  self = [super init];
  if (self) {
    _name = [[dict objectForKey:@"name"] copy];
    _manifest = [[dict objectForKey:@"manifest"] copy];
    _linesOfCode = [[dict objectForKey:@"linesOfCode"] integerValue];
  }
  return self;
}

@end
