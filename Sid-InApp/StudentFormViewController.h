//
//  StudentFormViewController.h
//  Sid-InApp
//
//  Created by  on 04/06/15.
//  Copyright (c) 2015 Ehb.be. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Teacher.h"
#import "Event.h"
#import "School.h"

#import "SynchronizationService.h"
#import "SchoolTableViewController.h"


@interface StudentFormViewController : UIViewController <UIGestureRecognizerDelegate>

@property (nonatomic, strong) TeacherEntity *teacher;
@property (nonatomic, strong) EventEntity *event;

@property (nonatomic, strong) SchoolEntity *school;


@property (nonatomic, strong) SynchronizationService *synchronizationService;

@property(nonatomic, strong) SchoolTableViewController *schoolTableViewController;



//Root Elements-----------------------------------------------
@property (weak, nonatomic) IBOutlet UIView *containerRegistrationForm;
@property (weak, nonatomic) IBOutlet UILabel *lblTeacher;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;

@property (weak, nonatomic) IBOutlet UIView *viewOptional;
@property (weak, nonatomic) IBOutlet UIView *viewRequired;


//Required Fields---------------------------------------------
@property (weak, nonatomic) IBOutlet UITextField *tfFirstName;
@property (weak, nonatomic) IBOutlet UITextField *tfLastName;
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;

@property (weak, nonatomic) IBOutlet UILabel *lblInterests;
@property (weak, nonatomic) IBOutlet UILabel *lblDigx;
@property (weak, nonatomic) IBOutlet UILabel *lblMultec;

@property (weak, nonatomic) IBOutlet UISwitch *swDig;
@property (weak, nonatomic) IBOutlet UISwitch *swMultec;

//Optional Fields---------------------------------------------
@property (weak, nonatomic) IBOutlet UITextField *tfStreet;
@property (weak, nonatomic) IBOutlet UITextField *tfCity;
@property (weak, nonatomic) IBOutlet UITextField *tfStreetNumber;
@property (weak, nonatomic) IBOutlet UITextField *tfZip;

@property (weak, nonatomic) IBOutlet UITextField *tfSchool;
@property (weak, nonatomic) IBOutlet UISwitch *swWorkStudent;

@end
