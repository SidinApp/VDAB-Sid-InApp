//
//  AppDelegate.h
//  Sid-InApp
//
//  Created by  on 04/06/15.
//  Copyright (c) 2015 Ehb.be. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PersistentStack.h"
#import "RestfulStack.h"
#import "SynchronizationService.h"
#import "PersistentStoreManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) PersistentStack *persistentStack;
@property (nonatomic, strong) RestfulStack *restfulStack;
@property (nonatomic, strong) PersistentStoreManager *persistentStoreManager;
@property (nonatomic, strong) SynchronizationService *synchronizationService;

@end

//-(void)initializeRestKit{
//
//    NSURL *baseURL = [NSURL URLWithString:BASE_SERVICE_URL];
//    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:baseURL];
//    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
//    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
//    objectManager.managedObjectStore = managedObjectStore;
//    [managedObjectStore createPersistentStoreCoordinator];
//    NSString *storePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:DATABASE_NAME];
//    NSString *seedPath = [[NSBundle mainBundle] pathForResource:@"RKSeedDatabase" ofType:@"sqlite"];
//    NSError *error;
//    NSPersistentStore *persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:storePath fromSeedDatabaseAtPath:seedPath withConfiguration:nil options:nil error:&error];
//    storeURL = persistentStore.URL;
//    NSAssert(persistentStore, @"Er is een fout opgetreden bij het toevoegen van de persistent store: %@", error);
//    [managedObjectStore createManagedObjectContexts];
//    managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:managedObjectStore.persistentStoreManagedObjectContext];
//
//
//    // RESTKit: entiteiten mappen op RESTKit
//    RKEntityMapping *teacherMapping = [RKEntityMapping mappingForEntityForName:@"Teacher" inManagedObjectStore:managedObjectStore];
//    teacherMapping.identificationAttributes = @[@"id"];
//    [teacherMapping addAttributeMappingsFromDictionary:@{
//                                                         @"id" : @"id",
//                                                         @"name" : @"name",
//                                                         @"acadyear" : @"acadyear",
//                                                         }];
//    RKEntityMapping *teacherContainerMapping = [RKEntityMapping mappingForEntityForName:@"TeacherContainer" inManagedObjectStore:managedObjectStore];
//    [teacherContainerMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"teachers" toKeyPath:@"teachers" withMapping:teacherMapping]];
//
//    RKEntityMapping *eventMapping = [RKEntityMapping mappingForEntityForName:@"Event" inManagedObjectStore:managedObjectStore];
//    eventMapping.identificationAttributes = @[@"id"];
//    [eventMapping addAttributeMappingsFromDictionary:@{
//                                                       @"id" : @"id",
//                                                       @"name" : @"name",
//                                                       @"acadyear" : @"acadyear",
//                                                       }];
//    RKEntityMapping *eventContainerMapping = [RKEntityMapping mappingForEntityForName:@"EventContainer" inManagedObjectStore:managedObjectStore];
//    [eventContainerMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"events" toKeyPath:@"events" withMapping:eventMapping]];
//
//    RKEntityMapping *schoolMapping = [RKEntityMapping mappingForEntityForName:@"School" inManagedObjectStore:managedObjectStore];
//    schoolMapping.identificationAttributes = @[@"id"];
//    [schoolMapping addAttributeMappingsFromDictionary:@{
//                                                        @"id" : @"id",
//                                                        @"name" : @"name",
//                                                        @"gemeente" : @"gemeente",
//                                                        @"postcode" : @"postcode",
//                                                        }];
//    RKEntityMapping *schoolContainerMapping = [RKEntityMapping mappingForEntityForName:@"SchoolContainer" inManagedObjectStore:managedObjectStore];
//    [schoolContainerMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"schools" toKeyPath:@"schools" withMapping:schoolMapping]];
//
//    RKEntityMapping *interestsMapping = [RKEntityMapping mappingForEntityForName:@"Interests" inManagedObjectStore:managedObjectStore];
//    [interestsMapping addAttributeMappingsFromDictionary:@{
//                                                           @"digx" : @"digx",
//                                                           @"multec" : @"multec",
//                                                           @"werkstudent" : @"werkstudent",
//                                                           }];
//
//    RKEntityMapping *subscriptionMapping = [RKEntityMapping mappingForEntityForName:@"Subscription" inManagedObjectStore:managedObjectStore];
//    subscriptionMapping.identificationAttributes = @[@"id"];
//    [subscriptionMapping addAttributeMappingsFromDictionary:@{
//                                                              @"id" : @"id",
//                                                              @"firstName" : @"firstName",
//                                                              @"lastName" : @"lastName",
//                                                              @"email" : @"email",
//                                                              @"street" : @"street",
//                                                              @"streetNumber" : @"streetNumber",
//                                                              @"zip" : @"zip",
//                                                              @"city" : @"city",
//                                                              @"timeStamp" : @"timeStamp",
//                                                              @"new" : @"isNew",
//                                                              }];
//    [subscriptionMapping addPropertyMappingsFromArray:@[
//                                                        [RKRelationshipMapping relationshipMappingFromKeyPath:@"interests" toKeyPath:@"interests" withMapping:interestsMapping],
//                                                        [RKRelationshipMapping relationshipMappingFromKeyPath:@"teacher" toKeyPath:@"teacher" withMapping:teacherMapping],
//                                                        [RKRelationshipMapping relationshipMappingFromKeyPath:@"event" toKeyPath:@"event" withMapping:eventMapping],
//                                                        [RKRelationshipMapping relationshipMappingFromKeyPath:@"school" toKeyPath:@"school" withMapping:schoolMapping]]];
//    RKEntityMapping *subscriptionContainerMapping = [RKEntityMapping mappingForEntityForName:@"SubscriptionContainer" inManagedObjectStore:managedObjectStore];
//    [subscriptionContainerMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"subscriptions" toKeyPath:@"subscriptions" withMapping:subscriptionMapping]];
//
//    RKEntityMapping *imageMapping = [RKEntityMapping mappingForEntityForName:@"Image" inManagedObjectStore:managedObjectStore];
//    imageMapping.identificationAttributes = @[@"id"];
//    [imageMapping addAttributeMappingsFromDictionary:@{
//                                                       @"id" : @"id",
//                                                       @"priority" : @"priority",
//                                                       @"image" : @"image",
//                                                       }];
//    RKEntityMapping *imageContainerMapping = [RKEntityMapping mappingForEntityForName:@"ImageContainer" inManagedObjectStore:managedObjectStore];
//    [imageContainerMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"images" toKeyPath:@"images" withMapping:imageMapping]];
//
//
//
//
//    // RESTKit: teachers GET:/api/teachers
//    RKResponseDescriptor *teachersGETResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:teacherContainerMapping
//                                                                                                       method:RKRequestMethodGET
//                                                                                                  pathPattern:TEACHERS_URL_PATTERN
//                                                                                                      keyPath:nil
//                                                                                                  statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
//    [objectManager addResponseDescriptor:teachersGETResponseDescriptor];
//
//    // RESTKit: events GET:/api/events
//    RKResponseDescriptor *eventsGETResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:eventContainerMapping
//                                                                                                     method:RKRequestMethodGET
//                                                                                                pathPattern:EVENTS_URL_PATTERN
//                                                                                                    keyPath:nil
//                                                                                                statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
//    [objectManager addResponseDescriptor:eventsGETResponseDescriptor];
//
//    // RESTKit: schools GET:/api/schools
//    RKResponseDescriptor *schoolsGETResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:schoolContainerMapping
//                                                                                                      method:RKRequestMethodGET
//                                                                                                 pathPattern:SCHOOLS_URL_PATTERN
//                                                                                                     keyPath:nil
//                                                                                                 statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
//    [objectManager addResponseDescriptor:schoolsGETResponseDescriptor];
//
//    // RESTKit: subscriptions GET:/api/subscriptions
//    RKResponseDescriptor *subscriptionsGETResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:subscriptionContainerMapping
//                                                                                                            method:RKRequestMethodGET
//                                                                                                       pathPattern:SUBSCRIPTIONS_URL_PATTERN
//                                                                                                           keyPath:nil
//                                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
//    [objectManager addResponseDescriptor:subscriptionsGETResponseDescriptor];
//
//    // RESTKit: subscription POST:/api/subscription
//    RKResponseDescriptor *subscriptionPOSTResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:subscriptionMapping
//                                                                                                            method:RKRequestMethodPOST
//                                                                                                       pathPattern:SUBSCRIPTION_URL_PATTERN
//                                                                                                           keyPath:nil
//                                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
//    [objectManager addResponseDescriptor:subscriptionPOSTResponseDescriptor];
//
//    // RESTKit: images GET:/api/image
//    RKResponseDescriptor *imagesGETResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:imageContainerMapping
//                                                                                                     method:RKRequestMethodGET
//                                                                                                pathPattern:IMAGE_URL_PATTERN
//                                                                                                    keyPath:nil
//                                                                                                statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
//    [objectManager addResponseDescriptor:imagesGETResponseDescriptor];
//
//
//    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
//
//}

//-(void)deleteAndRecreateStore{
//    NSError *error;
//    NSManagedObjectContext *managedObjectContext = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
//
//    NSPersistentStoreCoordinator *storeCoord = managedObjectContext.persistentStoreCoordinator;
//
//    [storeCoord removePersistentStore:storeCoord.persistentStores[0] error:&error];
//    [[NSFileManager defaultManager] removeItemAtPath:storeURL.path error:&error];
//
//
//}

