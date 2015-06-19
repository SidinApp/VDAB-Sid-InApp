//
//  AppStart.h
//  Sid-InApp
//
//  Created by  on 16/06/15.
//  Copyright (c) 2015 Ehb.be. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PersistentStack.h"
#import "RestfulStack.h"
#import "PersistentStoreManager.h"
#import "SynchronizationService.h"

@interface AppStart : NSObject

@property (nonatomic, strong) PersistentStack *persistentStack;
@property (nonatomic, strong) RestfulStack *restfulStack;
@property (nonatomic, strong) PersistentStoreManager *persistentStoreManager;
@property (nonatomic, strong) SynchronizationService *synchronizationService;

-(id)init;

-(void)initializeApp:(NSString *)secret;

-(BOOL)hasBeenInitialized;
-(BOOL)hasBeenInitialized:(NSString *)secret;
-(void)setBaseURL;
-(void)initializeRestfulStack:(NSString *)baseServiceUrl;
-(void)initializeSynchronizationService;

@end

