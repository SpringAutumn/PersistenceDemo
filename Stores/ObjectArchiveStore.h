//
//  ObjectArchiveStore.h
//  PersistenceDemo
//
//  Created by Phoenix on 5/27/14.
//  Copyright (c) 2014 intel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CodeMonkeyStoreProtocol.h"

@interface ObjectArchiveStore : NSObject <CodeMonkeyStoreProtocol>

+ (ObjectArchiveStore *)sharedStore;

@end
