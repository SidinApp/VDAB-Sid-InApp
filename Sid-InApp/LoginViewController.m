//
//  LoginViewController.m
//  Sid-InApp
//
//  Created by  on 04/06/15.
//  Copyright (c) 2015 Ehb.be. All rights reserved.
//

#import "LoginViewController.h"
#import "StudentCheckInViewController.h"

#import <RestKit/CoreData.h>
#import <RestKit/RestKit.h>

#import "Teacher.h"
#import "Event.h"

#import "AppDelegate.h"
@interface LoginViewController ()
{
    TeacherEntity *teacher;
    EventEntity *event;
}

@property (weak, nonatomic) IBOutlet UIPickerView *teacherPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *eventPicker;

@property (weak, nonatomic) IBOutlet UILabel *loginLabel;

@property NSArray *teachers;
@property NSArray *events;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self fetchTeachersFromContext];
    [self fetchEventsFromContext];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UIPickerView
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    Teacher *teacherResult;
    Event *eventResult;
    switch (pickerView.tag) {
        case 0:
            teacherResult = _teachers[row];
            return teacherResult.name;
            break;
        case 1:
            eventResult = _events[row];
            return eventResult.name;
            break;
    }
    return nil;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSUInteger count = 0;
    switch (pickerView.tag) {
        case 0:
            count = [_teachers count];
            break;
        case 1:
            count = [_events count];
            break;
    }
    return count;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (pickerView.tag) {
        case 0:
            teacher = _teachers[row];
            break;
        case 1:
            event = _events[row];
            break;
    }
    
    NSString *teacherText = @"-";;
    NSString *eventText = @"-";
    
    if (teacher != nil) {
        teacherText = teacher.name;
    }
    if (event != nil) {
        eventText = event.name;
    }
    self.loginLabel.text = [NSString stringWithFormat:@"%@ @ %@", teacherText, eventText];
}

#pragma mark - CoreData
-(void)fetchTeachersFromContext{
    
    if (self.teacherList == nil) {
        self.teacherList = [self.synchronizationService.persistentStoreManager fetchByPredicate:[NSPredicate predicateWithFormat:@"acadyear==%@", @"1415"] forEntity:[Teacher entityName] sort:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    }
    
    _teachers = self.teacherList;
}

-(void)fetchEventsFromContext{
    
    if (self.eventList == nil) {
        self.eventList = [self.synchronizationService.persistentStoreManager fetchByPredicate:[NSPredicate predicateWithFormat:@"acadyear==%@", @"1415"] forEntity:[Event entityName] sort:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    }
    
    _events = self.eventList;
}


#pragma mark - Navigation
- (IBAction)startBtn:(UIButton *)sender {
    
    if (!teacher || !event) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Login Docent"
                                                            message:@"Gelieve een Teacher en een Event te selecteren. Probeer opnieuw."
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"Ok", nil];
        alertView.tag = 200;
        
        [alertView show];
    } else {
        [self performSegueWithIdentifier:@"modalSegueToCheckIn" sender:sender];
    }
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"modalSegueToCheckIn"]) {
        StudentCheckInViewController *viewController = [segue destinationViewController];
        viewController.teacher = teacher;
        viewController.event = event;
        viewController.synchronizationService = self.synchronizationService;
    }
}


@end
