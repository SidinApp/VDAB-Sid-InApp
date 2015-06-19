//
//  Interests.m
//  Sid-In App Data Model
//
//  Created by Bert Remmerie on 07/06/15.
//  Copyright (c) 2015 EhB.be. All rights reserved.
//

#import "Interests.h"

//#import "InterestsEntity.h"

@implementation Interests

+(NSString *)entityName{
    return @"InterestsEntity";
}

+(RKEntityMapping *)createEntityMapping:(RKManagedObjectStore *)managedObjectStore{
    
    RKEntityMapping *result = [RKEntityMapping mappingForEntityForName:[Interests entityName]
                                                  inManagedObjectStore:managedObjectStore];
    
    // kies een unieke identifier
    //    result.identificationAttributes = @[@"id"];
    
    // indien json identifiers zelfde zijn als identifiers in de entitydescription
    [result addAttributeMappingsFromArray:@[ @"digx", @"multec", @"werkstudent"]];
    
    return result;
}


+(RKObjectMapping *)createObjectMapping{
    
    RKObjectMapping *result = [RKObjectMapping mappingForClass:[Interests class]];
    
    [result addAttributeMappingsFromArray:@[@"digx", @"multec", @"werkstudent"]];
    
    return result;
}

@end