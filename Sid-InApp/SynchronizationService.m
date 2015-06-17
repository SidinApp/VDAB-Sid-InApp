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

@property (nonatomic, strong) NSTimer *timer;

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
//    [self pullImages];
}

-(void)pullEntities:(RKMapping *)mapping pathPattern:(NSString *)path{
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    // wordt nu gedaan in RestKit; ook de requestDescripters
    [self.restfulStack createAndAddResponseDescriptor:mapping method:RKRequestMethodGET pathPattern:path];
    
    [self.restfulStack.objectManager getObjectsAtPath:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        // do something when
        NSLog(@"Entiteiten zijn opgehaald");
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Er is een error opgetreden tijdens het laden: %@", error);
    }];
    
//    [self.restfulStack.objectManager getObjectsAtPath:path parameters:nil success:nil failure:nil];
    
    
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
    
    // 1
    [self pullEntities:[ImageList createEntityMapping:self.restfulStack.managedObjectStore] pathPattern:IMAGE_URL_PATTERN];
    
    // 2
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BASE_SERVICE_URL, IMAGE_URL_PATTERN]]];
//    
//    RKManagedObjectRequestOperation *operation = [[RKManagedObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[[self.restfulStack createResponseDescriptor:[ImageList createEntityMapping:self.restfulStack.managedObjectStore] method:RKRequestMethodGET pathPattern:IMAGE_URL_PATTERN]]];
//    operation.managedObjectContext = self.restfulStack.managedObjectStore.mainQueueManagedObjectContext;
//    operation.managedObjectCache = self.restfulStack.managedObjectStore.managedObjectCache;
//    [operation setCompletionBlockWithSuccess:nil
//                                     failure:nil];
//    NSOperationQueue *operationQueue = [NSOperationQueue new];
//    [operationQueue addOperation:operation];
//    operation.successCallbackQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
//    operation.failureCallbackQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    
//    [self.restfulStack.objectManager enqueueObjectRequestOperation:operation];
    
    
    // 3
//    NSURLRequest *request = [self.restfulStack.objectManager requestWithObject:[Im] method:RKRequestMethodGET path:IMAGE_URL_PATTERN parameters:nil];
    
}

-(void)pullSubscriptions{
    
    [self pullEntities:[SubscriptionList createEntityMapping:self.restfulStack.managedObjectStore] pathPattern:SUBSCRIPTIONS_URL_PATTERN];
}


-(void)postSubscription:(SubscriptionEntity *)subscription{
    
    subscription.id = nil;
    
    __block SubscriptionEntity *subscriptionModified = subscription;
    
    RKEntityMapping *subscriptionEntityMapping = [Subscription createEntityMapping:self.restfulStack.managedObjectStore];
    
    [self.restfulStack createAndAddResponseDescriptor:subscriptionEntityMapping method:RKRequestMethodPOST pathPattern:SUBSCRIPTION_URL_PATTERN];
    
    [self.restfulStack createAndAddRequestDescriptor:[subscriptionEntityMapping inverseMapping] objectClass:[SubscriptionEntity class] method:RKRequestMethodPOST];
    
 [self.restfulStack.objectManager setRequestSerializationMIMEType:RKMIMETypeJSON];
    [self.restfulStack.objectManager setAcceptHeaderWithMIMEType:RKMIMETypeJSON];
    
    
    [self.restfulStack.objectManager postObject:subscription path:SUBSCRIPTION_URL_PATTERN parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        // subscription isNew = false + opslaan
        
//        NSArray *result = [self.persistentStoreManager fetchByPredicate:[NSPredicate predicateWithFormat:@"id==%@", subscription.id] forEntity:[Subscription entityName]];
//        
//        SubscriptionEntity *subscriptionEntity = nil;
//        
//        if ([result count] != 0) {
//            subscriptionEntity = [result objectAtIndex:0];
//            subscriptionEntity.isNew = [NSNumber numberWithInt:0];
//            [self.persistentStoreManager save:subscriptionEntity];
//        }
        
//        subscriptionModified.isNew = [NSNumber numberWithInt:0];
//        subscriptionModified.isNew = @NO;
//        [self.persistentStoreManager save];
        
//        NSLog(@"SUB MOD %@", subscriptionModified.isNew);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        // subscription isNew = true + opslaan
        
//        subscriptionModified.isNew = [NSNumber numberWithInt:1];
        
//        subscriptionModified.isNew = @NO;
//         NSLog(@"SUB MOD %@", subscriptionModified.isNew);
        
        [self.persistentStoreManager save];
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

-(void)startSynchronization{
    
    
    
    
//    [self.restfulStack.objectManager.HTTPClient setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        if (status == AFNetworkReachabilityStatusNotReachable) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No network connection"
//                                                            message:@"You must be connected to the internet to use this app."
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"OK"
//                                                  otherButtonTitles:nil];
//            [alert show];
//        }
//    }]
    
    [self initializeTimer];
    
}

-(void)stopSynchronization{
    [self.timer invalidate];
}

-(void)synchronize{
//    [self pushNewSubscriptions];
//    [self pullSubscriptions];
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"SYNC START" message:@"synchronizing" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
//    [alert show];
    NSLog(@"START SYNC");
    [self resetTimer];
}

-(void)initializeTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(synchronize) userInfo:nil repeats:NO];
}

-(void)resetTimer{
    [self.timer invalidate];
    [self initializeTimer];
    
}

+(NSDate *)convertLongToDate:(long)longDate{
    return [NSDate dateWithTimeIntervalSince1970:longDate / 1000];
}
+(NSDate *)convertToDateWithoutTime:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned units = NSYearCalendarUnit | NSMoviesDirectory | NSDayCalendarUnit;
    NSDateComponents *components = [calendar components:units fromDate:date];
    NSDate *dateOnly = [calendar dateFromComponents:components];
    [dateOnly dateByAddingTimeInterval:(60 * 60 * 12)];
    return dateOnly;
}


@end
