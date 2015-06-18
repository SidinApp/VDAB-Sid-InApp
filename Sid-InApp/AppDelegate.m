//
//  AppDelegate.m
//  Sid-InApp
//
//  Created by  on 04/06/15.
//  Copyright (c) 2015 Ehb.be. All rights reserved.
//

#import "AppDelegate.h"
#import "SidInUtils.h"

#import "DepartementViewController.h"
#import "LoginViewController.h"

@interface AppDelegate ()
{
    NSURL *storeURL;
    NSPersistentStore *persStoreCoord;
}
@end

@implementation AppDelegate




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // set status bar stijl
    [self setStatusBarStyle];
    
    // RESTKIT + CORE DATA
//    [self initializeStacks];   
    
//    [self.synchronizationService startSynchronization];
    
    // seed persistent store from back-end
//    [self.synchronizationService initializePersistentStoreFromBackEnd];
    
    // ==================================================================
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
    
    // ==================================================================
    
    NSString *storyboardIdDep = @"departementVC";
    NSString *storyboardIdLogin = @"loginVC";
    
 /*   BOOL appIsInitialized = NO;
    
    if (!appIsInitialized) {
        self.window.rootViewController = [self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:storyboardIdDep];
        DepartementViewController *viewController = (DepartementViewController *)[self.window rootViewController];
        viewController.synchronizationService = self.synchronizationService;
    } else {
        self.window.rootViewController = [self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:storyboardIdLogin];
        LoginViewController *viewController = (LoginViewController *)[self.window rootViewController];
        viewController.synchronizationService = self.synchronizationService;
    }
    */
    
    self.window.rootViewController = [self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:storyboardIdDep];
    DepartementViewController *viewController = (DepartementViewController *)[self.window rootViewController];
    viewController.synchronizationService = self.synchronizationService;
    
    return YES;
}
-(void)setStatusBarStyle{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - RESTKIT & CORE DATA

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

@end
