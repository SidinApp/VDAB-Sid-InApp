//
//  AppDelegate.m
//  Sid-InApp
//
//  Created by  on 04/06/15.
//  Copyright (c) 2015 Ehb.be. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // kleur text STATUS BAR: wit
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    // RESTKit
    NSURL *baseURL = [NSURL URLWithString:@"http://vdabsidin3.appspot.com"];
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:baseURL];
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    objectManager.managedObjectStore = managedObjectStore;
        [managedObjectStore createPersistentStoreCoordinator];
    NSString *storePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"SidInDB.sqlite"];
    NSString *seedPath = [[NSBundle mainBundle] pathForResource:@"RKSeedDatabase" ofType:@"sqlite"];
    NSError *error;
    NSPersistentStore *persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:storePath fromSeedDatabaseAtPath:seedPath withConfiguration:nil options:nil error:&error];
    NSAssert(persistentStore, @"Er is een fout opgetreden bij het toevoegen van de persistent store: %@", error);
    [managedObjectStore createManagedObjectContexts];
        managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:managedObjectStore.persistentStoreManagedObjectContext];
    
    
    // RESTKit: entiteiten mappen op RESTKit
    RKEntityMapping *teacherMapping = [RKEntityMapping mappingForEntityForName:@"Teacher" inManagedObjectStore:managedObjectStore];
    teacherMapping.identificationAttributes = @[@"id"];
    [teacherMapping addAttributeMappingsFromDictionary:@{
                                                         @"id" : @"id",
                                                         @"name" : @"name",
                                                         @"acadyear" : @"acadyear",
                                                         }];
    RKEntityMapping *teacherContainerMapping = [RKEntityMapping mappingForEntityForName:@"TeacherContainer" inManagedObjectStore:managedObjectStore];
    [teacherContainerMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"teachers" toKeyPath:@"teachers" withMapping:teacherMapping]];
    
    RKEntityMapping *eventMapping = [RKEntityMapping mappingForEntityForName:@"Event" inManagedObjectStore:managedObjectStore];
    eventMapping.identificationAttributes = @[@"id"];
    [eventMapping addAttributeMappingsFromDictionary:@{
                                                      @"id" : @"id",
                                                      @"name" : @"name",
                                                      @"acadyear" : @"acadyear",
                                                      }];
    RKEntityMapping *eventContainerMapping = [RKEntityMapping mappingForEntityForName:@"EventContainer" inManagedObjectStore:managedObjectStore];
    [eventContainerMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"events" toKeyPath:@"events" withMapping:eventMapping]];
    
    RKEntityMapping *schoolMapping = [RKEntityMapping mappingForEntityForName:@"School" inManagedObjectStore:managedObjectStore];
    schoolMapping.identificationAttributes = @[@"id"];
    [schoolMapping addAttributeMappingsFromDictionary:@{
                                                      @"id" : @"id",
                                                      @"name" : @"name",
                                                      @"gemeente" : @"gemeente",
                                                      @"postcode" : @"postcode",
                                                      }];
    RKEntityMapping *schoolContainerMapping = [RKEntityMapping mappingForEntityForName:@"SchoolContainer" inManagedObjectStore:managedObjectStore];
    [schoolContainerMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"schools" toKeyPath:@"schools" withMapping:schoolMapping]];
    
    RKEntityMapping *interestsMapping = [RKEntityMapping mappingForEntityForName:@"Interests" inManagedObjectStore:managedObjectStore];
    [interestsMapping addAttributeMappingsFromDictionary:@{
                                                        @"digx" : @"digx",
                                                        @"multec" : @"multec",
                                                        @"werkstudent" : @"werkstudent",
                                                        }];
    
    RKEntityMapping *subscriptionMapping = [RKEntityMapping mappingForEntityForName:@"Subscription" inManagedObjectStore:managedObjectStore];
    subscriptionMapping.identificationAttributes = @[@"id"];
    [subscriptionMapping addAttributeMappingsFromDictionary:@{
                                                           @"id" : @"id",
                                                           @"firstName" : @"firstName",
                                                           @"lastName" : @"lastName",
                                                           @"email" : @"email",
                                                           @"street" : @"street",
                                                           @"streetNumber" : @"streetNumber",
                                                           @"zip" : @"zip",
                                                           @"city" : @"city",
                                                           @"timeStamp" : @"timeStamp",
                                                           @"isNew" : @"isNew",
                                                           }];
    [subscriptionMapping addPropertyMappingsFromArray:@[
                                                        [RKRelationshipMapping relationshipMappingFromKeyPath:@"interests" toKeyPath:@"interests" withMapping:interestsMapping],
                                                        [RKRelationshipMapping relationshipMappingFromKeyPath:@"teacher" toKeyPath:@"teacher" withMapping:teacherMapping],
                                                        [RKRelationshipMapping relationshipMappingFromKeyPath:@"event" toKeyPath:@"event" withMapping:eventMapping],
                                                        [RKRelationshipMapping relationshipMappingFromKeyPath:@"school" toKeyPath:@"school" withMapping:schoolMapping]]];
    RKEntityMapping *subscriptionContainerMapping = [RKEntityMapping mappingForEntityForName:@"SubscriptionContainer" inManagedObjectStore:managedObjectStore];
    [subscriptionContainerMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"subscriptions" toKeyPath:@"subscriptions" withMapping:subscriptionMapping]];
    
    RKEntityMapping *imageMapping = [RKEntityMapping mappingForEntityForName:@"Image" inManagedObjectStore:managedObjectStore];
    imageMapping.identificationAttributes = @[@"id"];
    [imageMapping addAttributeMappingsFromDictionary:@{
                                                         @"id" : @"id",
                                                         @"priority" : @"priority",
                                                         @"image" : @"image",
                                                         }];
    RKEntityMapping *imageContainerMapping = [RKEntityMapping mappingForEntityForName:@"ImageContainer" inManagedObjectStore:managedObjectStore];
    [imageContainerMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"images" toKeyPath:@"images" withMapping:imageMapping]];
    
    
    
    
    // RESTKit: teachers GET:/api/teachers
    RKResponseDescriptor *teachersGETResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:teacherContainerMapping
                                                                                                    method:RKRequestMethodGET
                                                                                               pathPattern:@"/rest/teachers"
                                                                                                   keyPath:nil
                                                                                               statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:teachersGETResponseDescriptor];
    
    // RESTKit: events GET:/api/events
    RKResponseDescriptor *eventsGETResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:eventContainerMapping
                                                                                                       method:RKRequestMethodGET
                                                                                                  pathPattern:@"/rest/events"
                                                                                                      keyPath:nil
                                                                                                  statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:eventsGETResponseDescriptor];
    
    // RESTKit: schools GET:/api/schools
    RKResponseDescriptor *schoolsGETResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:schoolContainerMapping
                                                                                                     method:RKRequestMethodGET
                                                                                                pathPattern:@"/rest/schools"
                                                                                                    keyPath:nil
                                                                                                statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:schoolsGETResponseDescriptor];
    
    // RESTKit: subscriptions GET:/api/subscriptions
    RKResponseDescriptor *subscriptionsGETResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:subscriptionContainerMapping
                                                                                                      method:RKRequestMethodGET
                                                                                                 pathPattern:@"/rest/subscriptions"
                                                                                                     keyPath:nil
                                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:subscriptionsGETResponseDescriptor];
    
    // RESTKit: subscription POST:/api/subscription
    RKResponseDescriptor *subscriptionPOSTResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:subscriptionMapping
                                                                                                            method:RKRequestMethodPOST
                                                                                                       pathPattern:@"/rest/subscription"
                                                                                                           keyPath:nil
                                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:subscriptionPOSTResponseDescriptor];
    
    // RESTKit: images GET:/api/image
    RKResponseDescriptor *imagesGETResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:imageContainerMapping
                                                                                                            method:RKRequestMethodGET
                                                                                                       pathPattern:@"/rest/image"
                                                                                                           keyPath:nil
                                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:imagesGETResponseDescriptor];
    
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    
    NSLog(@"Locatie van de databank: %@",[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
