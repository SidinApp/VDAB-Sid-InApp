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

@property (nonatomic, strong) AppStart *appStart;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // set status bar stijl
    [self setStatusBarStyle];
    
    self.appStart = [[AppStart alloc] init];
    
    if ([self.appStart hasBeenInitialized]) {
        
        self.window.rootViewController = [self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
        LoginViewController *viewController = (LoginViewController *)[self.window rootViewController];
        [self.appStart setBaseURL];
        [self.appStart initializeRestfulStack:BASE_SERVICE_URL];
        [self.appStart initializeSynchronizationService];
        viewController.synchronizationService = self.appStart.synchronizationService;
        
    } else {
        
        self.window.rootViewController = [self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"departementVC"];
        DepartementViewController *viewController = (DepartementViewController *)[self.window rootViewController];
        viewController.appStart = self.appStart;
    }
    
    
    return YES;
}

-(void)setStatusBarStyle{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

#pragma mark - RESTKIT & CORE DATA



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

@end
