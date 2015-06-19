//
//  PersistentStack.m
//  Sid-In App Data Model
//
//  Created by Bert Remmerie on 06/06/15.
//  Copyright (c) 2015 EhB.be. All rights reserved.
//

#import "PersistentStack.h"

@interface PersistentStack()

@property (nonatomic, readwrite) RKManagedObjectStore *managedObjectStore;

@property (nonatomic, readwrite) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, readwrite) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, readwrite) NSPersistentStore *persistentStore;
@property (nonatomic, readwrite) NSManagedObjectContext *mainQueueManagedObjectContext;
@property (nonatomic, readwrite) NSManagedObjectContext *persistentStoreManagedObjectContext;

@property (nonatomic) NSURL *storeURL;
@property (nonatomic) NSURL *modelURL;

@end

@implementation PersistentStack

-(id)initWithStoreURL:(NSURL *)storeURL modelURL:(NSURL *)modelURL{
    
    self = [super init];
    
    if (self) {
        self.storeURL = storeURL;
        self.modelURL = modelURL;
        [self setupManagedObjectStore];
    }
    
    return self;
}

-(id)initWithStoreURL:(NSURL *)storeURL{
    
    return [self initWithStoreURL:storeURL modelURL:nil];
}


-(void)deletePersistentStore{
    
    NSError *error = nil;
    
    [self.persistentStoreCoordinator removePersistentStore:self.persistentStore error:&error];
    [[NSFileManager defaultManager] removeItemAtURL:self.storeURL error:&error];
}

-(NSURL *)persistentStoreURL{
    
    NSURL *persistentStorURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    
    return persistentStorURL;
}


-(void)setupManagedObjectStore{
    
    [self setupManagedObjectModel];
    
    if (!self.managedObjectStore) {
        self.managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:self.managedObjectModel];
        
        [self setupPersistentStoreCoordinator];
        [self setupPersistentStore];
        [self setupManagedObjectContexts];
        [self setupManagedObjectCache];
    }
}

-(void)setupManagedObjectModel{
    
    if (!self.managedObjectModel) {
        
        if (!self.modelURL) {
            
            self.managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
        } else {
            
            self.managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:self.modelURL];
        }        
    }
}

-(void)setupPersistentStoreCoordinator{
    
    [self.managedObjectStore createPersistentStoreCoordinator];
    
    self.persistentStoreCoordinator = self.managedObjectStore.persistentStoreCoordinator;
}

-(void)setupPersistentStore{
    
    NSString *seedPath = [[NSBundle mainBundle] pathForResource:@"RKSeedDatabase" ofType:@"sqlite"];
    NSError *error = nil;
    
    if (!self.persistentStore) {
        self.persistentStore = [self.managedObjectStore addSQLitePersistentStoreAtPath:[self.storeURL path] fromSeedDatabaseAtPath:seedPath withConfiguration:nil options:nil error:&error];
        NSAssert(self.persistentStore, @"Er is een fout opgetreden bij het toevoegen van de persistent store: %@", error);
    }
}

-(void)setupManagedObjectContexts{
    
    [self.managedObjectStore createManagedObjectContexts];
    
    self.mainQueueManagedObjectContext = self.managedObjectStore.mainQueueManagedObjectContext;
    self.persistentStoreManagedObjectContext = self.managedObjectStore.persistentStoreManagedObjectContext;
    
    // zie: http://www.objc.io/issues/10-syncing-data/networked-core-data-application/
    
}

-(void)setupManagedObjectCache{
    
    self.managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:self.persistentStoreManagedObjectContext];
}

@end
