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

@interface StudentFormViewController : UIViewController

@property (nonatomic, strong) TeacherEntity *teacher;
@property (nonatomic, strong) EventEntity *event;
@property (weak, nonatomic) IBOutlet UITextField *tfSchool;
@property (nonatomic, strong) SchoolEntity *school;
@property (weak, nonatomic) IBOutlet UILabel *lblTeacher;

@property (nonatomic, strong) SynchronizationService *synchronizationService;

@property(nonatomic, strong) SchoolTableViewController *schoolTableViewController;

@end
