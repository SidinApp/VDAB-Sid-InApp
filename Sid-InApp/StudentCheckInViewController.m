//
//  StudentCheckInViewController.m
//  Sid-InApp
//
//  Created by  on 04/06/15.
//  Copyright (c) 2015 Ehb.be. All rights reserved.
//

#import "StudentCheckInViewController.h"
#import "StudentFormViewController.h"
#import "CarouselViewController.h"
#import "Image.h"
#import <RestKit/CoreData.h>
#import <RestKit/RestKit.h>
#import "GTMBAse64.h"

@interface StudentCheckInViewController ()
{
    NSTimer *timer;
}

@property NSArray *images;

@end

@implementation StudentCheckInViewController

@synthesize lblSuccess;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(goToScreensaver) userInfo:nil repeats:NO];
    
    self.lblLogin.text = [NSString stringWithFormat:@"%@ @ %@", self.teacher.name, self.event.name];
    
}

-(void)goToScreensaver{
    // https://www.youtube.com/watch?v=ruRccI-AWRo
    
    [self performSegueWithIdentifier:@"modalSegueToCarousel" sender:self];
    
}

-(void)resetTimer{
    
    [timer invalidate];
    [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(goToScreensaver) userInfo:nil repeats:NO];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [timer invalidate];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self resetTimer];
}

- (void) viewWillAppear:(BOOL)animated{
     [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(hideLabel) userInfo:nil repeats:NO];
    
    [super viewWillAppear:animated];
    [self resetTimer];
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [timer invalidate];
}

- (void) hideLabel {
    lblSuccess.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (IBAction)dLogout:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)fetchImagesFromContext{
    
    NSManagedObjectContext *context = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Image"];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"image" ascending:YES];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    
    
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    _images = fetchedObjects;
}


 #pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([[segue identifier] isEqualToString:@"modalSegueToStudentForm"]) {
         StudentFormViewController *viewController = [segue destinationViewController];
         viewController.teacher = self.teacher;
         viewController.event = self.event;
         viewController.synchronizationService = self.synchronizationService;
 
     }
     
     if([[segue identifier] isEqual:@"modalSegueToCarousel"]) {
         CarouselViewController *viewController = [segue destinationViewController];
         viewController.synchronizationService = self.synchronizationService;
     }
 
 }

@end
