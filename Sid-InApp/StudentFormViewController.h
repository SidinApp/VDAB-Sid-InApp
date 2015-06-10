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

@interface StudentFormViewController : UIViewController

@property (nonatomic, strong) Teacher *teacher;
@property (nonatomic, strong) Event *event;
@property (weak, nonatomic) IBOutlet UITextField *tfSchool;
@property (nonatomic, strong) School *school;

@end
