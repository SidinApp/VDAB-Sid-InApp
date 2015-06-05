//
//  StudentFormViewController.m
//  Sid-InApp
//
//  Created by  on 04/06/15.
//  Copyright (c) 2015 Ehb.be. All rights reserved.
//

#import "StudentFormViewController.h"
#import "Subscription.h"
#import "Interests.h"
#import <RestKit/CoreData.h>

@interface StudentFormViewController ()
{
    Subscription *sub;
    Interests *interests;
    
}

//// verplicht
//@property (weak, nonatomic) IBOutlet UITextField *firstNameInput;
//@property (weak, nonatomic) IBOutlet UITextField *lastNameInput;
//@property (weak, nonatomic) IBOutlet UITextField *mailInput;
//
//@property (weak, nonatomic) IBOutlet UISwitch *digxInterestSwitch;
//@property (weak, nonatomic) IBOutlet UISwitch *multecInterestSwitch;
//
//// optioneel
//@property (weak, nonatomic) IBOutlet UISwitch *werkstudentInterestSwitch;
//
//@property (weak, nonatomic) IBOutlet UITextField *streetInput;
//@property (weak, nonatomic) IBOutlet UITextField *streetNumberInput;
//@property (weak, nonatomic) IBOutlet UITextField *cityInput;
//@property (weak, nonatomic) IBOutlet UITextField *zipInput;
//
//@property (weak, nonatomic) IBOutlet UITextField *schoolInput;

//textfields
@property (weak, nonatomic) IBOutlet UITextField *tfFirstName;
@property (weak, nonatomic) IBOutlet UITextField *tfLastName;
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfStreet;
@property (weak, nonatomic) IBOutlet UITextField *tfCity;
@property (weak, nonatomic) IBOutlet UITextField *tfStreetNumber;
@property (weak, nonatomic) IBOutlet UITextField *tfZip;
@property (weak, nonatomic) IBOutlet UITextField *tfSchool;

//switches
@property (weak, nonatomic) IBOutlet UISwitch *swDig;
@property (weak, nonatomic) IBOutlet UISwitch *swMultec;
@property (weak, nonatomic) IBOutlet UISwitch *swWorkStudent;

//buttons
@property (weak, nonatomic) IBOutlet UIButton *btnSave;

//labels
@property (weak, nonatomic) IBOutlet UILabel *lblInterests;
@property (weak, nonatomic) IBOutlet UILabel *lblDigx;
@property (weak, nonatomic) IBOutlet UILabel *lblMultec;

//variable


@end

@implementation StudentFormViewController


