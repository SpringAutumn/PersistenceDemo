//
//  Programmer.h
//  PersistenceDemo
//
//  Created by Zhao WenDeng on 5/27/14.
//  Copyright (c) 2014 intel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Programmer : NSManagedObject

@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * manifest;
@property (nonatomic, strong) NSNumber * linesOfCode;

@end
