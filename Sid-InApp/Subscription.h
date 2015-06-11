//
//  Subscription.h
//  Sid-InApp
//
//  Created by  on 11/06/15.
//  Copyright (c) 2015 Ehb.be. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Event, Interests, School, Teacher;

@interface Subscription : NSManagedObject

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
@property (nonatomic, retain) Event *event;
@property (nonatomic, retain) Interests *interests;
@property (nonatomic, retain) School *school;
@property (nonatomic, retain) Teacher *teacher;

@end
