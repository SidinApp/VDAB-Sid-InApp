//
//  SchoolTableViewController.h
//  Sid-InApp
//
//  Created by  on 10/06/15.
//  Copyright (c) 2015 Ehb.be. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SynchronizationService.h"

@interface SchoolTableViewController : UITableViewController <UIPopoverControllerDelegate>

@property (nonatomic, strong) SynchronizationService *synchronizationService;

@end
