//
//  SubscriptionContainer.h
//  Sid-InApp
//
//  Created by  on 04/06/15.
//  Copyright (c) 2015 Ehb.be. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Subscription;

@interface SubscriptionContainer : NSManagedObject

@property (nonatomic, retain) NSSet *subscriptions;
@end

@interface SubscriptionContainer (CoreDataGeneratedAccessors)

- (void)addSubscriptionsObject:(Subscription *)value;
- (void)removeSubscriptionsObject:(Subscription *)value;
- (void)addSubscriptions:(NSSet *)values;
- (void)removeSubscriptions:(NSSet *)values;

@end
