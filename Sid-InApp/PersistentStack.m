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


//-(RKManagedObjectStore *)managedObjectStore{
//    
//    if (!self.managedObjectStore) {
//        self.managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:self.managedObjectModel];
//    }
//    
//    return self.managedObjectStore;
//    
//}


//#pragma mark - DAO
//
//-(NSArray *)fetchAll:(NSString *)entityName{
//    
//    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
//    
//    NSError *error = nil;
//    
//    NSArray *fetchedObjects = [self.mainQueueManagedObjectContext executeFetchRequest:fetchRequest error:&error];
//    
//    return fetchedObjects;
//}
//
//-(NSArray *)fetchAll:(NSString *)entityName sort:(NSString *)descriptor{
//    
//    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
//    
//    // sorting
//    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:descriptor ascending:YES];
//    fetchRequest.sortDescriptors = @[sortDescriptor];
//    
//    NSError *error = nil;
//    
//    NSArray *fetchedObjects = [self.mainQueueManagedObjectContext executeFetchRequest:fetchRequest error:&error];
//    
//    return fetchedObjects;
//}
//
//-(NSArray *)fetchByPredicate:(NSPredicate *)predicate forEntity:(NSString *)entityName{
//    
//    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
//    
//    // predicate
//    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"acadyear==%@", @"1415"];
//    [fetchRequest setPredicate:predicate];
//    
//    NSError *error = nil;
//    NSArray *fetchedObjects = [self.mainQueueManagedObjectContext executeFetchRequest:fetchRequest error:&error];
//    
//    return fetchedObjects;
//}
//
//-(NSArray *)fetchByPredicate:(NSPredicate *)predicate forEntity:(NSString *)entityName sort:(NSString *)descriptor{
//    
//    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
//    
//    // sorting
//    
//    fetchRequest.sortDescriptors = @[descriptor];
//    
//    [fetchRequest setPredicate:predicate];
//    
//    NSError *error = nil;
//    NSArray *fetchedObjects = [self.mainQueueManagedObjectContext executeFetchRequest:fetchRequest error:&error];
//    
//    return fetchedObjects;
//}
//
//
//-(NSUInteger)countForFetchRequest:(NSFetchRequest *)fetchRequest{
//    
//    NSError *error = nil;
//    
//    return [self.mainQueueManagedObjectContext countForFetchRequest:fetchRequest error:&error];
//}
//
//-(NSUInteger)countForEntity:(NSString *)entityName{
//    
//    NSError *error = nil;
//    
//    return [self.mainQueueManagedObjectContext countForEntityForName:entityName predicate:nil error:&error];
//}
//
//-(NSUInteger)countForEntity:(NSString *)entityName forPredicate:(NSPredicate *)predicate{
//    
//    NSError *error = nil;
//    
//    return [self.mainQueueManagedObjectContext countForEntityForName:entityName predicate:predicate error:&error];
//}
//
//
//-(NSManagedObject *)insert:(NSString *)entityName{
//    
//    return [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:self.managedObjectStore.mainQueueManagedObjectContext];
//}
//
//
//-(void)deleteById:(NSNumber *)id forEntity:(NSString *)entityName{
//    
//    NSArray *result = [self fetchByPredicate:[NSPredicate predicateWithFormat:@"id==%@", id] forEntity:entityName];
//    
//    NSManagedObject *managedObject = nil;
//    
//    if ([result count] != 0) {
//        managedObject = [result objectAtIndex:0];
//    }
//    
//    [self.mainQueueManagedObjectContext deleteObject:managedObject];
//    
//    [self save];    
//}
//
//-(void)deleteObject:(NSManagedObject *)entity{
//    
//    [self.mainQueueManagedObjectContext deleteObject:entity];
//    
//    [self save];
//}
//
//
//-(void)save{
//    
//    // http://stackoverflow.com/questions/16389951/core-data-nsmanagedobjectcontext-not-saved-fetch-request-fails-until-app-quit
//    
//    // optie 1: Core Data
//    
//    __block NSError *error = nil;
//    
//    NSManagedObjectContext* childManagedObjectContext = self.mainQueueManagedObjectContext;
//    
//    __block BOOL success = YES;
//    
//    while (childManagedObjectContext && success) {
//        [childManagedObjectContext performBlockAndWait:^{
//            success = [childManagedObjectContext save:&error];
//            //handle save success/failure
//        }];
//        childManagedObjectContext = childManagedObjectContext.parentContext;
//    }
//    
//    // optie 2: RestKit
//
////    [self.managedObjectStore.mainQueueManagedObjectContext saveToPersistentStore:&error];
//}
//
//-(void)save:(NSManagedObject *)entity{
//        
//    // http://stackoverflow.com/questions/16389951/core-data-nsmanagedobjectcontext-not-saved-fetch-request-fails-until-app-quit
//    
//    // optie 1: Core Data
//    
//    __block NSError *error = nil;
//    
//    NSManagedObjectContext* childManagedObjectContext = entity.managedObjectContext;
//    
//    __block BOOL success = YES;
//    
//    while (childManagedObjectContext && success) {
//        [childManagedObjectContext performBlockAndWait:^{
//            success = [childManagedObjectContext save:&error];
//            //handle save success/failure
//        }];
//        childManagedObjectContext = childManagedObjectContext.parentContext;
//    }
//    
//    // optie 2: RestKit
//    
////    [entity.managedObjectContext saveToPersistentStore:&error];
//}

@end
