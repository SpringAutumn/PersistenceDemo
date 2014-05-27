//
//  CodeMonkey.h
//  PersistenceDemo
//
//  Created by Phoenix on 5/27/14.
//  Copyright (c) 2014 intel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CodeMonkey : NSObject <NSCoding>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *manifest;
@property (nonatomic, assign) int64_t linesOfCode;

// Use propery name as key name
- (NSDictionary *)toDict;
- (id)initWithDict:(NSDictionary *)dict;
@end
