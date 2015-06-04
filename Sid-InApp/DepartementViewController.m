//
//  DepartementViewController.m
//  Sid-InApp
//
//  Created by  on 04/06/15.
//  Copyright (c) 2015 Ehb.be. All rights reserved.
//

#import "DepartementViewController.h"

#import <RestKit/CoreData.h>
#import <RestKit/RestKit.h>


@interface DepartementViewController ()

@end

@implementation DepartementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // ophalen alle data voor een departement
    BOOL succes = [self initializeDataForDepartement];
    
    NSMutableString *succesResult;
    
    if (succes) {
        succesResult = [NSMutableString stringWithString:@"GESLAAGD"];
    } else {
        succesResult = [NSMutableString stringWithFormat:@"NIET GESLAAGD"];
    }
    
    NSLog(@"Ophalen van de departementale data: %@", succesResult);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)initializeDataForDepartement{
    
    __block BOOL teachersSucces = NO;
    __block BOOL eventsSucces = NO;
    __block BOOL schoolsSucces = NO;
    __block BOOL subscriptionsSucces = NO;
    __block BOOL imagesSucces = NO;
    
    NSString *teachersRequestPath = @"/rest/teachers";
    
    [[RKObjectManager sharedManager] getObjectsAtPath:teachersRequestPath
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                                                  // teachers have been saved in core data by now
                                                  // [self fetchTitlesFromContext]; ==> custom methode om data terug uit db op de vragen
                                                  teachersSucces = YES;
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error){
                                                  RKLogError(@"Er is een error opgetreden tijdens het laden: %@", error);
                                              }];

    
    NSString *eventsRequestPath = @"/rest/events";
    
    [[RKObjectManager sharedManager] getObjectsAtPath:eventsRequestPath
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                                                  eventsSucces = YES;
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error){
                                                  RKLogError(@"Er is een error opgetreden tijdens het laden: %@", error);
                                              }];
    
    NSString *schoolsRequestPath = @"/rest/schools";
    
    [[RKObjectManager sharedManager] getObjectsAtPath:schoolsRequestPath
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                                                  schoolsSucces = YES;
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error){
                                                  RKLogError(@"Er is een error opgetreden tijdens het laden: %@", error);
                                              }];
    
    NSString *subscriptionsRequestPath = @"/rest/subscriptions";
    
    [[RKObjectManager sharedManager] getObjectsAtPath:subscriptionsRequestPath
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                                                  subscriptionsSucces = YES;
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error){
                                                  RKLogError(@"Er is een error opgetreden tijdens het laden: %@", error);
                                              }];
    
    NSString *imagesRequestPath = @"/rest/image";
    
    [[RKObjectManager sharedManager] getObjectsAtPath:imagesRequestPath
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                                                  imagesSucces = YES;
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error){
                                                  RKLogError(@"Er is een error opgetreden tijdens het laden: %@", error);
                                              }];
    
    
    return teachersSucces && eventsSucces && schoolsSucces && subscriptionsSucces && imagesSucces;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
