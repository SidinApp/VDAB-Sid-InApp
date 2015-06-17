//
//  SynchronizationService.h
//  Sid-In App Data Model
//
//  Created by Bert Remmerie on 06/06/15.
//  Copyright (c) 2015 EhB.be. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RestfulStack.h"
#import "PersistentStoreManager.h"

#import "Subscription.h"
#import "SynchronizationObserver.h"

@interface SynchronizationService : NSObject // <RestDao>

@property (nonatomic, strong, readonly) RestfulStack *restfulStack;
@property (nonatomic, strong, readonly) PersistentStoreManager *persistentStoreManager;


//-(id)initWithRestfulStack:(RestfulStack *)restfulStack;
-(id)initWithRestfulStack:(RestfulStack *)restfulStack persistentStoreManager:(PersistentStoreManager *)persistentStoreManager;

-(void)initializePersistentStoreFromBackEnd;

-(void)pullEvents;
-(void)pullTeachers;
-(void)pullSchools;
-(void)pullImages;
-(void)pullSubscriptions;

-(void)postSubscription:(SubscriptionEntity *)subscription;
-(void)pushNewSubscriptions;

-(void)startSynchronization;
-(void)stopSynchronization;

-(NSArray *)subscriptionsByDate:(NSDate *)date;

-(NSDate *)convertLongToDate:(long)longDate;
-(NSDate *)convertToDateWithoutTime:(NSDate *)date;

-(void)addObserver:(id<SynchronizationObserver>)observer;

@end
