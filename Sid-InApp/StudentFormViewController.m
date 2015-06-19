//
//  StudentFormViewController.m
//  Sid-InApp
//
//  Created by  on 04/06/15.
//  Copyright (c) 2015 Ehb.be. All rights reserved.
//

#import "StudentFormViewController.h"
#import "StudentCheckInViewController.h"
#import "Subscription.h"
#import "SubscriptionEntity.h"
#import "Interests.h"
#import "School.h"
#import <RestKit/CoreData.h>
#import "SynchronizationService.h"
#import <QuartzCore/QuartzCore.h>

@interface StudentFormViewController ()
{
    SubscriptionEntity *sub;
    InterestsEntity *interests;
    NSArray *subscriptions;
    
}

@property(nonatomic, strong) SchoolTableViewController  * schoolTableViewController;

@property (weak, nonatomic) IBOutlet UILabel            * lblTeacher;
@property (weak, nonatomic) IBOutlet UIButton           * btnSave;
@property (weak, nonatomic) IBOutlet UIButton           * btnCancel;
@property (weak, nonatomic) IBOutlet UIView             * viewOptional;
@property (weak, nonatomic) IBOutlet UIView             * viewRequired;
@property (weak, nonatomic) IBOutlet UITextField        * tfFirstName;
@property (weak, nonatomic) IBOutlet UITextField        * tfLastName;
@property (weak, nonatomic) IBOutlet UITextField        * tfEmail;
@property (weak, nonatomic) IBOutlet UITextField        * tfZip;
@property (weak, nonatomic) IBOutlet UILabel            * lblInterests;
@property (weak, nonatomic) IBOutlet UILabel            * lblZip;
@property (weak, nonatomic) IBOutlet UISwitch           * swDig;
@property (weak, nonatomic) IBOutlet UISwitch           * swMultec;
@property (weak, nonatomic) IBOutlet UIImageView        * imgDigx;
@property (weak, nonatomic) IBOutlet UIImageView        * imgMultec;
@property (weak, nonatomic) IBOutlet UITextField        * tfStreet;
@property (weak, nonatomic) IBOutlet UITextField        * tfCity;
@property (weak, nonatomic) IBOutlet UITextField        * tfStreetNumber;
@property (weak, nonatomic) IBOutlet UISwitch           * swWorkStudent;

@end

@implementation StudentFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self fetchSubscriptionFromContext]; //
    self.lblTeacher.text = [NSString stringWithFormat:@"%@ @ %@", self.teacher.name, self.event.name];
    
    UISwipeGestureRecognizer *recognizerRight;
    recognizerRight.delegate=self;
    
    recognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
    [recognizerRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [_viewOptional addGestureRecognizer:recognizerRight];
    
    
    UISwipeGestureRecognizer *recognizerLeft;
    recognizerLeft.delegate=self;
    recognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeleft:)];
    [recognizerLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [_viewRequired addGestureRecognizer:recognizerLeft];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)swipeleft:(UISwipeGestureRecognizer *)swipeGesture{
    
    CATransition *animation = [CATransition animation];
    [animation setDelegate:self];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromRight];
    [animation setDuration:0.50];
    [animation setTimingFunction:
     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    _viewOptional.hidden=NO;
    _viewRequired.hidden=YES;
    
    [_viewOptional.layer addAnimation:animation forKey:kCATransition];
}

-(void)swipeRight:(UISwipeGestureRecognizer *)swipeGesture{
    
    CATransition *animation = [CATransition animation];
    [animation setDelegate:self];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromLeft];
    [animation setDuration:0.40];
    [animation setTimingFunction:
     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    _viewRequired.hidden=NO;
    _viewOptional.hidden=YES;
    
    
    [_viewOptional.layer addAnimation:animation forKey:kCATransition];
}


- (IBAction)tfEmailChanged:(id)sender {
   
    NSArray *result = nil;
    
    result = [self.synchronizationService.persistentStoreManager fetchByPredicate:[NSPredicate predicateWithFormat:@"email == %@", _tfEmail.text] forEntity:[Subscription entityName] sort:[NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES]];
    
    if (result) {
        
        SubscriptionEntity *tempSub = [result firstObject];
        NSString *tempMail = tempSub.email;

        if ([_tfEmail.text isEqualToString: tempMail]) {

            _tfFirstName.text = tempSub.firstName;
            _tfLastName.text = tempSub.lastName;

            if([tempSub.interests.digx isEqual:[NSNumber numberWithInt:1]]){
                _swDig.on = YES;
            }
            if([tempSub.interests.multec isEqual: [NSNumber numberWithInt:1]]){
                _swMultec.on = YES;
            }

            _tfStreet.text = tempSub.street;
            _tfStreetNumber.text = tempSub.streetNumber;
            _tfCity.text = tempSub.city;
            _tfZip.text = tempSub.zip;
            _tfSchool.text = tempSub.school.name;
            if([tempSub.interests.werkstudent isEqual:[NSNumber numberWithInt:1]]){
                _swWorkStudent.on = YES;
            }
            self.school = tempSub.school;
            _tfSchool.text = tempSub.school.name;
            
        }
    }  
}

