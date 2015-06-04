//
//  BackendUtils.h
//  Sidin App
//
//  Created by  on 01/06/15.
//  Copyright (c) 2015 ehb.be. All rights reserved.
//

#import <Foundation/Foundation.h>

// http://stackoverflow.com/questions/3510862/constant-in-objective-c
// http://www.numbergrinder.com/2008/12/static-constant-strings-in-objective-c/

@interface SidInUtils : NSObject

extern NSString *const DATABASE_NAME;

extern NSString *const DEPARTEMENT_SERVICE_URL;

extern NSString *const BASE_SERVICE_URL;

extern NSString *const TEACHER_URL_PATTERN;
extern NSString *const TEACHERS_URL_PATTERN;

extern NSString *const EVENT_URL_PATTERN;
extern NSString *const EVENTS_URL_PATTERN;

extern NSString *const SCHOOL_URL_PATTERN;
extern NSString *const SCHOOLS_URL_PATTERN;

extern NSString *const SUBSCRIPTION_URL_PATTERN;
extern NSString *const SUBSCRIPTIONS_URL_PATTERN;

extern NSString *const IMAGE_URL_PATTERN;

@end
