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

// BELANGRIJK: wanneer de pickers niet werden gebruikt: warning geven!!!!

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // inloggen backend
    
    // seed persistent store from back-end
    //    [self.synchronizationService initializePersistentStoreFromBackEnd];
    
//    while ([self.teachers count] == 0 || [self.events count] == 0) {
        [self fetchTeachersFromContext];
        [self fetchEventsFromContext];
//    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)amLogout:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    [appDelegate deleteAndRecreateStore];
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
    int count = 0;
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
    
    if (![teacher isEqual:nil]) {
        teacherText = teacher.name;
    }
    if (![event isEqual:nil]) {
        eventText = event.name;
    }
    self.loginLabel.text = [NSString stringWithFormat:@"%@ @ %@", teacherText, eventText];
}

#pragma mark - CoreData
-(void)fetchTeachersFromContext{
    
//    NSManagedObjectContext *context = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
//    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Teacher"];
//    
//    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
//    fetchRequest.sortDescriptors = @[sortDescriptor];
//    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"acadyear==%@", @"1415"];
//    [fetchRequest setPredicate:predicate];
//    
//    NSError *error;
//    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
//    
//    _teachers = fetchedObjects;
//    
//    _teachers = [self.synchronizationService.persistentStoreManager fetchByPredicate:[NSPredicate predicateWithFormat:@"acadyear==%@", @"1415"] forEntity:[Teacher entityName] sort:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    
    if (self.teacherList == nil) {
        self.teacherList = [self.synchronizationService.persistentStoreManager fetchByPredicate:[NSPredicate predicateWithFormat:@"acadyear==%@", @"1415"] forEntity:[Teacher entityName] sort:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    }
    
    _teachers = self.teacherList;
}

-(void)fetchEventsFromContext{
    
//    NSManagedObjectContext *context = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
//    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Event"];
//    
//    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
//    fetchRequest.sortDescriptors = @[sortDescriptor];
//    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"acadyear==%@", @"1415"];
//    [fetchRequest setPredicate:predicate];
//    
//    NSError *error;
//    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
//    
//    _events = fetchedObjects;
    
//    _events = [self.synchronizationService.persistentStoreManager fetchByPredicate:[NSPredicate predicateWithFormat:@"acadyear==%@", @"1415"] forEntity:[Event entityName] sort:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    
    if (self.eventList == nil) {
        self.eventList = [self.synchronizationService.persistentStoreManager fetchByPredicate:[NSPredicate predicateWithFormat:@"acadyear==%@", @"1415"] forEntity:[Event entityName] sort:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    }
    
    _events = self.eventList;
}

//*
#pragma mark - Navigation
//- (IBAction)login:(id)sender {
//    [self performSegueWithIdentifier:@"modalSegueToCheckIn" sender:teacher];
//}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"modalSegueToCheckIn"]) {
        StudentCheckInViewController *viewController = [segue destinationViewController];
//        [viewController setTeacher:teacher];
//        [viewController setEvent:event];
        viewController.teacher = teacher;
        viewController.event = event;
//        viewController.teacher = sender;
        viewController.synchronizationService = self.synchronizationService;
    }
}
//*/

@end
