//
//  Dao.h
//  Sid-In App Data Model
//
//  Created by Bert Remmerie on 06/06/15.
//  Copyright (c) 2015 EhB.be. All rights reserved.
//

#import <RestKit/CoreData.h>

@protocol Dao <NSObject>

@required

-(NSArray *)fetchAll:(NSString *)entityName;


@optional

-(NSArray *)fetchAll:(NSString *)entityName sort:(NSSortDescriptor *)descriptor;

-(NSArray *)fetchByPredicate:(NSPredicate *)predicate forEntity:(NSString *)entityName;

-(NSArray *)fetchByPredicate:(NSPredicate *)predicate forEntity:(NSString *)entityName sort:(NSSortDescriptor *)descriptor;


-(NSUInteger)countForFetchRequest:(NSFetchRequest *)fetchRequest;

-(NSUInteger)countForEntity:(NSString *)entityName;

-(NSUInteger)countForEntity:(NSString *)entityName forPredicate:(NSPredicate *)predicate;


-(NSManagedObject *)insert:(NSString *)entityName;


-(void)deleteById:(NSNumber *)id forEntity:(NSString *)entityName;

-(void)deleteObject:(NSManagedObject *)entity;


-(void)save;

-(void)save:(NSManagedObject *)entity;

@end

//- (id)insertNewObjectWithEntityName:(NSString *)entityName;
//- (NSArray *)fetchObjectArrayWithRequest:(NSFetchRequest *)request;
//- (NSUInteger)fetchCountWithRequest:(NSFetchRequest *)request;
//- (NSFetchRequest *)fetchRequestForEntity:(NSEntityDescription *)entity;
//- (NSFetchRequest *)fetchRequestForEntityName:(NSString *)entityName;
//- (NSFetchRequest *)fetchRequestForEntityName:(NSString *)entityName sortDescriptors:(NSArray *)sortDescriptors andPredicate:(NSPredicate *)predicate;
//- (NSArray *)fetchObjectsWithEntityName:(NSString *)entityName sortedBy:(NSArray *)sortDescriptors withPredicate:(NSPredicate *)predicate;
//- (id)fetchFirstObjectWithEntityName:(NSString *)entityName sortedBy:(NSArray *)sortDescriptors withPredicate:(NSPredicate *)predicate;
//- (NSUInteger)fetchCountWithEntityName:(NSString *)entityName andPredicate:(NSPredicate *)predicate;