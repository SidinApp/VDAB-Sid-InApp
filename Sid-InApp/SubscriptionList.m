//
//  SubscriptionList.m
//  Sid-In App Data Model
//
//  Created by Bert Remmerie on 07/06/15.
//  Copyright (c) 2015 EhB.be. All rights reserved.
//

#import "SubscriptionList.h"

@implementation SubscriptionList

+(NSString *)entityName{
    return @"SubscriptionEntityList";
}

+(RKEntityMapping *)createEntityMapping:(RKManagedObjectStore *)managedObjectStore{
    
    RKEntityMapping *result = [RKEntityMapping mappingForEntityForName:[SubscriptionList entityName]
                                                  inManagedObjectStore:managedObjectStore];
    [result addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"subscriptions"
                                                                           toKeyPath:@"subscriptions"
                                                                         withMapping:[Subscription createEntityMapping:managedObjectStore]]];
    
    return result;
}

+(RKObjectMapping *)createObjectMapping{
    
    RKObjectMapping *result = [RKObjectMapping mappingForClass:[SubscriptionList class]];
    
    [result addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"subscriptions"
                                                                           toKeyPath:@"subscriptions"
                                                                         withMapping:[Subscription createObjectMapping]]];
    
    return result;
}

@end