//
//  TeacherList.m
//  Sid-In App Data Model
//
//  Created by Bert Remmerie on 07/06/15.
//  Copyright (c) 2015 EhB.be. All rights reserved.
//

#import "TeacherList.h"

//#import "Teacher.h"
//#import "TeacherEntity.h"
//#import "TeacherEntityList.h"

@implementation TeacherList

+(NSString *)entityName{
    return @"TeacherEntityList";
}

+(RKEntityMapping *)createEntityMapping:(RKManagedObjectStore *)managedObjectStore{
    
    RKEntityMapping *result = [RKEntityMapping mappingForEntityForName:[TeacherList entityName]
                                                  inManagedObjectStore:managedObjectStore];
    [result addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"teachers"
                                                                           toKeyPath:@"teachers"                                                                                                        withMapping:[Teacher createEntityMapping:managedObjectStore]]];
    
    return result;
}

+(RKObjectMapping *)createObjectMapping{
    
    RKObjectMapping *result = [RKObjectMapping mappingForClass:[Teacher class]];
    
    [result addAttributeMappingsFromArray:@[@"id", @"name", @"acadyear"]];
    
    return result;
}

@end

//+(NSManagedObject *)createEntity:(NSManagedObjectContext *)managedObjectContext{
//
//    // NSManagedObject as TeacherEntity
//
//    TeacherEntityList *result = [NSEntityDescription insertNewObjectForEntityForName:[Teacher entityName]
//                                                            inManagedObjectContext:managedObjectContext];
//    return result;
//}
//