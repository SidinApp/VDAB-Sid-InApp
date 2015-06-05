//
//  StudentCheckInViewController.m
//  Sid-InApp
//
//  Created by  on 04/06/15.
//  Copyright (c) 2015 Ehb.be. All rights reserved.
//

#import "StudentCheckInViewController.h"
#import "StudentFormViewController.h"

@interface StudentCheckInViewController ()

//@property (nonatomic, strong) Teacher *teacher;
//@property (nonatomic, strong) Event *event;

@property (weak, nonatomic) IBOutlet UILabel *loginLabel;

@end

@implementation StudentCheckInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.loginLabel.text = [NSString stringWithFormat:@"%@ @ %@", self.teacher.name, self.event.name];
    
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
 
 }

@end
