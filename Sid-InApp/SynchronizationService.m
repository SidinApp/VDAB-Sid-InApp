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
#import "ImageVersionEntity.h"

@interface SynchronizationService ()

@property (nonatomic, strong, readwrite) RestfulStack *restfulStack;
@property (nonatomic, strong, readwrite) PersistentStoreManager *persistentStoreManager;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) NSMutableArray *obervers;

@end

@implementation SynchronizationService

-(id)initWithRestfulStack:(RestfulStack *)restfulStack persistentStoreManager:(PersistentStoreManager *)persistentStoreManager{
    
    if (self = [super init]) {
        self.restfulStack = restfulStack;
        self.persistentStoreManager = persistentStoreManager;
        self.obervers = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(void)initializePersistentStoreFromBackEnd{
    
    // code controle of er al data bestaat in de store
    
    [self pullEvents];
    [self pullTeachers];
    [self pullSchools];
    [self pullSubscriptions];
//    [self pullImages];
}

-(void)pullEntities:(RKMapping *)mapping pathPattern:(NSString *)path{
    
    ///*
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    // wordt nu gedaan in RestKit; ook de requestDescripters
    [self.restfulStack createAndAddResponseDescriptor:mapping method:RKRequestMethodGET pathPattern:path];
    
    [self.restfulStack.objectManager getObjectsAtPath:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        // do something when
        
        if ([path caseInsensitiveCompare:EVENTS_URL_PATTERN] == NSOrderedSame) {
            [self updateEvents];
//            int count = 0;
//            count = [self.persistentStoreManager countForEntity:[Event entityName]];
//            NSLog(@"%@", count);
        } else if ([path caseInsensitiveCompare:TEACHERS_URL_PATTERN] == NSOrderedSame){
            [self updateTeachers];
        }
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Er is een error opgetreden tijdens het laden: %@", error);
        [self update];
    }];
    //*/

    /*
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BASE_SERVICE_URL, path]]];
    RKResponseDescriptor *resonseDescriptor = [self.restfulStack createAndAddResponseDescriptor:mapping method:RKRequestMethodGET pathPattern:path];
    
    RKManagedObjectRequestOperation *managedOperation = [[RKManagedObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[resonseDescriptor]];
    
    managedOperation.managedObjectContext = self.restfulStack.managedObjectStore.mainQueueManagedObjectContext;
    managedOperation.managedObjectCache = self.restfulStack.managedObjectStore.managedObjectCache;
    
    [managedOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        NSLog(@"Entiteiten zijn opgehaald");
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"Entiteiten zijn niet opgehaald");
    }];
    
    
    [managedOperation start];
//    [managedOperation waitUntilFinished];
     */
    
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
//    [self pullEntities:[ImageList createEntityMapping:self.restfulStack.managedObjectStore] pathPattern:IMAGE_URL_PATTERN];
    
    if (![self hasImageVersion] || [self hasNewImageVersion]) {
        [self pullEntities:[ImageList createEntityMapping:self.restfulStack.managedObjectStore] pathPattern:IMAGE_URL_PATTERN];
    }
    
    
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

-(BOOL)hasImageVersion{
    
    return [self.persistentStoreManager countForEntity:IMAGE_VERSION] > 0;
}

-(BOOL)hasNewImageVersion{
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BASE_SERVICE_URL, IMAGE_VERSION_URL_PATTERN]]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    
    [request setHTTPMethod: @"GET"];
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    NSString* version = [[NSString alloc] initWithData:response
                                          encoding:NSUTF8StringEncoding];
    
    if ([self.persistentStoreManager countForEntity:IMAGE_VERSION forPredicate:[NSPredicate predicateWithFormat:@"version==%@", version]] > 0) {
        return NO;
    }
    
    NSArray *imageVersions = [self.persistentStoreManager fetchAll:IMAGE_VERSION];
    
    for (NSManagedObject *imageVersion in imageVersions) {
        [self.persistentStoreManager delete:imageVersion];
    }
    
    ImageVersionEntity *imageVersion = (ImageVersionEntity *)[self.persistentStoreManager insert:IMAGE_VERSION];
    imageVersion.version = version;
    
    [self.persistentStoreManager save];
    
    return YES;
}

