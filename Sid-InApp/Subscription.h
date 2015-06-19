//
//  Subscription.h
//  Sid-In App Data Model
//
//  Created by Bert Remmerie on 07/06/15.
//  Copyright (c) 2015 EhB.be. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ModelMapping.h"

#import "SubscriptionEntity.h"

#import "Event.h"
#import "Teacher.h"
#import "School.h"
#import "Interests.h"

@class Event, School, Teacher, Interests;

@interface Subscription : NSObject <ModelMapping>

@property (nonatomic, copy) NSString * city;
@property (nonatomic, copy) NSString * email;
@property (nonatomic, copy) NSString * firstName;
@property (nonatomic, copy) NSNumber * id;
@property (nonatomic, copy) NSNumber * sNew;
@property (nonatomic, copy) NSString * lastName;
@property (nonatomic, copy) NSString * street;
@property (nonatomic, copy) NSString * streetNumber;
@property (nonatomic, copy) NSNumber * timeStamp;
@property (nonatomic, copy) NSString * zip;
@property (nonatomic, strong) Event  *event;
@property (nonatomic, strong) Interests *interests;
@property (nonatomic, strong) School *school;
@property (nonatomic, strong) Teacher *teacher;

@end