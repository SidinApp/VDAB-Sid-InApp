//
//  PersistentStack.h
//  Sid-In App Data Model
//
//  Created by Bert Remmerie on 06/06/15.
//  Copyright (c) 2015 EhB.be. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <RestKit/CoreData.h>
#import <RestKit/RestKit.h>

@interface PersistentStack : NSObject

@property (nonatomic, readonly) RKManagedObjectStore *managedObjectStore;

@property (nonatomic, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, readonly) NSPersistentStore *persistentStore;
@property (nonatomic, readonly) NSManagedObjectContext *mainQueueManagedObjectContext;
@property (nonatomic, readonly) NSManagedObjectContext *persistentStoreManagedObjectContext;

-(id)initWithStoreURL:(NSURL *)storeURL;

-(id)initWithStoreURL:(NSURL *)storeURL modelURL:(NSURL *)modelURL;

-(void)deletePersistentStore;

-(NSURL *)persistentStoreURL;

@end
