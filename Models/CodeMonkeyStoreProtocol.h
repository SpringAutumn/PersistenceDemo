//
//  CodeMonkeyStoreProtocol.h
//  PersistenceDemo
//
//  Created by Phoenix on 5/27/14.
//  Copyright (c) 2014 intel. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CodeMonkey;
@protocol CodeMonkeyStoreProtocol <NSObject>

- (CodeMonkey *)load;
- (void)save:(CodeMonkey*)cm;
@end
