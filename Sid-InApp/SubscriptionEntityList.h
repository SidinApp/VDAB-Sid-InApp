//
//  SubscriptionEntityList.h
//  Sid-InApp
//
//  Created by  on 12/06/15.
//  Copyright (c) 2015 Ehb.be. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SubscriptionEntity;

@interface SubscriptionEntityList : NSManagedObject

@property (nonatomic, retain) NSSet *subscriptions;
@end

@interface SubscriptionEntityList (CoreDataGeneratedAccessors)

- (void)addSubscriptionsObject:(SubscriptionEntity *)value;
- (void)removeSubscriptionsObject:(SubscriptionEntity *)value;
- (void)addSubscriptions:(NSSet *)values;
- (void)removeSubscriptions:(NSSet *)values;

@end
