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
    counter = 0;
    self.activityIndicator.hidesWhenStopped = YES;
    self.activityIndicator.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startAppBtn:(UIButton *)sender {
    
    [self.appStart initializeApp:self.tfSecret.text];
    self.synchronizationService = self.appStart.synchronizationService;
    [self.synchronizationService addObserver:self];
    
    if ([self.appStart hasBeenInitialized:self.tfSecret.text] && counter == 0) {
        [self.synchronizationService initializePersistentStoreFromBackEnd];
        self.activityIndicator.hidden = NO;
        [self.activityIndicator startAnimating];
//        counter += 1;
//        [self performSegueWithIdentifier:@"modalSegueToLogin" sender:sender];
        
//        [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(goTo:) userInfo:nil repeats:NO];
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
    
//    if ([self.synchronizationService.persistentStoreManager countForEntity:[Event entityName]] == 0) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"App Initializatie"
//                                                        message:@"Nog even geduld. Probeer opnieuw."
//                                                       delegate:self
//                                              cancelButtonTitle:nil
//                                              otherButtonTitles:@"Ok", nil];
//        
//        alert.tag = 100;
//        
//        [alert show];
//    } else {
//        [self performSegueWithIdentifier:@"modalSegueToLogin" sender:sender];
//    }
    
}

-(NSUInteger)count{
    
    return [self.synchronizationService.persistentStoreManager countForEntity:[Event entityName]];
}

-(void)goTo:(id)sender{
    [self performSegueWithIdentifier:@"modalSegueToLogin" sender:sender];

//    NSArray *subs = [self.synchronizationService.persistentStoreManager fetchAll:[Event entityName]];
//    
//        if(subs.count)
//        {
//            NSLog(@"subs are empty");
//        } else {
//           // [self performSegueWithIdentifier:@"modalSegueToLogin" sender:sender];
//            NSLog(@"EVENTS FUNCTION: %@", subs.count);
//        }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 100) {
        self.tfSecret.text = @"";
        self.tfSecret.layer.borderColor =[[UIColor redColor]CGColor];
        self.tfSecret.layer.borderWidth = 1.0f;
    }    
}

-(void)update{
    NSLog(@"GEUPDATE OBSERVER");
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

///*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
    
    if ([[segue identifier] isEqualToString:@"modalSegueToLogin"]) {
        
//        while ([self count] == 0) {
//            NSLog(@"Events empty");
//        }
        LoginViewController *viewController = [segue destinationViewController];
        viewController.synchronizationService = self.synchronizationService;
        
        viewController.eventList = events;
        viewController.teacherList = teachers;
        
        

    }
    
}
//*/

@end
