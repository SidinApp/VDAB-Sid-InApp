//
//  Image.m
//  Sid-In App Data Model
//
//  Created by Bert Remmerie on 07/06/15.
//  Copyright (c) 2015 EhB.be. All rights reserved.
//

#import "Image.h"

//#import "ImageEntity.h"

@implementation Image

+(NSString *)entityName{
    return @"ImageEntity";
}

+(RKEntityMapping *)createEntityMapping:(RKManagedObjectStore *)managedObjectStore{
    
    RKEntityMapping *result = [RKEntityMapping mappingForEntityForName:[Image entityName]
                                                  inManagedObjectStore:managedObjectStore];
    
    // kies een unieke identifier
    result.identificationAttributes = @[@"id"];
    
    // indien json identifiers zelfde zijn als identifiers in de entitydescription
    [result addAttributeMappingsFromArray:@[@"id", @"priority", @"image"]];
    
    return result;
}

+(RKObjectMapping *)createObjectMapping{
    
    RKObjectMapping *result = [RKObjectMapping mappingForClass:[Image class]];
    
    [result addAttributeMappingsFromArray:@[@"id", @"priority", @"image"]];
    
    return result;
}

@end

//+(NSManagedObject *)createEntity:(NSManagedObjectContext *)managedObjectContext{
//
//    // NSManagedObject as EventEntity
//
//    ImageEntity *result = [NSEntityDescription insertNewObjectForEntityForName:[Image entityName]
//                                                        inManagedObjectContext:managedObjectContext];
//    return result;
//}
//