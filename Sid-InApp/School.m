//
//  School.m
//  Sid-In App Data Model
//
//  Created by Bert Remmerie on 07/06/15.
//  Copyright (c) 2015 EhB.be. All rights reserved.
//

#import "School.h"

//#import "SchoolEntity.h"

@implementation School

+(NSString *)entityName{
    return @"SchoolEntity";
}


+(RKEntityMapping *)createEntityMapping:(RKManagedObjectStore *)managedObjectStore{
    
    RKEntityMapping *result = [RKEntityMapping mappingForEntityForName:[School entityName]
                                                  inManagedObjectStore:managedObjectStore];
    
    // kies een unieke identifier
    result.identificationAttributes = @[@"id"];
    
    // indien json identifiers zelfde zijn als identifiers in de entitydescription
    [result addAttributeMappingsFromArray:@[@"id", @"name", @"gemeente", @"postcode"]];
    
    return result;
}

+(RKObjectMapping *)createObjectMapping{
    
    RKObjectMapping *result = [RKObjectMapping mappingForClass:[School class]];
    
    [result addAttributeMappingsFromArray:@[@"id", @"name", @"gemeente", @"postcode"]];
    
    return result;
}

@end