//
//  ImageList.m
//  Sid-In App Data Model
//
//  Created by Bert Remmerie on 07/06/15.
//  Copyright (c) 2015 EhB.be. All rights reserved.
//

#import "ImageList.h"

//#import "Image.h"
//#import "ImageEntity.h"
//#import "ImageEntityList.h"

@implementation ImageList

+(NSString *)entityName{
    return @"ImageEntityList";
}

+(RKEntityMapping *)createEntityMapping:(RKManagedObjectStore *)managedObjectStore{
    
    RKEntityMapping *result = [RKEntityMapping mappingForEntityForName:[ImageList entityName]
                                                  inManagedObjectStore:managedObjectStore];
    [result addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"images"
                                                                           toKeyPath:@"images"                                                                                                        withMapping:[Image createEntityMapping:managedObjectStore]]];
    
    return result;
}

+(RKObjectMapping *)createObjectMapping{
    
    RKObjectMapping *result = [RKObjectMapping mappingForClass:[ImageList class]];
    [result addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"images"
                                                                           toKeyPath:@"images"
                                                                         withMapping:[Image createObjectMapping]]];
    
    return result;   
}

@end

//+(NSManagedObject *)createEntity:(NSManagedObjectContext *)managedObjectContext{
//
//    ImageEntityList *result = [NSEntityDescription insertNewObjectForEntityForName:[ImageList entityName]
//                                                            inManagedObjectContext:managedObjectContext];
//    return result;
//}
//