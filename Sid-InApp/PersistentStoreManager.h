//
//  PersistentStoreManager.h
//  Sid-In App Data Model
//
//  Created by Bert Remmerie on 09/06/15.
//  Copyright (c) 2015 EhB.be. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Dao.h"
#import "PersistentStack.h"

@interface PersistentStoreManager : NSObject <Dao>

@property (nonatomic, strong, readonly) PersistentStack *persistentStack;

-(id)initWithPersistentStack:(PersistentStack *)persistentStack;

@end
