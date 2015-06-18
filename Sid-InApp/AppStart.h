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

/*
 NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://deptcodes.appspot.com/deptcode/secret3"]
 cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
 timeoutInterval:10];
 
 [request setHTTPMethod: @"GET"];
 
 NSError *requestError;
 NSURLResponse *urlResponse = nil;
 
 
 NSData *response1 = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
 NSString* newStr = [[NSString alloc] initWithData:response1
 encoding:NSUTF8StringEncoding];
 NSLog(@"%@", newStr);
 
 */

/*
-(void)initializeStacks{
 
    [self enableLogging];
 
    NSURL *storeURL = [self createStoreURL:DATABASE_NAME];
    NSURL *modelURL = [self createModelURL:DATAMODEL_NAME];
    NSURL *baseServiceURL = [NSURL URLWithString:BASE_SERVICE_URL];
    
    self.persistentStack = [[PersistentStack alloc] initWithStoreURL:storeURL modelURL:modelURL];
    self.restfulStack = [[RestfulStack alloc] initWithServiceURL:baseServiceURL persistentStack:self.persistentStack];
    self.persistentStoreManager = [[PersistentStoreManager alloc] initWithPersistentStack:self.persistentStack];
    self.synchronizationService = [[SynchronizationService alloc] initWithRestfulStack:self.restfulStack persistentStoreManager:self.persistentStoreManager];
    
    NSLog(@"Persistent Store location: %@", [self.persistentStack persistentStoreURL]);
}

-(void)enableLogging{
    
    // Log all HTTP traffic with request and response bodies
    RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
    
    // Log debugging info about Core Data
    RKLogConfigureByName("RestKit/CoreData", RKLogLevelDebug);
    
    // Raise logging for a block
    RKLogWithLevelWhileExecutingBlock(RKLogLevelTrace, ^{
        // Do something that generates logs
    });
}

- (NSURL*)createStoreURL:(NSString *)databaseName{
    
    NSURL* documentsDirectory = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory
                                                                       inDomain:NSUserDomainMask
                                                              appropriateForURL:nil
                                                                         create:YES
                                                                          error:NULL];
    
    return [documentsDirectory URLByAppendingPathComponent:databaseName];
}

- (NSURL*)createModelURL:(NSString *)modelName{
    
    return [[NSBundle mainBundle] URLForResource:modelName withExtension:@"momd"];
}
*/