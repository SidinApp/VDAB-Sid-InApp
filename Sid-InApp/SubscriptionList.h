//
//  SubscriptionList.h
//  Sid-In App Data Model
//
//  Created by Bert Remmerie on 07/06/15.
//  Copyright (c) 2015 EhB.be. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ModelMapping.h"

#import "SubscriptionEntityList.h"
#import "Subscription.h"


@interface SubscriptionList : NSObject <ModelMapping>

@property (nonatomic, copy) NSSet *subscriptions;

@end
