//
//  SubscriptionEntity.h
//  Sid-In App Data Model
//
//  Created by Bert Remmerie on 11/06/15.
//  Copyright (c) 2015 EhB.be. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class EventEntity, InterestsEntity, SchoolEntity, TeacherEntity;

@interface SubscriptionEntity : NSManagedObject

@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * isNew;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * street;
@property (nonatomic, retain) NSString * streetNumber;
@property (nonatomic, retain) NSNumber * timeStamp;
@property (nonatomic, retain) NSString * zip;
@property (nonatomic, retain) EventEntity *event;
@property (nonatomic, retain) InterestsEntity *interests;
@property (nonatomic, retain) SchoolEntity *school;
@property (nonatomic, retain) TeacherEntity *teacher;

@end
