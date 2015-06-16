//
//  DepartementViewController.h
//  Sid-InApp
//
//  Created by  on 04/06/15.
//  Copyright (c) 2015 Ehb.be. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SynchronizationService.h"
#import "AppStart.h"

@interface DepartementViewController : UIViewController <UIAlertViewDelegate>

@property (nonatomic, strong) SynchronizationService *synchronizationService;

@property (nonatomic, strong) AppStart *appStart;

@end

//-(BOOL)initializeDataForDepartement{
//    
//    __block BOOL teachersSucces = NO;
//    __block BOOL eventsSucces = NO;
//    __block BOOL schoolsSucces = NO;
//    __block BOOL subscriptionsSucces = NO;
//    __block BOOL imagesSucces = NO;
//    
//    NSString *teachersRequestPath = @"/rest/teachers";
//    
//    [[RKObjectManager sharedManager] getObjectsAtPath:teachersRequestPath
//                                           parameters:nil
//                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
//                                                  // teachers have been saved in core data by now
//                                                  // [self fetchTitlesFromContext]; ==> custom methode om data terug uit db op de vragen
//                                                  teachersSucces = YES;
//                                              }
//                                              failure:^(RKObjectRequestOperation *operation, NSError *error){
//                                                  RKLogError(@"Er is een error opgetreden tijdens het laden: %@", error);
//                                              }];
//    
//    
//    NSString *eventsRequestPath = @"/rest/events";
//    
//    [[RKObjectManager sharedManager] getObjectsAtPath:eventsRequestPath
//                                           parameters:nil
//                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
//                                                  eventsSucces = YES;
//                                              }
//                                              failure:^(RKObjectRequestOperation *operation, NSError *error){
//                                                  RKLogError(@"Er is een error opgetreden tijdens het laden: %@", error);
//                                              }];
//    
//    NSString *schoolsRequestPath = @"/rest/schools";
//    
//    [[RKObjectManager sharedManager] getObjectsAtPath:schoolsRequestPath
//                                           parameters:nil
//                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
//                                                  schoolsSucces = YES;
//                                              }
//                                              failure:^(RKObjectRequestOperation *operation, NSError *error){
//                                                  RKLogError(@"Er is een error opgetreden tijdens het laden: %@", error);
//                                              }];
//    
//    NSString *subscriptionsRequestPath = @"/rest/subscriptions";
//    
//    [[RKObjectManager sharedManager] getObjectsAtPath:subscriptionsRequestPath
//                                           parameters:nil
//                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
//                                                  subscriptionsSucces = YES;
//                                              }
//                                              failure:^(RKObjectRequestOperation *operation, NSError *error){
//                                                  RKLogError(@"Er is een error opgetreden tijdens het laden: %@", error);
//                                              }];
//    
//    NSString *imagesRequestPath = @"/rest/image";
//    
//    [[RKObjectManager sharedManager] getObjectsAtPath:imagesRequestPath
//                                           parameters:nil
//                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
//                                                  imagesSucces = YES;
//                                              }
//                                              failure:^(RKObjectRequestOperation *operation, NSError *error){
//                                                  RKLogError(@"Er is een error opgetreden tijdens het laden: %@", error);
//                                              }];
//    
//    
//    return teachersSucces && eventsSucces && schoolsSucces && subscriptionsSucces && imagesSucces;
//}
