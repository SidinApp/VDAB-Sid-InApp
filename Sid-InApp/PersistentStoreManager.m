//
//  PersistentStoreManager.m
//  Sid-In App Data Model
//
//  Created by Bert Remmerie on 09/06/15.
//  Copyright (c) 2015 EhB.be. All rights reserved.
//

#import "PersistentStoreManager.h"

@interface PersistentStoreManager ()

@property (nonatomic, strong, readwrite) PersistentStack *persistentStack;

@end

@implementation PersistentStoreManager

-(id)initWithPersistentStack:(PersistentStack *)persistentStack{
    
    if (self = [super init]) {
        self.persistentStack = persistentStack;
    }
    
    return self;
}

#pragma mark - Dao

-(NSArray *)fetchAll:(NSString *)entityName{
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    NSError *error = nil;
    
    NSArray *fetchedObjects = [self.persistentStack.mainQueueManagedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    return fetchedObjects;
}

-(NSArray *)fetchAll:(NSString *)entityName sort:(NSSortDescriptor *)descriptor{
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    // sorting
//    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:descriptor ascending:YES];
//    fetchRequest.sortDescriptors = @[sortDescriptor];
    fetchRequest.sortDescriptors = @[descriptor];
    
    NSError *error = nil;
    
    NSArray *fetchedObjects = [self.persistentStack.mainQueueManagedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    return fetchedObjects;
}

-(NSArray *)fetchByPredicate:(NSPredicate *)predicate forEntity:(NSString *)entityName{
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    // predicate
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"acadyear==%@", @"1415"];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.persistentStack.mainQueueManagedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    return fetchedObjects;
}

-(NSArray *)fetchByPredicate:(NSPredicate *)predicate forEntity:(NSString *)entityName sort:(NSSortDescriptor *)descriptor{
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    // sorting
    
    fetchRequest.sortDescriptors = @[descriptor];
    
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.persistentStack.mainQueueManagedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    return fetchedObjects;
}


-(NSUInteger)countForFetchRequest:(NSFetchRequest *)fetchRequest{
    
    NSError *error = nil;
    
    return [self.persistentStack.mainQueueManagedObjectContext countForFetchRequest:fetchRequest error:&error];
}

-(NSUInteger)countForEntity:(NSString *)entityName{
    
    NSError *error = nil;
    
    return [self.persistentStack.mainQueueManagedObjectContext countForEntityForName:entityName predicate:nil error:&error];
}

-(NSUInteger)countForEntity:(NSString *)entityName forPredicate:(NSPredicate *)predicate{
    
    NSError *error = nil;
    
    return [self.persistentStack.mainQueueManagedObjectContext countForEntityForName:entityName predicate:predicate error:&error];
}


-(NSManagedObject *)insert:(NSString *)entityName{
    
    return [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:self.persistentStack.mainQueueManagedObjectContext];
}


-(void)deleteById:(NSNumber *)id forEntity:(NSString *)entityName{
    
    NSArray *result = [self fetchByPredicate:[NSPredicate predicateWithFormat:@"id==%@", id] forEntity:entityName];
    
    NSManagedObject *managedObject = nil;
    
    if ([result count] != 0) {
        managedObject = [result objectAtIndex:0];
    }
    
    [self.persistentStack.mainQueueManagedObjectContext deleteObject:managedObject];
    
    [self save];
}

-(void)deleteObject:(NSManagedObject *)entity{
    
    [self.persistentStack.mainQueueManagedObjectContext deleteObject:entity];
    
    [self save];
}


-(void)save{
    
    // http://stackoverflow.com/questions/16389951/core-data-nsmanagedobjectcontext-not-saved-fetch-request-fails-until-app-quit
    
    // optie 1: Core Data
    
    __block NSError *error = nil;
    
    NSManagedObjectContext* childManagedObjectContext = self.persistentStack.mainQueueManagedObjectContext;
    
    __block BOOL success = YES;
    
    while (childManagedObjectContext && success) {
        [childManagedObjectContext performBlockAndWait:^{
            success = [childManagedObjectContext save:&error];
            //handle save success/failure
        }];
        childManagedObjectContext = childManagedObjectContext.parentContext;
    }
    
    // optie 2: RestKit
    
    //    [self.persistentStack.mainQueueManagedObjectContext saveToPersistentStore:&error];
}

-(void)save:(NSManagedObject *)entity{
    
    // http://stackoverflow.com/questions/16389951/core-data-nsmanagedobjectcontext-not-saved-fetch-request-fails-until-app-quit
    
    // optie 1: Core Data
    
    __block NSError *error = nil;
    
    NSManagedObjectContext* childManagedObjectContext = entity.managedObjectContext;
    
    __block BOOL success = YES;
    
    while (childManagedObjectContext && success) {
        [childManagedObjectContext performBlockAndWait:^{
            success = [childManagedObjectContext save:&error];
            //handle save success/failure
        }];
        childManagedObjectContext = childManagedObjectContext.parentContext;
    }
    
    // optie 2: RestKit
    
    //    [entity.persistentStack.mainQueueManagedObjectContext saveToPersistentStore:&error];
}


@end
