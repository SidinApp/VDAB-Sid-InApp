//
//  SynchronizationService.m
//  Sid-In App Data Model
//
//  Created by Bert Remmerie on 06/06/15.
//  Copyright (c) 2015 EhB.be. All rights reserved.
//

#import "SynchronizationService.h"

#import "ModelMapping.h"

#import "Event.h"
#import "EventList.h"
#import "Teacher.h"
#import "TeacherList.h"
#import "School.h"
#import "SchoolList.h"
#import "Image.h"
#import "ImageList.h"
#import "Subscription.h"
#import "SubscriptionList.h"

@interface SynchronizationService ()

@property (nonatomic, strong, readwrite) RestfulStack *restfulStack;
@property (nonatomic, strong, readwrite) PersistentStoreManager *persistentStoreManager;

@end

@implementation SynchronizationService

-(id)initWithRestfulStack:(RestfulStack *)restfulStack persistentStoreManager:(PersistentStoreManager *)persistentStoreManager{
    
    if (self = [super init]) {
        self.restfulStack = restfulStack;
        self.persistentStoreManager = persistentStoreManager;
    }
    
    return self;
}

//-(id)initWithRestfulStack:(RestfulStack *)restfulStack{
//    
//    if (self = [super init]) {
//        self.restfulStack = restfulStack;
//    }
//    
//    return self;
//}

-(void)initializePersistentStoreFromBackEnd{
    
    // code controle of er al data bestaat in de store
    
    [self pullEvents];
    [self pullTeachers];
    [self pullSchools];
    [self pullSubscriptions];
    [self pullImages];
}

-(void)pullEntities:(RKMapping *)mapping pathPattern:(NSString *)path{
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    // wordt nu gedaan in RestKit; ook de requestDescripters
    [self.restfulStack createAndAddResponseDescriptor:mapping method:RKRequestMethodGET pathPattern:path];
    
    [self.restfulStack.objectManager getObjectsAtPath:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        // do something when 
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Er is een error opgetreden tijdens het laden: %@", error);
    }];
}

-(void)pullEvents{
    
    [self pullEntities:[EventList createEntityMapping:self.restfulStack.managedObjectStore] pathPattern:EVENTS_URL_PATTERN];
}

-(void)pullTeachers{
    
    [self pullEntities:[TeacherList createEntityMapping:self.restfulStack.managedObjectStore] pathPattern:TEACHERS_URL_PATTERN];
}

-(void)pullSchools{
    
    [self pullEntities:[SchoolList createEntityMapping:self.restfulStack.managedObjectStore] pathPattern:SCHOOLS_URL_PATTERN];
}

-(void)pullImages{
    
    [self pullEntities:[ImageList createEntityMapping:self.restfulStack.managedObjectStore] pathPattern:IMAGE_URL_PATTERN];
}

-(void)pullSubscriptions{
    
    [self pullEntities:[SubscriptionList createEntityMapping:self.restfulStack.managedObjectStore] pathPattern:SUBSCRIPTIONS_URL_PATTERN];
}


-(void)postSubscription:(SubscriptionEntity *)subscription{
    
//    subscription.id = nil;
    
    RKEntityMapping *subscriptionEntityMapping = [Subscription createEntityMapping:self.restfulStack.managedObjectStore];
    
    [self.restfulStack createAndAddResponseDescriptor:subscriptionEntityMapping method:RKRequestMethodPOST pathPattern:SUBSCRIPTION_ID_URL_PATTERN];
    
    [self.restfulStack createAndAddRequestDescriptor:[subscriptionEntityMapping inverseMapping] objectClass:[SubscriptionEntity class] method:RKRequestMethodPOST];
    
    [self.restfulStack.objectManager setRequestSerializationMIMEType:RKMIMETypeJSON];
    [self.restfulStack.objectManager setAcceptHeaderWithMIMEType:RKMIMETypeJSON];
    
    [self.restfulStack.objectManager postObject:subscription path:SUBSCRIPTION_ID_URL_PATTERN parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        // subscription isNew = false + opslaan
        
        NSArray *result = [self.persistentStoreManager fetchByPredicate:[NSPredicate predicateWithFormat:@"id==%@", subscription.id] forEntity:[Subscription entityName]];
        
        SubscriptionEntity *subscriptionEntity = nil;
        
        if ([result count] != 0) {
            subscriptionEntity = [result objectAtIndex:0];
            subscriptionEntity.isNew = 0;
            [self.persistentStoreManager save:subscriptionEntity];
        }
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        // subscription isNew = true
    }];
}

//-(void)pullSubscriptionsSince:(NSDate *)timeStamp{
//    
//    
//}

-(void)pushNewSubscriptions{
    
    NSArray *newSubscriptions = nil;
    
    newSubscriptions = [self.persistentStoreManager fetchByPredicate:[NSPredicate predicateWithFormat:@"isNew==%@", 1] forEntity:[Subscription entityName]];
    
    if ([newSubscriptions count] != 0) {
        for (SubscriptionEntity *subscriptionEntity in newSubscriptions) {
            [self postSubscription:subscriptionEntity];
        }
    }
}


@end
