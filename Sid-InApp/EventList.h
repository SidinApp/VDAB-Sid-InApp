//
//  EventList.h
//  Sid-In App Data Model
//
//  Created by Bert Remmerie on 07/06/15.
//  Copyright (c) 2015 EhB.be. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ModelMapping.h"

#import "EventEntityList.h"
#import "Event.h"

@interface EventList : NSObject <ModelMapping>

@property (nonatomic, copy) NSSet *events;

@end
