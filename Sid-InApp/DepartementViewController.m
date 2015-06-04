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
    
    NSString *teachersRequestPath = @"/rest/teachers";
    
    [[RKObjectManager sharedManager] getObjectsAtPath:teachersRequestPath
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                                                  // teachers have been saved in core data by now
                                                  //                                                  [self fetchTitlesFromContext];
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error){
                                                  RKLogError(@"Een error trad op tijdens het laden: %@", error);
                                              }];
    
    NSString *eventsRequestPath = @"/rest/events";
    
    [[RKObjectManager sharedManager] getObjectsAtPath:eventsRequestPath
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                                                  // teachers have been saved in core data by now
                                                  //                                                  [self fetchTitlesFromContext];
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error){
                                                  RKLogError(@"Een error trad op tijdens het laden: %@", error);
                                              }];
    
    NSString *schoolsRequestPath = @"/rest/schools";
    
    [[RKObjectManager sharedManager] getObjectsAtPath:schoolsRequestPath
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                                                  // teachers have been saved in core data by now
                                                  //                                                  [self fetchTitlesFromContext];
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error){
                                                  RKLogError(@"Een error trad op tijdens het laden: %@", error);
                                              }];
    
    NSString *subscriptionsRequestPath = @"/rest/subscriptions";
    
    [[RKObjectManager sharedManager] getObjectsAtPath:subscriptionsRequestPath
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                                                  // teachers have been saved in core data by now
                                                  //                                                  [self fetchTitlesFromContext];
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error){
                                                  RKLogError(@"Een error trad op tijdens het laden: %@", error);
                                              }];
    
    NSString *imagesRequestPath = @"/rest/image";
    
    [[RKObjectManager sharedManager] getObjectsAtPath:imagesRequestPath
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                                                  // teachers have been saved in core data by now
                                                  //                                                  [self fetchTitlesFromContext];
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error){
                                                  RKLogError(@"Een error trad op tijdens het laden: %@", error);
                                              }];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
