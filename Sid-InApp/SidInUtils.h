//
//  SidInUtils.h
//  Sidin App
//
//  Created by  on 01/06/15.
//  Copyright (c) 2015 ehb.be. All rights reserved.
//

// http://stackoverflow.com/questions/3510862/constant-in-objective-c
// http://www.numbergrinder.com/2008/12/static-constant-strings-in-objective-c/

#import <Foundation/Foundation.h>

@interface SidInUtils : NSObject

extern NSString *const DATABASE_NAME;
extern NSString *const DATAMODEL_NAME;


extern NSString *const DEPARTEMENT_SERVICE_URL;


extern NSString *const BASE_SERVICE_URL;


extern NSString *const TEACHER;
extern NSString *const TEACHER_LIST;

extern NSString *const TEACHER_URL_PATTERN;
extern NSString *const TEACHERS_URL_PATTERN;
extern NSString *const TEACHER_ID_URL_PATTERN;
extern NSString *const TEACHERS_ACADYEAR_URL_PATTERN;

extern NSString *const TEACHERS_GET_ROUTE;
extern NSString *const TEACHERS_GET_ACADYEAR_ROUTE;
extern NSString *const TEACHER_POST_ROUTE;
extern NSString *const TEACHER_GET_ID_ROUTE;
extern NSString *const TEACHER_DELETE_ID_ROUTE;


extern NSString *const EVENT;
extern NSString *const EVENT_LIST;

extern NSString *const EVENT_URL_PATTERN;
extern NSString *const EVENTS_URL_PATTERN;
extern NSString *const EVENT_ID_URL_PATTERN;
extern NSString *const EVENTS_ACADYEAR_URL_PATTERN;

extern NSString *const EVENTS_GET_ROUTE;
extern NSString *const EVENTS_GET_ACADYEAR_ROUTE;
extern NSString *const EVENT_POST_ROUTE;
extern NSString *const EVENT_GET_ID_ROUTE;
extern NSString *const EVENT_DELETE_ID_ROUTE;


extern NSString *const SCHOOL;
extern NSString *const SCHOOL_LIST;

extern NSString *const SCHOOL_URL_PATTERN;
extern NSString *const SCHOOLS_URL_PATTERN;
extern NSString *const SCHOOL_ID_URL_PATTERN;

extern NSString *const SCHOOLS_GET_ROUTE;
extern NSString *const SCHOOL_POST_ROUTE;
extern NSString *const SCHOOL_GET_ID_ROUTE;
extern NSString *const SCHOOL_DELETE_ID_ROUTE;


extern NSString *const SUBSCRIPTION;
extern NSString *const SUBSCRIPTION_LIST;

extern NSString *const SUBSCRIPTION_URL_PATTERN;
extern NSString *const SUBSCRIPTIONS_URL_PATTERN;
extern NSString *const SUBSCRIPTION_ID_URL_PATTERN;

extern NSString *const SUBSCRIPTIONS_GET_ROUTE;
extern NSString *const SUBSCRIPTION_POST_ROUTE;
extern NSString *const SUBSCRIPTION_GET_ID_ROUTE;
extern NSString *const SUBSCRIPTION_DELETE_ID_ROUTE;


extern NSString *const IMAGE;
extern NSString *const IMAGE_LIST;

extern NSString *const IMAGE_URL_PATTERN;
extern NSString *const IMAGE_SCRIPTION_URL_PATTERN;

extern NSString *const IMAGE_GET_ROUTE;
extern NSString *const IMAGE_POST_ROUTE;
extern NSString *const IMAGE_SCRIPTION_DELETE_ID_ROUTE;

@end
