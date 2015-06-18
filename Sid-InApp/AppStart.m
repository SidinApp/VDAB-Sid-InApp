//
//  AppStart.m
//  Sid-InApp
//
//  Created by  on 16/06/15.
//  Copyright (c) 2015 Ehb.be. All rights reserved.
//

#import "AppStart.h"

#import "RestEntity.h"

@interface AppStart ()

@end

@implementation AppStart

NSString *const REST_ENTITY = @"RestEntity";


-(id)init{
    
    if (self = [super init]) {
        self.persistentStack = [[PersistentStack alloc] initWithStoreURL:[self createStoreURL:DATABASE_NAME] modelURL:[self createModelURL:DATAMODEL_NAME]];
        self.persistentStoreManager = [[PersistentStoreManager alloc] initWithPersistentStack:self.persistentStack];
    }
    
    NSLog(@"Persistent Store location: %@", [self.persistentStack persistentStoreURL]);
    
    return self;
}

-(void)initializeApp:(NSString *)secret{
    
//    @"http://deptcodes.appspot.com/deptcode/secret3"
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", DEPARTEMENT_SERVICE_URL, secret]]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    
    [request setHTTPMethod: @"GET"];
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    NSString* url = [[NSString alloc] initWithData:response
                                             encoding:NSUTF8StringEncoding];
//    NSLog(@"%@", url);
    
    if (![url isEqualToString:@""]) {
        RestEntity *restEntity = (RestEntity *)[self.persistentStoreManager insert:REST_ENTITY];
        restEntity.url = [NSString stringWithFormat:@"http://%@", url];
        restEntity.secret = secret;
        [self.persistentStoreManager save:restEntity];
        [self setBaseURL];
        [self initializeRestfulStack:BASE_SERVICE_URL];
        [self initializeSynchronizationService];
    }
    
    
}

-(BOOL)hasBeenInitialized{
    
    return [self.persistentStoreManager countForEntity:REST_ENTITY] > 0;
}

-(BOOL)hasBaseURL{
    return ![BASE_SERVICE_URL isEqualToString:@""];
}

-(void)setBaseURL{
    
    RestEntity *restEntity = [[self.persistentStoreManager fetchAll:REST_ENTITY] firstObject];
    BASE_SERVICE_URL = restEntity.url;
}

-(void)initializeRestfulStack:(NSString *)baseServiceUrl{
    
    NSURL *baseServiceURL = [NSURL URLWithString:baseServiceUrl];
    self.restfulStack = [[RestfulStack alloc] initWithServiceURL:baseServiceURL persistentStack:self.persistentStack];
}

-(void)initializeSynchronizationService{
    self.synchronizationService = [[SynchronizationService alloc] initWithRestfulStack:self.restfulStack persistentStoreManager:self.persistentStoreManager];
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

@end
