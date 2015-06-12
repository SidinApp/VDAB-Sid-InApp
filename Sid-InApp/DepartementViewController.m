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

#import "Subscription.h"
#import "LoginViewController.h"


@interface DepartementViewController ()

@end

@implementation DepartementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // ophalen alle data voor een departement
//    BOOL succes = [self initializeDataForDepartement];
    
//    NSMutableString *succesResult;
    
//    if (succes) {
//        succesResult = [NSMutableString stringWithString:@"GESLAAGD"];
//    } else {
//        succesResult = [NSMutableString stringWithFormat:@"NIET GESLAAGD"];
//    }
    
//    NSManagedObjectContext *c = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
//    
//    Subscription *s = [[Subscription alloc] initWithEntity:@"Subscription" insertIntoManagedObjectContext:c];
//    s.firstName = @"test";
    
//    NSLog(@"Ophalen van de departementale data: %@", succesResult);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


///*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"modalSegueToLogin"]) {
        LoginViewController *viewController = [segue destinationViewController];
        viewController.synchronizationService = self.synchronizationService;
    }
    
}
//*/

@end
