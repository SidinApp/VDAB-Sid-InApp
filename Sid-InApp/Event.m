//
//  Event.m
//  Sid-In App Data Model
//
//  Created by Bert Remmerie on 07/06/15.
//  Copyright (c) 2015 EhB.be. All rights reserved.
//

#import "Event.h"

//#import "EventEntity.h"

@implementation Event

+(NSString *)entityName{
    return @"EventEntity";
}

+(RKEntityMapping *)createEntityMapping:(RKManagedObjectStore *)managedObjectStore{
    
    RKEntityMapping *result = [RKEntityMapping mappingForEntityForName:[Event entityName]
                                                  inManagedObjectStore:managedObjectStore];
    
    // kies een unieke identifier
    result.identificationAttributes = @[@"id"];
    
    // indien json identifiers zelfde zijn als identifiers in de entitydescription
    [result addAttributeMappingsFromArray:@[ @"id", @"name", @"acadyear"]];
    
    return result;
}

+(RKObjectMapping *)createObjectMapping{
    
    RKObjectMapping *result = [RKObjectMapping mappingForClass:[Event class]];
    
    [result addAttributeMappingsFromArray:@[@"id", @"name", @"acadyear"]];
    
    return result;
}

//+(NSManagedObject *)createEntity:(NSManagedObjectContext *)managedObjectContext{
//    
//    // NSManagedObject as EventEntity
//    
//    EventEntity *result = [NSEntityDescription insertNewObjectForEntityForName:[Event entityName]
//                                                        inManagedObjectContext:managedObjectContext];
//    return result;
//}
//
//+(RKEntityMapping *)createEntityMapping:(RKManagedObjectStore *)managedObjectStore{
//    
//    RKEntityMapping *result = [RKEntityMapping mappingForEntityForName:[Event entityName]
//                                                  inManagedObjectStore:managedObjectStore];
//    
//    // kies een unieke identifier
//    result.identificationAttributes = @[@"id"];
//    
//    // indien json identifiers zelfde zijn als identifiers in de entitydescription
//    [result addAttributeMappingsFromArray:@[ @"id", @"name", @"acadyear"]];
//    
//    return result;
//}
//
//+(RKObjectMapping *)createObjectMapping{
//    
//    RKObjectMapping *result = [RKObjectMapping mappingForClass:[Event class]];
//    
//    [result addAttributeMappingsFromArray:@[@"id", @"name", @"acadyear"]];
//    
//    return result;
//}


@end
