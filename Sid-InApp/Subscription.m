//
//  Subscription.m
//  Sid-In App Data Model
//
//  Created by Bert Remmerie on 07/06/15.
//  Copyright (c) 2015 EhB.be. All rights reserved.
//

#import "Subscription.h"

//#import "Event.h"
//#import "Teacher.h"
//#import "School.h"
//#import "Interests.h"
//#import "SubscriptionEntity.h"

@implementation Subscription

+(NSString *)entityName{
    return @"SubscriptionEntity";
}

+(RKEntityMapping *)createEntityMapping:(RKManagedObjectStore *)managedObjectStore{
    
    RKEntityMapping *result = [RKEntityMapping mappingForEntityForName:[Subscription entityName]
                                                  inManagedObjectStore:managedObjectStore];
    
    result.identificationAttributes = @[@"id"];
    
    //    [result addAttributeMappingsFromArray:@[@"id", @"firstName", @"lastName", @"email", @"street",
    //                                            @"streetNumber", @"zip", @"city", @"timeStamp", @"new"]];
    
    [result addAttributeMappingsFromDictionary:@{
                                                 @"id" : @"id",
                                                 @"firstName" : @"firstName",
                                                 @"lastName" : @"lastName",
                                                 @"email" : @"email",
                                                 @"street" : @"street",
                                                 @"streetNumber" : @"streetNumber",
                                                 @"zip" : @"zip",
                                                 @"city" : @"city",
                                                 @"timestamp" : @"timestamp",
                                                 @"new" : @"sNew",
                                                 @"acadyear" : @"acadyear"
                                                 }];
    
    [result addPropertyMappingsFromArray:@[
                                           [RKRelationshipMapping relationshipMappingFromKeyPath:@"teacher"
                                                                                       toKeyPath:@"teacher"
                                                                                     withMapping:[Teacher createEntityMapping:managedObjectStore]],
                                           [RKRelationshipMapping relationshipMappingFromKeyPath:@"event"
                                                                                       toKeyPath:@"event"
                                                                                     withMapping:[Event createEntityMapping:managedObjectStore]],
                                           [RKRelationshipMapping relationshipMappingFromKeyPath:@"school"
                                                                                       toKeyPath:@"school"
                                                                                     withMapping:[School createEntityMapping:managedObjectStore]],
                                           [RKRelationshipMapping relationshipMappingFromKeyPath:@"interests"
                                                                                       toKeyPath:@"interests"
                                                                                     withMapping:[Interests createEntityMapping:managedObjectStore]]
                                           ]];
    
    return result;
}


+(RKObjectMapping *)createObjectMapping{
    
    RKObjectMapping *result = [RKObjectMapping mappingForClass:[Subscription class]];
    
    [result addAttributeMappingsFromDictionary:@{
                                                 @"id" : @"id",
                                                 @"firstName" : @"firstName",
                                                 @"lastName" : @"lastName",
                                                 @"email" : @"email",
                                                 @"street" : @"street",
                                                 @"streetNumber" : @"streetNumber",
                                                 @"zip" : @"zip",
                                                 @"city" : @"city",
                                                 @"timestamp" : @"timestamp",
                                                 @"new" : @"sNew",                                                 
                                                 @"acadyear" : @"acadyear"
                                                 }];
    
    
    [result addPropertyMappingsFromArray:@[
                                           [RKRelationshipMapping relationshipMappingFromKeyPath:@"teacher"
                                                                                       toKeyPath:@"teacher"
                                                                                     withMapping:[Teacher createObjectMapping]],
                                           [RKRelationshipMapping relationshipMappingFromKeyPath:@"event"
                                                                                       toKeyPath:@"event"
                                                                                     withMapping:[Event createObjectMapping]],
                                           [RKRelationshipMapping relationshipMappingFromKeyPath:@"school"
                                                                                       toKeyPath:@"school"
                                                                                     withMapping:[School createObjectMapping]],
                                           [RKRelationshipMapping relationshipMappingFromKeyPath:@"interests"
                                                                                       toKeyPath:@"interests"
                                                                                     withMapping:[Interests createObjectMapping]]
                                           ]];
    
    return result;
}

@end

//+(NSManagedObject *)createEntity:(NSManagedObjectContext *)managedObjectContext{
//
//    SubscriptionEntity *result = [NSEntityDescription insertNewObjectForEntityForName:[Subscription entityName]
//                                                               inManagedObjectContext:managedObjectContext];
//    return result;
//}
//
