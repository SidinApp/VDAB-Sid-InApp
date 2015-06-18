//
//  SubscriptionEntity.h
//  Sid-InApp
//
//  Created by  on 18/06/15.
//  Copyright (c) 2015 Ehb.be. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class EventEntity, InterestsEntity, SchoolEntity, TeacherEntity;

@interface SubscriptionEntity : NSManagedObject

@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSNumber * sNew;
@property (nonatomic, retain) NSString * street;
@property (nonatomic, retain) NSString * streetNumber;
@property (nonatomic, retain) NSNumber * timestamp;
@property (nonatomic, retain) NSString * zip;
@property (nonatomic, retain) EventEntity *event;
@property (nonatomic, retain) InterestsEntity *interests;
@property (nonatomic, retain) SchoolEntity *school;
@property (nonatomic, retain) TeacherEntity *teacher;

@end
