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
@property (nonatomic, strong) SubscriptionEntity *subscriptionToDelete;

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
    
    if ([RestfulStack isRestReachable]) {
        [self pullEvents];
        [self pullTeachers];
        [self pullSchools];
        [self pullSubscriptions];
        [self pullImages];
    }
}


-(void)pullEntities:(RKMapping *)mapping pathPattern:(NSString *)path{
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    
    [self.restfulStack createAndAddResponseDescriptor:mapping method:RKRequestMethodGET pathPattern:path];
    
    [self.restfulStack.objectManager getObjectsAtPath:path
                                           parameters:nil
                                              success:
     ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        
        if ([path caseInsensitiveCompare:EVENTS_URL_PATTERN] == NSOrderedSame) {
            
            [self updateEvents];
        } else if ([path caseInsensitiveCompare:TEACHERS_URL_PATTERN] == NSOrderedSame){
            
            [self updateTeachers];
        } else if ([path caseInsensitiveCompare:SUBSCRIPTIONS_URL_PATTERN] == NSOrderedSame) {
            
            [self updateSubscriptions:YES];
        }
        
    } failure:
     ^(RKObjectRequestOperation *operation, NSError *error) {
         
         [self updateSubscriptions:NO];
         
        RKLogError(@"Er is een error opgetreden tijdens het laden: %@", error);
    }];
}

-(void)updateSubscriptions:(BOOL)status{
    
    if (status && self.subscriptionToDelete) {
        [self.persistentStoreManager deleteObject:self.subscriptionToDelete];
        [self.persistentStoreManager save];
    } else if (!status && self.subscriptionToDelete) {
        
        self.subscriptionToDelete.sNew = [NSNumber numberWithBool:YES];
        [self.persistentStoreManager save:self.subscriptionToDelete];
        self.subscriptionToDelete = nil;
    }
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
    
    if (![self hasImageVersion] || [self hasNewImageVersion]) {
        [self pullEntities:[ImageList createEntityMapping:self.restfulStack.managedObjectStore] pathPattern:IMAGE_URL_PATTERN];
    }
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
    

    // http://stackoverflow.com/questions/19603976/why-is-restkit-changing-my-response-content-type
    // http://stackoverflow.com/questions/19583395/restkit-error-on-get-operation
    [RKMIMETypeSerialization registerClass:[RKNSJSONSerialization class] forMIMEType:@"text/html"];
    [self.restfulStack.objectManager setRequestSerializationMIMEType:RKMIMETypeJSON];
    [self.restfulStack.objectManager setAcceptHeaderWithMIMEType:RKMIMETypeJSON];
    
    [self.restfulStack.objectManager postObject:subscription
                                           path:SUBSCRIPTION_URL_PATTERN
                                     parameters:nil
                                        success:
     ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
         
         [self updatePostSubscription:subscriptionModified status:YES];
//        [self.persistentStoreManager save];
//         [self pullSubscriptions];
    }
                                        failure:
     ^(RKObjectRequestOperation *operation, NSError *error) {
         
        [self updatePostSubscription:subscriptionModified status:NO];
         
//        subscriptionModified.sNew = [NSNumber numberWithBool:YES];
//        [self.persistentStoreManager save];
    }];
}

-(void)updatePostSubscription:(SubscriptionEntity *)subscription status:(BOOL)status{
    
    if (status) {
        
        self.subscriptionToDelete = subscription;
        
        [self pullSubscriptions];
    } else {
        
        subscription.sNew = [NSNumber numberWithBool:YES];
        [self.persistentStoreManager save:subscription];
    }
}

-(void)pushNewSubscriptions{
    
    NSArray *newSubscriptions = nil;
    
    if ([RestfulStack isRestReachable]) {
        
        newSubscriptions = [self.persistentStoreManager fetchByPredicate:[NSPredicate predicateWithFormat:@"sNew==%@", [NSNumber numberWithBool:YES]] forEntity:[Subscription entityName]];
        
        if ([newSubscriptions count] != 0) {
            
            for (SubscriptionEntity *subscriptionEntity in newSubscriptions) {
                
                [self postSubscription:subscriptionEntity];            }
        }
    }
}

-(void)startSynchronization{
    
    [self initializeTimer];
}

-(void)stopSynchronization{
    
    [self.timer invalidate];
}

-(void)synchronize{
    
    [self pushNewSubscriptions];
    
    if (self.timer) {
        [self resetTimer];
    }
}

-(void)initializeTimer{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3600 target:self selector:@selector(synchronize) userInfo:nil repeats:NO];
}

-(void)resetTimer{
    
    [self.timer invalidate];
    [self initializeTimer];
}

-(NSArray *)subscriptionsByDate:(NSDate *)date{
    
    NSDate *today = [PersistentStoreManager convertToDateWithoutTime:date];
    
    NSArray *subscriptions = [self.persistentStoreManager fetchAll:[Subscription entityName]];
    
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    for (SubscriptionEntity *subscription in subscriptions) {
        NSDate *dateSubscription = [PersistentStoreManager convertLongLongToDate:(long)subscription.timestamp];
        if ([today isEqualToDate:dateSubscription]) {
            [results addObject:subscription];
        }
    }
    
    return results;
}

// http://stackoverflow.com/questions/19030513/how-to-check-for-network-reachability-in-ios
-(BOOL)isRestReachable{
    
    CFNetDiagnosticRef diagnosticReference = nil;
    diagnosticReference = CFNetDiagnosticCreateWithURL(NULL, (__bridge CFURLRef)[NSURL URLWithString:BASE_SERVICE_URL]);
    
    CFNetDiagnosticStatus status = 0;
    status = CFNetDiagnosticCopyNetworkStatusPassively(diagnosticReference, NULL);
    
    CFRelease(diagnosticReference);
    
    if (status == kCFNetDiagnosticConnectionUp) {
        
        return YES;
    } else {
        return NO;
    }
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

-(void)updatePostSubscription{
    
    for (id<SynchronizationObserver> observer in self.obervers) {
        
        [observer updatePostSubscription];
    }
}

-(void)updateImages{
    for (id<SynchronizationObserver> observer in self.obervers) {
        [observer updateImages];
    }
}

@end
