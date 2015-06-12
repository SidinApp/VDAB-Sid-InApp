//
//  ModelMapping.h
//  Sid-In App Data Model
//
//  Created by Bert Remmerie on 07/06/15.
//  Copyright (c) 2015 EhB.be. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

#import "SidInUtils.h"

@protocol ModelMapping <NSObject>

@required

+(NSString *)entityName;

+(RKEntityMapping *)createEntityMapping:(RKManagedObjectStore *)managedObjectStore;

+(RKObjectMapping *)createObjectMapping;

@end

//+(NSManagedObject *)createEntity:(NSManagedObjectContext *)managedObjectContext;
//