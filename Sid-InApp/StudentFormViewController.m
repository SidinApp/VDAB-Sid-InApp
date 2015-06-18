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
@end

@implementation StudentFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchSubscriptionFromContext];
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

-(void)swipeleft:(UISwipeGestureRecognizer *)swipeGesture
{
    
    
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
-(void)swipeRight:(UISwipeGestureRecognizer *)swipeGesture
{
    
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
    
    int counter = subscriptions.count;
    
    for(int i = 0; i < counter; i++){
        
        SubscriptionEntity *tempSub = subscriptions[i];
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
    
    if ([_tfFirstName.text isEqualToString:@""]) {
        _tfFirstName.layer.borderColor =[[UIColor redColor]CGColor];
        _tfFirstName.layer.borderWidth = 1.0f;
        _tfFirstName.placeholder = @"Veld is verplicht!";
    } else {
        _tfFirstName.layer.borderColor=[[UIColor clearColor]CGColor];
        sub.firstName = _tfFirstName.text;
    }
    
    //--------------------Achternaam-----------------------------------------------
    
    if ([_tfLastName.text isEqualToString:@""]) {
        _tfLastName.layer.borderColor =[[UIColor redColor]CGColor];
        _tfLastName.layer.borderWidth = 1.0f;
        _tfLastName.placeholder = @"Veld is verplicht!";
    } else {
        _tfLastName.layer.borderColor=[[UIColor clearColor]CGColor];
        sub.lastName = _tfLastName.text;
    }
    
    //-------------------Mail-----------------------------------------------------
    
    
    if ([_tfEmail.text isEqualToString:@""] || ![self validateEmail:_tfEmail.text]){
        _tfEmail.layer.borderColor =[[UIColor redColor]CGColor];
        _tfEmail.layer.borderWidth = 1.0f;
        _tfEmail.placeholder = @"Veld is verplicht!";
    } else {

        _tfEmail.layer.borderColor=[[UIColor clearColor]CGColor];
        sub.email = _tfEmail.text;
    }
    
    //-----------------Interesses--------------------------------------------------
    
    
    if([self countSwitches] == 0){
        _imgMultec.layer.borderColor =[[UIColor redColor]CGColor];
        _imgDigx.layer.borderColor =[[UIColor redColor]CGColor];
        
        _swDig.layer.borderColor  =[[UIColor redColor]CGColor];
        _swMultec.layer.borderColor =[[UIColor redColor]CGColor];
        
        _lblInterests.textColor = [UIColor redColor];
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
    }
    
    sub.interests = interests;
    
    
    //------------------Straat-----------------------------------------------------
    
    if(![_tfStreet.text isEqualToString:@""] && _tfStreet.text.length < 3){
        _tfStreet.text = @"";
        _tfStreet.placeholder = @"Straatnaam moet minstens 3 tekens lang zijn.";
        _tfStreet.layer.borderColor =[[UIColor redColor]CGColor];
        _tfStreet.layer.borderWidth = 1.0f;
    } else {
        _tfStreet.layer.borderColor=[[UIColor clearColor]CGColor];
        sub.street = _tfStreet.text;
    }
    
    //------------------Nummer-----------------------------------------------------
    
    if(![_tfStreetNumber.text isEqualToString:@""] && (_tfStreetNumber.text.length < 1 || _tfStreetNumber.text.length > 4)) {
        _tfStreetNumber.text = @"";
        _tfStreetNumber.placeholder = @"Huisnummer moet tussen 1 en 4 tekens lang zijn.";
        _tfStreetNumber.layer.borderColor =[[UIColor redColor]CGColor];
        _tfStreetNumber.layer.borderWidth = 1.0f;
    } else {
        _tfStreetNumber.layer.borderColor=[[UIColor clearColor]CGColor];
        sub.streetNumber = _tfStreetNumber.text;
    }
    
    
    //------------------Gemeente-----------------------------------------------------
    
    if(![_tfCity.text isEqualToString:@""] && _tfCity.text.length < 3) {
        _tfCity.text = @"";
        _tfCity.placeholder = @"Gemeente moet minstens 3 tekens lang zijn.";
        _tfCity.layer.borderColor =[[UIColor redColor]CGColor];
        _tfCity.layer.borderWidth = 1.0f;
    } else {
        _tfCity.layer.borderColor=[[UIColor clearColor]CGColor];
        sub.city = _tfCity.text;
    }
    
    //------------------Postcode-----------------------------------------------------
    if(_tfZip.text.length ==0){
        _tfZip.placeholder = @"Veld is verplicht";
        _tfZip.layer.borderColor =[[UIColor redColor]CGColor];
        _tfZip.layer.borderWidth = 1.0f;
    } else if(!(_tfZip.text.length == 4)) {
        _tfZip.text = @"";
        _tfZip.placeholder = @"Postcode is 4 tekens";
        _tfZip.layer.borderColor =[[UIColor redColor]CGColor];
        _tfZip.layer.borderWidth = 1.0f;
    } else {
        _tfZip.layer.borderColor=[[UIColor clearColor]CGColor];
        sub.zip = _tfZip.text;
    }
    
    //----------------School---------------------------------------------------------
    
    if(_tfSchool.text.length == 0){
        sub.school = [self.synchronizationService.persistentStoreManager fetchByPredicate:[NSPredicate predicateWithFormat:@"name == %@", @"Geen school"] forEntity:[School entityName]].firstObject;
    }
    
    if(!sub.school){
    sub.school = self.school;
    }
    
    //----------------Teacher & event------------------------------------------------
    sub.teacher = self.teacher;
    sub.event = self.event;
    
    //---------------Timestamp-------------------------------------------------------
    
    NSDate *dateNow = [NSDate date];
    long timeStamp = (long)([dateNow timeIntervalSince1970]*1000.0);
    //NSDate *fromLong = [NSDate dateWithTimeIntervalSince1970:timeStamp/1000];
    
    NSDate *longToDate = [SynchronizationService convertLongToDate:timeStamp];
    NSDate *dateWithoutTime = [SynchronizationService convertToDateWithoutTime:longToDate];
    
    timeStamp = (long) ([dateWithoutTime timeIntervalSince1970]*1000.0);

    sub.timestamp = [NSNumber numberWithLongLong:timeStamp];
    
    
    //---------------Controle vereiste velden ingevuld-------------------------------
    if(!(sub.firstName.length == 0) && !(sub.lastName.length == 0) && !(sub.zip.length ==0) && !(sub.email.length == 0) && !(sub.interests.digx == 0 && sub.interests.multec == 0)){
        
//        NSError *error;
//        [managedObjectContext saveToPersistentStore:&error];
        
//        [self.synchronizationService.persistentStoreManager save:sub];
//        sub.id = nil;
        sub.sNew = [NSNumber numberWithBool:NO];
        
        sub.sNew = [NSNumber numberWithBool:NO];
        
//        sub.isNew = @NO;
        
//        NSLog(@"SUB %@", sub.isNew);
//        sub.isNew = nil;
        [self.synchronizationService postSubscription:sub];
//        NSLog(@"SUB %@", sub.isNew);
        
        StudentCheckInViewController *cvc = (StudentCheckInViewController *)self.presentingViewController;
        cvc.lblSuccess.text = @"Successfully saved!";
        
        [self dismissViewControllerAnimated:YES completion:nil];
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

-(void)fetchSubscriptionFromContext{
    
    subscriptions = [self.synchronizationService.persistentStoreManager fetchAll:[Subscription entityName]];
}

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
