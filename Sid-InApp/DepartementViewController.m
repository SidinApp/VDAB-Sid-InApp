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

@property (weak, nonatomic) IBOutlet UITextField *tfSecret;

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
    
    // test synchronization
//    [self.synchronizationService startSynchronization];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startAppBtn:(UIButton *)sender {
    
    [self.appStart initializeApp:self.tfSecret.text];
    
    if ([self.appStart hasBeenInitialized]) {
        [self performSegueWithIdentifier:@"modalSegueToLogin" sender:sender];
    } else {
        // popover: verkeerde code
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Departementale Code"
                                                                                          message:@"Een foute code werd ingegeven. Probeer opnieuw."
                                                                                         delegate:self
                                                                                cancelButtonTitle:nil
                                                                                otherButtonTitles:@"Ok", nil];
        
        alert.tag = 100;
        
        [alert show];
        
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 100) {
        self.tfSecret.text = @"";
        self.tfSecret.layer.borderColor =[[UIColor redColor]CGColor];
        self.tfSecret.layer.borderWidth = 1.0f;
    }    
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
