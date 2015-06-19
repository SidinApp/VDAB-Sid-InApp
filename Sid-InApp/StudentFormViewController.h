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

@property (nonatomic, strong) TeacherEntity             * teacher;
@property (nonatomic, strong) EventEntity               * event;
@property (nonatomic, strong) SchoolEntity              * school;
//
@property (nonatomic, strong) SynchronizationService    * synchronizationService;

@property (weak, nonatomic) IBOutlet UITextField        * tfSchool;

@end
