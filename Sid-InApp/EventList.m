//
//  EventList.m
//  Sid-In App Data Model
//
//  Created by Bert Remmerie on 07/06/15.
//  Copyright (c) 2015 EhB.be. All rights reserved.
//

#import "EventList.h"

//#import "Event.h"
//#import "EventEntity.h"
//#import "EventEntityList.h"

@implementation EventList

+(NSString *)entityName{
    return @"EventEntityList";
}

+(RKEntityMapping *)createEntityMapping:(RKManagedObjectStore *)managedObjectStore{
    
    RKEntityMapping *result = [RKEntityMapping mappingForEntityForName:[EventList entityName]
                                                  inManagedObjectStore:managedObjectStore];
    [result addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"events"
                                                                           toKeyPath:@"events"                                                                                                        withMapping:[Event createEntityMapping:managedObjectStore]]];
    
    return result;
}

+(RKObjectMapping *)createObjectMapping{
    
    RKObjectMapping *result = [RKObjectMapping mappingForClass:[EventList class]];
    
    [result addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"events"
                                                                           toKeyPath:@"events"                                                                                                        withMapping:[Event createObjectMapping]]];
    return result;
}

@end


//+(NSManagedObject *)createEntity:(NSManagedObjectContext *)managedObjectContext{
//
//    // NSManagedObject as EventEntity
//
//    EventEntityList *result = [NSEntityDescription insertNewObjectForEntityForName:[Event entityName]
//                                                        inManagedObjectContext:managedObjectContext];
//    return result;
//}
//