-(void)pullSubscriptions{
    
    [self pullEntities:[SubscriptionList createEntityMapping:self.restfulStack.managedObjectStore] pathPattern:SUBSCRIPTIONS_URL_PATTERN];
}


-(void)postSubscription:(SubscriptionEntity *)subscription{
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    subscription.id = nil;
    
    __block SubscriptionEntity *subscriptionModified = subscription;
    
    RKEntityMapping *subscriptionEntityMapping = [Subscription createEntityMapping:self.restfulStack.managedObjectStore];
    
    [self.restfulStack createAndAddResponseDescriptor:subscriptionEntityMapping method:RKRequestMethodPOST pathPattern:SUBSCRIPTION_URL_PATTERN];
    
    [self.restfulStack createAndAddRequestDescriptor:[subscriptionEntityMapping inverseMapping] objectClass:[SubscriptionEntity class] method:RKRequestMethodPOST];
    
    [self.restfulStack.objectManager setRequestSerializationMIMEType:RKMIMETypeJSON];
    [self.restfulStack.objectManager setAcceptHeaderWithMIMEType:RKMIMETypeJSON];
    
    // http://stackoverflow.com/questions/19583395/restkit-error-on-get-operation
//    [RKMIMETypeSerialization registerClass:[RKXMLReaderSerialization class] forMIMEType:RKMIMETypeTextXML];
//    [objectManager setAcceptHeaderWithMIMEType:@"text/xml"];
    
    
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
        [self.persistentStoreManager save];
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        // subscription isNew = true + opslaan
        
//        subscriptionModified.isNew = [NSNumber numberWithInt:1];
        
//        subscriptionModified.isNew = @NO;
//         NSLog(@"SUB MOD %@", subscriptionModified.isNew);
        subscriptionModified.sNew = [NSNumber numberWithBool:YES];
        [self.persistentStoreManager save];
    }];
}

//-(void)pullSubscriptionsSince:(NSDate *)timeStamp{
//    
//    
//}

-(void)pushNewSubscriptions{
    
    NSArray *newSubscriptions = nil;
    
    newSubscriptions = [self.persistentStoreManager fetchByPredicate:[NSPredicate predicateWithFormat:@"sNew==%@", 1] forEntity:[Subscription entityName]];
    
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

-(NSArray *)subscriptionsByDate:(NSDate *)date{
    
    NSDate *today = [self convertToDateWithoutTime:date];
    
    NSArray *subscriptions = [self.persistentStoreManager fetchAll:[Subscription entityName]];
    
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    for (SubscriptionEntity *subscription in subscriptions) {
        NSDate *dateSubscription = [self convertLongToDate:(long)subscription.timestamp];
        if ([today isEqualToDate:dateSubscription]) {
            [results addObject:subscription];
        }
    }
    
    return results;
}

-(NSDate *)convertLongToDate:(long)longDate{
    return [NSDate dateWithTimeIntervalSince1970:longDate / 1000];
}

-(NSDate *)convertToDateWithoutTime:(NSDate *)date{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned units = NSYearCalendarUnit | NSMoviesDirectory | NSDayCalendarUnit;
    NSDateComponents *components = [calendar components:units fromDate:date];
    NSDate *dateOnly = [calendar dateFromComponents:components];
    [dateOnly dateByAddingTimeInterval:(60 * 60 * 12)];
    return dateOnly;
}

-(void)addObserver:(id<SynchronizationObserver>)observer{
    
    [self.obervers addObject:observer];
}

-(void)update{
    
    for (id<SynchronizationObserver> observer in self.obervers) {
        [observer update];
    }
}

-(void)updateEvents{
    for (id<SynchronizationObserver> observer in self.obervers) {
        [observer updateEvents];
    }
}

-(void)updateTeachers{
    for (id<SynchronizationObserver> observer in self.obervers) {
        [observer updateTeachers];
    }
}

-(void)updateSchools{
    for (id<SynchronizationObserver> observer in self.obervers) {
        [observer updateSchools];
    }
}

-(void)updateSubscriptions{
    for (id<SynchronizationObserver> observer in self.obervers) {
        [observer updateSubscriptions];
    }
}

-(void)updateImages{
    for (id<SynchronizationObserver> observer in self.obervers) {
        [observer updateImages];
    }
}

@end
