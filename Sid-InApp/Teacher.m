//
//  Teacher.m
//  Sid-In App Data Model
//
//  Created by Bert Remmerie on 07/06/15.
//  Copyright (c) 2015 EhB.be. All rights reserved.
//

#import "Teacher.h"

//#import "TeacherEntity.h"

@implementation Teacher

+(NSString *)entityName{
    return @"TeacherEntity";
}

+(RKEntityMapping *)createEntityMapping:(RKManagedObjectStore *)managedObjectStore{
    
    RKEntityMapping *result = [RKEntityMapping mappingForEntityForName:[Teacher entityName]
                                                  inManagedObjectStore:managedObjectStore];
    
    // kies een unieke identifier
    result.identificationAttributes = @[@"id"];
    
    // indien json identifiers zelfde zijn als identifiers in de entitydescription
    [result addAttributeMappingsFromArray:@[ @"id", @"name", @"acadyear"]];
    
    return result;
}

+(RKObjectMapping *)createObjectMapping{
    
    RKObjectMapping *result = [RKObjectMapping mappingForClass:[Teacher class]];
    
    [result addAttributeMappingsFromArray:@[@"id", @"name", @"acadyear"]];
    
    return result;
}

@end