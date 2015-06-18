//
//  LoginViewController.h
//  Sid-InApp
//
//  Created by  on 04/06/15.
//  Copyright (c) 2015 Ehb.be. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SynchronizationService.h"

@interface LoginViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) SynchronizationService *synchronizationService;

@property (nonatomic, strong) NSArray *teacherList;
@property (nonatomic, strong) NSArray *eventList;


@end
