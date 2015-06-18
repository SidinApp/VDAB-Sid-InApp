//
//  SynchronizationObserver.h
//  Sid-InApp
//
//  Created by  on 17/06/15.
//  Copyright (c) 2015 Ehb.be. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

#import "SidInUtils.h"

@protocol SynchronizationObserver <NSObject>

@required

-(void)update;

-(void)updateEvents;

-(void)updateTeachers;

-(void)updateSchools;

-(void)updateSubscriptions;

-(void)updateImages;

@end