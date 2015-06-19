//
//  SchoolList.m
//  Sid-In App Data Model
//
//  Created by Bert Remmerie on 07/06/15.
//  Copyright (c) 2015 EhB.be. All rights reserved.
//

#import "SchoolList.h"

//#import "School.h"
//#import "SchoolEntity.h"
//#import "SchoolEntityList.h"

@implementation SchoolList

+(NSString *)entityName{
    return @"SchoolEntityList";
}


+(RKEntityMapping *)createEntityMapping:(RKManagedObjectStore *)managedObjectStore{
    
    RKEntityMapping *result = [RKEntityMapping mappingForEntityForName:[SchoolList entityName]
                                                  inManagedObjectStore:managedObjectStore];
    [result addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"schools"
                                                                           toKeyPath:@"schools"                                                                                                        withMapping:[School createEntityMapping:managedObjectStore]]];
    
    return result;

}

+(RKObjectMapping *)createObjectMapping{
    
    RKObjectMapping *result = [RKObjectMapping mappingForClass:[SchoolList class]];
    [result addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"schools"
                                                                           toKeyPath:@"schools"
                                                                         withMapping:[School createObjectMapping]]];
    
    return result;
}

@end