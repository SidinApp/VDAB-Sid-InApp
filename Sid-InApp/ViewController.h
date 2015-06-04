//
//  ViewController.h
//  Sidin App
//
//  Created by  on 01/06/15.
//  Copyright (c) 2015 ehb.be. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ViewController : UIViewController

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




@end

