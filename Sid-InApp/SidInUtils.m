//
//  BackendUtils.m
//  Sidin App
//
//  Created by  on 01/06/15.
//  Copyright (c) 2015 ehb.be. All rights reserved.
//

#import "SidInUtils.h"

// http://www.galloway.me.uk/tutorials/singleton-classes/

@implementation SidInUtils

NSString *const DATABASE_NAME = @"SidInDB.sqlite";

NSString *const DEPARTEMENT_SERVICE_URL = @"UNKNOWN";

NSString *const BASE_SERVICE_URL = @"http://vdabsidin3.appspot.com";

NSString *const TEACHER_URL_PATTERN = @"/rest/teacher";
NSString *const TEACHERS_URL_PATTERN = @"/rest/teachers";

NSString *const EVENT_URL_PATTERN = @"/rest/event";
NSString *const EVENTS_URL_PATTERN = @"/rest/events";

NSString *const SCHOOL_URL_PATTERN = @"/rest/school";
NSString *const SCHOOLS_URL_PATTERN = @"/rest/schools";

NSString *const SUBSCRIPTION_URL_PATTERN = @"/rest/subscription";
NSString *const SUBSCRIPTIONS_URL_PATTERN = @"/rest/subscriptions";

NSString *const IMAGE_URL_PATTERN = @"/rest/image";

@end
