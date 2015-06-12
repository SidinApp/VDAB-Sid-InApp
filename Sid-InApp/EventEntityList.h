//
//  EventEntityList.h
//  Sid-In App Data Model
//
//  Created by Bert Remmerie on 07/06/15.
//  Copyright (c) 2015 EhB.be. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class EventEntity;

@interface EventEntityList : NSManagedObject

@property (nonatomic, retain) NSSet *events;
@end

@interface EventEntityList (CoreDataGeneratedAccessors)

- (void)addEventsObject:(EventEntity *)value;
- (void)removeEventsObject:(EventEntity *)value;
- (void)addEvents:(NSSet *)values;
- (void)removeEvents:(NSSet *)values;

@end
