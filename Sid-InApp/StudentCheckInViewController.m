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

//@property (nonatomic, strong) Teacher *teacher;
//@property (nonatomic, strong) Event *event;

@property (weak, nonatomic) IBOutlet UILabel *loginLabel;
@property (weak, nonatomic) IBOutlet UIButton *btnLogout;

@property NSArray *images;

@end

@implementation StudentCheckInViewController

@synthesize lblSuccess;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.loginLabel.text = [NSString stringWithFormat:@"%@ @ %@", self.teacher.name, self.event.name];
    
}

- (void) viewWillAppear:(BOOL)animated{
    NSLog(@"viewWillAppear triggered");
     [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(hideLabel) userInfo:nil repeats:NO];
}

- (void) hideLabel {
    lblSuccess.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)setTeacher:(Teacher *)teacher{
//    self.teacher = teacher;
//}
//
//-(void)setEvent:(Event *)event{
//    self.event = event;
//}

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

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([[segue identifier] isEqualToString:@"modalSegueToStudentForm"]) {
         StudentFormViewController *viewController = [segue destinationViewController];
         //        [viewController setTeacher:teacher];
            //        [viewController setEvent:event];
         viewController.teacher = self.teacher;
         viewController.event = self.event;
         //        viewController.teacher = sender;
 
     }
     
     if([[segue identifier] isEqual:@"modalSegueToCarousel"]) {
         CarouselViewController *viewController = [segue destinationViewController];
     }
 
 }

@end
