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
@property (nonatomic, copy) NSNumber * isNew;
@property (nonatomic, copy) NSString * lastName;
@property (nonatomic, copy) NSString * street;
@property (nonatomic, copy) NSString * streetNumber;
@property (nonatomic, copy) NSNumber * timeStamp;
@property (nonatomic, copy) NSString * zip;
@property (nonatomic, copy) NSString * acadyear;
@property (nonatomic, strong) Event  *event;
@property (nonatomic, strong) Interests *interests;
@property (nonatomic, strong) School *school;
@property (nonatomic, strong) Teacher *teacher;

@end


//-(id)toManagedEntity:(RKManagedObjectStore *)managedObjectStore{
//
//    SubscriptionEntity *result = [Subscription managedEntity:managedObjectStore];
//
//    result.id = self.id;
//    result.firstName = self.firstName;
//    result.lastName = self.lastName;
//    result.email = self.email;
//    result.street = self.street;
//    result.streetNumber = self.streetNumber;
//    result.zip = self.zip;
//    result.city = self.city;
//    result.timeStamp = self.timeStamp;
//
//    result.interests = [self.interests toManagedEntity:managedObjectStore];
//    result.teacher = [self.teacher toManagedEntity:managedObjectStore];
//    result.event = [self.event toManagedEntity:managedObjectStore];
//    result.school = [self.school toManagedEntity:managedObjectStore];
//
//    return result;
//}

//+(NSEntityDescription *)entityDescription:(RKManagedObjectStore *)managedObjectStore{
//
//    NSEntityDescription *result = [NSEntityDescription entityForName:[Subscription entityDescriptionName]
//                                              inManagedObjectContext:managedObjectStore.mainQueueManagedObjectContext];
//    return result;
//}
