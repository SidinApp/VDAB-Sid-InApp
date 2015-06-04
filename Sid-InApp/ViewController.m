//
//  ViewController.m
//  Sidin App
//
//  Created by  on 01/06/15.
//  Copyright (c) 2015 ehb.be. All rights reserved.
//

#import "ViewController.h"
#import "Subscription.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()


@end

@implementation ViewController

@synthesize tfEmail, tfCity, tfFirstName, tfLastName, tfSchool, tfStreet, tfStreetNumber, tfZip, swDig, swMultec, swWorkStudent, lblDigx, lblInterests, lblMultec;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Opslaan:(id)sender {
    
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
    }
    
    //-------------------Mail-----------------------------------------------------
    
    
    if ([tfEmail.text isEqualToString:@""] || ![self validateEmail:tfEmail.text]){
        tfEmail.layer.borderColor =[[UIColor redColor]CGColor];
        tfEmail.layer.borderWidth = 1.0f;
    } else {
        tfEmail.layer.borderColor=[[UIColor clearColor]CGColor];
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
    }
    
    //------------------Straat-----------------------------------------------------
    
    if(![tfStreet.text isEqualToString:@""] && tfStreet.text.length < 3){
        tfStreet.text = @"";
        tfStreet.placeholder = @"Straatnaam moet minstens 3 tekens lang zijn.";
        tfStreet.layer.borderColor =[[UIColor redColor]CGColor];
        tfStreet.layer.borderWidth = 1.0f;
    } else {
        tfStreet.layer.borderColor=[[UIColor clearColor]CGColor];
    }
    
    //------------------Nummer-----------------------------------------------------
    
    if(![tfStreetNumber.text isEqualToString:@""] && (tfStreetNumber.text.length < 1 || tfStreetNumber.text.length > 4)) {
        tfStreetNumber.text = @"";
        tfStreetNumber.placeholder = @"Huisnummer moet tussen 1 en 4 tekens lang zijn.";
        tfStreetNumber.layer.borderColor =[[UIColor redColor]CGColor];
        tfStreetNumber.layer.borderWidth = 1.0f;
    } else {
        tfStreetNumber.layer.borderColor=[[UIColor clearColor]CGColor];
    }
    
    
    //------------------Gemeente-----------------------------------------------------
    
    if(![tfCity.text isEqualToString:@""] && tfCity.text.length < 3) {
        tfCity.text = @"";
        tfCity.placeholder = @"Gemeente moet minstens 3 tekens lang zijn.";
        tfCity.layer.borderColor =[[UIColor redColor]CGColor];
        tfCity.layer.borderWidth = 1.0f;
    } else {
        tfCity.layer.borderColor=[[UIColor clearColor]CGColor];
    }
    
    //------------------Postcode-----------------------------------------------------
    
    if(![tfZip.text isEqualToString:@""] && !(tfZip.text.length == 4)) {
        tfZip.text = @"";
        tfZip.placeholder = @"Postcode is 4 tekens";
        tfZip.layer.borderColor =[[UIColor redColor]CGColor];
        tfZip.layer.borderWidth = 1.0f;
    } else {
        tfZip.layer.borderColor=[[UIColor clearColor]CGColor];
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