- (IBAction)tfSchoolTapped:(id)sender {
    
    [self performSegueWithIdentifier:@"popoverSchools" sender:sender];
}

- (IBAction)Opslaan:(id)sender {
    
    sub = (SubscriptionEntity *)[self.synchronizationService.persistentStoreManager insert:[Subscription entityName]];
    
    interests = (InterestsEntity *)[self.synchronizationService.persistentStoreManager insert:[Interests entityName]];
    
    //-------------------Voornaam-------------------------------------------------
    
    
    if ([self validFirstName]) {
        sub.firstName = _tfFirstName.text;
    }
    
    //--------------------Achternaam-----------------------------------------------
    
    if ([self validLastName]) {
        sub.lastName = _tfLastName.text;
    }
    
    //-------------------Mail-----------------------------------------------------
    
    if ([self validEmail]) {
        sub.email = _tfEmail.text;
    }
    
    //-----------------Interesses--------------------------------------------------
    
    if ([self validInterests]) {
        sub.interests = interests;
    }
    
    //------------------Straat-----------------------------------------------------
    
    if ([self validStreet]) {
        sub.street = _tfStreet.text;
    }
    
    //------------------Nummer-----------------------------------------------------
    
    if ([self validStreetNumber]) {
        sub.streetNumber = _tfStreetNumber.text;
    }
    
    //------------------Gemeente-----------------------------------------------------
    
    if ([self validCity]) {
        sub.city = _tfCity.text;
    }
    
    //------------------Postcode-----------------------------------------------------
    
    if ([self validZip]) {
        sub.zip = _tfZip.text;
    }
    
    //----------------School---------------------------------------------------------
    
    sub.school = [self getSchool];
    
    //----------------Teacher & event------------------------------------------------
    
    sub.teacher = self.teacher;
    sub.event = self.event;
    
    //---------------Timestamp-------------------------------------------------------
   
    sub.timestamp = [NSNumber numberWithLongLong:[self getTimeStamp]];
    
    //---------------Controle vereiste velden ingevuld-------------------------------
    
    if ([self validSubscription:sub]) {
        
        sub.sNew = [NSNumber numberWithBool:NO];
        
        [self.synchronizationService postSubscription:sub];
        
        StudentCheckInViewController *cvc = (StudentCheckInViewController *)self.presentingViewController;
        cvc.lblSuccess.text = @"Successfully saved!";
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(long)getTimeStamp{
    
    NSDate *dateNow = [NSDate date];
    long timeStamp = (long)([dateNow timeIntervalSince1970]*1000.0);
    
//    NSDate *longToDate = [SynchronizationService convertLongToDate:timeStamp];
//    NSDate *dateWithoutTime = [SynchronizationService convertToDateWithoutTime:longToDate];

    NSDate *longToDate = [PersistentStoreManager convertLongToDate:timeStamp];
    NSDate *dateWithoutTime = [PersistentStoreManager convertToDateWithoutTime:longToDate];
    
    
    return (long) ([dateWithoutTime timeIntervalSince1970]*1000.0);
}

-(BOOL)validFirstName{
    
    if ([_tfFirstName.text isEqualToString:@""]) {
        _tfFirstName.layer.borderColor =[[UIColor redColor]CGColor];
        _tfFirstName.layer.borderWidth = 1.0f;
        _tfFirstName.placeholder = @"Veld is verplicht!";
        return NO;
    } else {
       _tfFirstName.layer.borderColor=[[UIColor clearColor]CGColor];
        return YES;
    }
}

-(BOOL)validLastName{
    
    if ([_tfLastName.text isEqualToString:@""]) {
        _tfLastName.layer.borderColor =[[UIColor redColor]CGColor];
        _tfLastName.layer.borderWidth = 1.0f;
        _tfLastName.placeholder = @"Veld is verplicht!";
        return NO;
    } else {
        _tfLastName.layer.borderColor=[[UIColor clearColor]CGColor];
        return YES;
    }
}

//http://stackoverflow.com/questions/800123/what-are-best-practices-for-validating-email-addresses-in-objective-c-for-ios-2
- (BOOL)validEmail{
    
    BOOL result = NO;
    
    NSString *mail = _tfEmail.text;
    
    if ([mail isEqualToString:@""]) {
        result = NO;
    }
    
    NSString *emailRegex =
    
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", emailRegex];
    
    if (![emailTest evaluateWithObject:mail]) {
        
        result = NO;
    } else {
        
        result = YES;
    }
    
    if (result) {
        _tfEmail.layer.borderColor=[[UIColor clearColor]CGColor];
    } else {
        _tfEmail.layer.borderColor =[[UIColor redColor]CGColor];
        _tfEmail.layer.borderWidth = 1.0f;
        _tfEmail.placeholder = @"Veld is verplicht!";
    }
    
    return result;
}

-(BOOL)validInterests{
    
    if([self countSwitches] == 0){
        
        _imgMultec.layer.borderColor =[[UIColor redColor]CGColor];
        _imgDigx.layer.borderColor =[[UIColor redColor]CGColor];
        
        _swDig.layer.borderColor  =[[UIColor redColor]CGColor];
        _swMultec.layer.borderColor =[[UIColor redColor]CGColor];
        
        _lblInterests.textColor = [UIColor redColor];
        return NO;
    } else {
        
        _imgMultec.layer.borderColor=[[UIColor clearColor]CGColor];
        _imgMultec.layer.borderColor=[[UIColor clearColor]CGColor];
        _lblInterests.textColor = [UIColor blackColor];
        
        if (_swDig.on) {
            
            interests.digx = [NSNumber numberWithInt:1];
        } else {
            
            interests.digx = [NSNumber numberWithInt:0];
        }
        
        if (_swMultec.on){
            
            interests.multec = [NSNumber numberWithInt:1];
        } else {
            
            interests.multec = [NSNumber numberWithInt:0];
        }
        
        if (_swWorkStudent.on) {
            
            interests.werkstudent = [NSNumber numberWithInt:1];
        } else {
            
            interests.werkstudent = [NSNumber numberWithInt:0];
        }
        
        return YES;
    }
}

-(BOOL)validStreet{
    
    if(![_tfStreet.text isEqualToString:@""] && _tfStreet.text.length < 3){
        
        _tfStreet.text = @"";
        _tfStreet.placeholder = @"Straatnaam moet minstens 3 tekens lang zijn.";
        _tfStreet.layer.borderColor =[[UIColor redColor]CGColor];
        _tfStreet.layer.borderWidth = 1.0f;
        return NO;
    } else {
        
        _tfStreet.layer.borderColor=[[UIColor clearColor]CGColor];
        return YES;
    }
}

-(BOOL)validStreetNumber{
    
    if(![_tfStreetNumber.text isEqualToString:@""] && (_tfStreetNumber.text.length < 1 || _tfStreetNumber.text.length > 4)) {
        
        _tfStreetNumber.text = @"";
        _tfStreetNumber.placeholder = @"Huisnummer moet tussen 1 en 4 tekens lang zijn.";
        _tfStreetNumber.layer.borderColor =[[UIColor redColor]CGColor];
        _tfStreetNumber.layer.borderWidth = 1.0f;
        return NO;
    } else {
        
        _tfStreetNumber.layer.borderColor=[[UIColor clearColor]CGColor];
        return YES;
    }
}

-(BOOL)validCity{
    if(![_tfCity.text isEqualToString:@""] && _tfCity.text.length < 3) {
        
        _tfCity.text = @"";
        _tfCity.placeholder = @"Gemeente moet minstens 3 tekens lang zijn.";
        _tfCity.layer.borderColor =[[UIColor redColor]CGColor];
        _tfCity.layer.borderWidth = 1.0f;
        return NO;
    } else {
        
        _tfCity.layer.borderColor=[[UIColor clearColor]CGColor];
        return YES;
    }
}

-(BOOL)validZip{
    
    if(_tfZip.text.length ==0){
        
        _tfZip.placeholder = @"Veld is verplicht";
        _tfZip.layer.borderColor =[[UIColor redColor]CGColor];
        _tfZip.layer.borderWidth = 1.0f;
        return NO;
    } else if(!(_tfZip.text.length == 4)) {
        
        _tfZip.text = @"";
        _tfZip.placeholder = @"Postcode is 4 tekens";
        _tfZip.layer.borderColor =[[UIColor redColor]CGColor];
        _tfZip.layer.borderWidth = 1.0f;
        return NO;
    } else {
        
        _tfZip.layer.borderColor=[[UIColor clearColor]CGColor];
        return YES;
    }
}

-(BOOL)validSubscription:(SubscriptionEntity *)subscription{
    
    return !(subscription.firstName.length == 0) && !(subscription.lastName.length == 0) && !(subscription.zip.length ==0) && !(subscription.email.length == 0) && !(subscription.interests.digx == 0 && subscription.interests.multec == 0);
}

-(SchoolEntity *)getSchool{
    
    if(_tfSchool.text.length == 0){
        
        return [self.synchronizationService.persistentStoreManager fetchByPredicate:[NSPredicate predicateWithFormat:@"name == %@", @"Geen school"] forEntity:[School entityName]].firstObject;
    } else {
        return self.school;
    }
}


- (int) countSwitches {
    int teller = 0;
    
    if(_swDig.isOn){
        teller += 1;
    }
    
    if (_swMultec.isOn) {
        teller +=1;
    }
    
    return teller;
}


//-(void)fetchSubscriptionFromContext{
//    
//    subscriptions = [self.synchronizationService.persistentStoreManager fetchAll:[Subscription entityName]];
//}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"popoverSchools"]) {
        SchoolTableViewController *tableViewController = [segue destinationViewController];
        tableViewController.synchronizationService = self.synchronizationService;
    }
}

- (IBAction)formCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
