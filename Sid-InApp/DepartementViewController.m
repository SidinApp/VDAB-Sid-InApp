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
#import "Event.h"


@interface DepartementViewController (){
    int counter;
    NSArray *events;
    NSArray *teachers;
}

@property (weak, nonatomic) IBOutlet UITextField *tfSecret;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation DepartementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // test synchronization
//    [self.synchronizationService startSynchronization];
    
    counter = 0;
    self.activityIndicator.hidesWhenStopped = YES;
    self.activityIndicator.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)startAppBtn:(UIButton *)sender {

    
    NSString *message = nil;
    
    if ([self.tfSecret.text isEqualToString:@""]) {
        
        message = @"Gelieve een code in te geven.";
    } else {
        
        [self.appStart initializeApp:self.tfSecret.text];
    }
    
    if ([self.appStart hasBeenInitialized:self.tfSecret.text] && counter == 0) {
        
        [self.activityIndicator startAnimating];
        self.activityIndicator.hidden = NO;
        
        self.synchronizationService = self.appStart.synchronizationService;
        [self.synchronizationService addObserver:self];
        [self.synchronizationService initializePersistentStoreFromBackEnd];
    } else {
        message = @"Foute code. Probeer opnieuw.";
    }
    
    if (message) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Departementale Code"
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"Ok", nil];
        
        alert.tag = 300;
        
        [alert show];
    }
    
}

-(NSUInteger)count{
    
    return [self.synchronizationService.persistentStoreManager countForEntity:[Event entityName]];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 300) {
        self.tfSecret.text = @"";
        self.tfSecret.layer.borderColor =[[UIColor redColor]CGColor];
        self.tfSecret.layer.borderWidth = 1.0f;
    }    
}

-(void)update{
    
    [self performSegueWithIdentifier:@"modalSegueToLogin" sender:self];
}

-(void)updateEvents{
    
    events = [self.synchronizationService.persistentStoreManager fetchByPredicate:[NSPredicate predicateWithFormat:@"acadyear==%@", @"1415"] forEntity:[Event entityName] sort:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    
    counter +=1;
    
    if (counter == 2) {
        [self.activityIndicator stopAnimating];
        [self performSegueWithIdentifier:@"modalSegueToLogin" sender:self];
    }
}

-(void)updateTeachers{
    
    teachers = [self.synchronizationService.persistentStoreManager fetchByPredicate:[NSPredicate predicateWithFormat:@"acadyear==%@", @"1415"] forEntity:[Teacher entityName] sort:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    
    counter +=1;
    
    if (counter == 2) {
        [self.activityIndicator stopAnimating];
        [self performSegueWithIdentifier:@"modalSegueToLogin" sender:self];
    }
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if ([[segue identifier] isEqualToString:@"modalSegueToLogin"]) {
        
        LoginViewController *viewController = [segue destinationViewController];
        viewController.synchronizationService = self.synchronizationService;
        viewController.eventList = events;
        viewController.teacherList = teachers;
    }
}

@end
