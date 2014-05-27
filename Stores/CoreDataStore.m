//
//  CoreDataStore.m
//  PersistenceDemo
//
//  Created by Phoenix on 5/27/14.
//  Copyright (c) 2014 intel. All rights reserved.
//

#import "CoreDataStore.h"
#import "Utility.h"
#import "CodeMonkey.h"
#import "Programmer.h"

#define kCoreDataFileName   @"coredata_data.db"

@interface CoreDataStore ()

@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSManagedObjectID *latestObjectID;
@end

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
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Programmer" inManagedObjectContext:self.managedObjectContext]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"(SELF = %@)", self.latestObjectID];
    [request setPredicate:predicate];

    NSError *error;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    Programmer *programmer = [results objectAtIndex:0];
    
    CodeMonkey *cm = [[CodeMonkey alloc] init];
    cm.name = programmer.name;
    cm.manifest = programmer.manifest;
    cm.linesOfCode = [programmer.linesOfCode integerValue];

    return cm;
}

- (void)save:(CodeMonkey *)cm {
  Programmer* programmer = [NSEntityDescription insertNewObjectForEntityForName:@"Programmer" inManagedObjectContext:self.managedObjectContext];
    programmer.name = cm.name;
    programmer.manifest = cm.manifest;
    programmer.linesOfCode = @(cm.linesOfCode);

    NSError *error;
	if (![programmer.managedObjectContext save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	}
    self.latestObjectID = programmer.objectID;
}


#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext {
	
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [NSManagedObjectContext new];
        [_managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return _managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel {
	
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    return _managedObjectModel;
}

/**
 Returns the URL to the application's documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }

    _persistentStoreCoordinator =
    [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];

    NSError *error;
    // setup and add the user's store to our coordinator
    NSURL *userStoreURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:kCoreDataFileName];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                   configuration:nil
                                                             URL:userStoreURL
                                                         options:nil
                                                           error:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 
		 Typical reasons for an error here include:
		 * The persistent store is not accessible
		 * The schema for the persistent store is incompatible with current managed object model
		 Check the error message to determine what the actual problem was.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
    }
    
    return _persistentStoreCoordinator;
}
@end