@synthesize tfEmail, tfCity, tfFirstName, tfLastName, tfSchool, tfStreet, tfStreetNumber, tfZip, swDig, swMultec, swWorkStudent, lblDigx, lblInterests, lblMultec;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Opslaan:(id)sender {
    
    NSManagedObjectContext *managedObjectContext = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
    NSManagedObjectContext *managedObjectContextInterests = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Subscription" inManagedObjectContext: managedObjectContext];
    
    sub = [[Subscription alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:managedObjectContext];
    
    entityDescription = [NSEntityDescription entityForName:@"Interests" inManagedObjectContext: managedObjectContextInterests];
    
    interests = [[Interests alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:managedObjectContextInterests];
    
    //-------------------Voornaam-------------------------------------------------
    
    if ([tfFirstName.text isEqualToString:@""]) {
        tfFirstName.layer.borderColor =[[UIColor redColor]CGColor];
        tfFirstName.layer.borderWidth = 1.0f;
    } else if(tfFirstName.text.length < 2) {
        tfFirstName.text = @"";
        tfFirstName.placeholder = @"Je naam moet minstens 2 tekens lang zijn.";
        tfFirstName.layer.borderColor =[[UIColor redColor]CGColor];
        tfFirstName.layer.borderWidth = 1.0f;
    } else {
        tfFirstName.layer.borderColor=[[UIColor clearColor]CGColor];
        sub.firstName = tfFirstName.text;
    }
    
    //--------------------Achternaam-----------------------------------------------
    
    if ([tfLastName.text isEqualToString:@""]) {
        tfLastName.layer.borderColor =[[UIColor redColor]CGColor];
        tfLastName.layer.borderWidth = 1.0f;
    } else if(tfLastName.text.length < 2){
        tfLastName.text = @"";
        tfLastName.placeholder = @"Je achternaam moet minstens 2 tekens lang zijn.";
        tfLastName.layer.borderColor =[[UIColor redColor]CGColor];
        tfLastName.layer.borderWidth = 1.0f;
    } else {
        tfLastName.layer.borderColor=[[UIColor clearColor]CGColor];
        sub.lastName = tfLastName.text;
    }
    
    //-------------------Mail-----------------------------------------------------
    
    
    if ([tfEmail.text isEqualToString:@""] || ![self validateEmail:tfEmail.text]){
        tfEmail.layer.borderColor =[[UIColor redColor]CGColor];
        tfEmail.layer.borderWidth = 1.0f;
    } else {
        tfEmail.layer.borderColor=[[UIColor clearColor]CGColor];
        sub.email = tfEmail.text;
    }
    
    //-----------------Interesses--------------------------------------------------
    
    
    if([self countSwitches] == 0){
        lblMultec.textColor = [UIColor redColor];
        lblDigx.textColor = [UIColor redColor];
        lblInterests.textColor = [UIColor redColor];
    } else {
        lblMultec.textColor = [UIColor blackColor];
        lblDigx.textColor = [UIColor blackColor];
        lblInterests.textColor = [UIColor blackColor];
        
        if (swDig.on) {
            interests.digx = [NSNumber numberWithInt:1];
        } else {
            interests.digx = [NSNumber numberWithInt:0];
        }
        
        if (swMultec.on){
            interests.multec = [NSNumber numberWithInt:1];
        } else {
            interests.multec = [NSNumber numberWithInt:0];
        }
    }
    
    sub.interests = interests;
    
    
    //------------------Straat-----------------------------------------------------
    
    if(![tfStreet.text isEqualToString:@""] && tfStreet.text.length < 3){
        tfStreet.text = @"";
        tfStreet.placeholder = @"Straatnaam moet minstens 3 tekens lang zijn.";
        tfStreet.layer.borderColor =[[UIColor redColor]CGColor];
        tfStreet.layer.borderWidth = 1.0f;
    } else {
        tfStreet.layer.borderColor=[[UIColor clearColor]CGColor];
        sub.street = tfStreet.text;
    }
    
    //------------------Nummer-----------------------------------------------------
    
    if(![tfStreetNumber.text isEqualToString:@""] && (tfStreetNumber.text.length < 1 || tfStreetNumber.text.length > 4)) {
        tfStreetNumber.text = @"";
        tfStreetNumber.placeholder = @"Huisnummer moet tussen 1 en 4 tekens lang zijn.";
        tfStreetNumber.layer.borderColor =[[UIColor redColor]CGColor];
        tfStreetNumber.layer.borderWidth = 1.0f;
    } else {
        tfStreetNumber.layer.borderColor=[[UIColor clearColor]CGColor];
        sub.streetNumber = tfStreetNumber.text;
    }
    
    
    //------------------Gemeente-----------------------------------------------------
    
    if(![tfCity.text isEqualToString:@""] && tfCity.text.length < 3) {
        tfCity.text = @"";
        tfCity.placeholder = @"Gemeente moet minstens 3 tekens lang zijn.";
        tfCity.layer.borderColor =[[UIColor redColor]CGColor];
        tfCity.layer.borderWidth = 1.0f;
    } else {
        tfCity.layer.borderColor=[[UIColor clearColor]CGColor];
        sub.city = tfCity.text;
    }
    
    //------------------Postcode-----------------------------------------------------
    
    if(![tfZip.text isEqualToString:@""] && !(tfZip.text.length == 4)) {
        tfZip.text = @"";
        tfZip.placeholder = @"Postcode is 4 tekens";
        tfZip.layer.borderColor =[[UIColor redColor]CGColor];
        tfZip.layer.borderWidth = 1.0f;
    } else {
        tfZip.layer.borderColor=[[UIColor clearColor]CGColor];
        sub.zip = tfZip.text;
    }
    
    
    //
    if(!([sub.firstName  isEqualToString:@""]) && !([sub.lastName  isEqualToString:@""]) && !([sub.email  isEqualToString:@""]) && !(sub.interests.digx == 0 && sub.interests.multec == 0)){
        
        NSError *error;
        [managedObjectContext saveToPersistentStore:&error];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
    
}

- (int) countSwitches {
    int teller = 0;
    
    if(swDig.isOn){
        teller += 1;
    }
    
    if (swMultec.isOn) {
        teller +=1;
    }
    
    return teller;
}



//http://stackoverflow.com/questions/800123/what-are-best-practices-for-validating-email-addresses-in-objective-c-for-ios-2

- (BOOL) validateEmail: (NSString *) mail {
    NSString *emailRegex =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", emailRegex];
    
    return [emailTest evaluateWithObject:mail];
}


@end
