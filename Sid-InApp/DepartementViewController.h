//
//  DepartementViewController.h
//  Sid-InApp
//
//  Created by  on 04/06/15.
//  Copyright (c) 2015 Ehb.be. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SynchronizationService.h"
#import "AppStart.h"
#import "SynchronizationObserver.h"

@interface DepartementViewController : UIViewController <UIAlertViewDelegate, SynchronizationObserver>

@property (nonatomic, strong) SynchronizationService *synchronizationService;

@property (nonatomic, strong) AppStart *appStart;

@end