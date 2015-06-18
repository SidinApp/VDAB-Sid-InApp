//
//  StudentCheckInViewController.h
//  Sid-InApp
//
//  Created by mobapp on 04/06/15.
//  Copyright (c) 2015 Ehb.be. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Teacher.h"
#import "Event.h"

#import "SynchronizationService.h"

@interface StudentCheckInViewController : UIViewController

@property (nonatomic, strong) TeacherEntity *teacher;
@property (nonatomic, strong) EventEntity *event;
@property (weak, nonatomic) IBOutlet UILabel *lblSuccess;

@property (nonatomic, strong) SynchronizationService *synchronizationService;

@property (weak, nonatomic) IBOutlet UILabel *lblLogin;
@property (weak, nonatomic) IBOutlet UIButton *btnLogout;

//-(void)setTeacher:(Teacher *)teacher;
//-(void)setEvent:(Event *)event;

@end