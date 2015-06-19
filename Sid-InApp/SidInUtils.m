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

NSString *const DATABASE_NAME = @"Sid-InApp.sqlite";
NSString *const DATAMODEL_NAME = @"Sid-InApp";


NSString *const DEPARTEMENT_SERVICE_URL = @"http://deptcodes.appspot.com/deptcode";

NSString *const REST_ENTITY = @"RestEntity";


NSString * BASE_SERVICE_URL;


NSString *const TEACHER = @"TeacherEntity";
NSString *const TEACHER_LIST = @"TeacherEntityList";

NSString *const TEACHER_URL_PATTERN = @"/rest/teacher";
NSString *const TEACHERS_URL_PATTERN = @"/rest/teachers";
NSString *const TEACHER_ID_URL_PATTERN = @"/rest/teacher/:id";
NSString *const TEACHERS_ACADYEAR_URL_PATTERN = @"/rest/teachers/:acadyear";

NSString *const TEACHERS_GET_ROUTE = @"teachers_get_route";
NSString *const TEACHERS_GET_ACADYEAR_ROUTE = @"teachers_get_acadyear_route";
NSString *const TEACHER_POST_ROUTE = @"teacher_post_route";
NSString *const TEACHER_GET_ID_ROUTE = @"teacher_get_id_route";
NSString *const TEACHER_DELETE_ID_ROUTE = @"teacher_delete_id_route";


NSString *const EVENT = @"EventEntity";
NSString *const EVENT_LIST = @"EventEntityList";

NSString *const EVENT_URL_PATTERN = @"/rest/event";
NSString *const EVENTS_URL_PATTERN = @"/rest/events";
NSString *const EVENT_ID_URL_PATTERN = @"/rest/event/:id";
NSString *const EVENTS_ACADYEAR_URL_PATTERN = @"/rest/events/:acadyear";

NSString *const EVENTS_GET_ROUTE = @"events_get_route";
NSString *const EVENTS_GET_ACADYEAR_ROUTE = @"events_get_acadyear_route";
NSString *const EVENT_POST_ROUTE = @"event_post_route";
NSString *const EVENT_GET_ID_ROUTE = @"event_get_id_route";
NSString *const EVENT_DELETE_ID_ROUTE = @"event_delete_id_route";


NSString *const SCHOOL = @"SchoolEntity";
NSString *const SCHOOL_LIST = @"SchoolEntityList";

NSString *const SCHOOL_URL_PATTERN = @"/rest/school";
NSString *const SCHOOLS_URL_PATTERN = @"/rest/schools";
NSString *const SCHOOL_ID_URL_PATTERN = @"/rest/school/:id";

NSString *const SCHOOLS_GET_ROUTE = @"schools_get_route";
NSString *const SCHOOL_POST_ROUTE = @"school_post_route";
NSString *const SCHOOL_GET_ID_ROUTE = @"school_get_id_route";
NSString *const SCHOOL_DELETE_ID_ROUTE = @"school_delete_id_route";


NSString *const SUBSCRIPTION = @"SubscriptionEntity";
NSString *const SUBSCRIPTION_LIST = @"SubscriptionEntityList";
NSString *const SUBSCRIPTION_URL_PATTERN = @"/rest/subscription";
NSString *const SUBSCRIPTIONS_URL_PATTERN = @"/rest/subscriptions";
NSString *const SUBSCRIPTION_ID_URL_PATTERN = @"/rest/subscription/:id";
NSString *const SUBSCRIPTIONS_ACADYEAR_URL_PATTERN = @"/rest/subscriptions/:acadyear";

NSString *const SUBSCRIPTIONS_GET_ROUTE = @"subscriptions_get_route";
NSString *const SUBSCRIPTION_POST_ROUTE = @"subscription_post_route";
NSString *const SUBSCRIPTION_GET_ID_ROUTE = @"subscription_get_id_route";
NSString *const SUBSCRIPTION_DELETE_ID_ROUTE = @"subscription_delete_id_route";


NSString *const IMAGE = @"ImageEntity";
NSString *const IMAGE_LIST = @"ImageEntityList";
NSString *const IMAGE_VERSION = @"ImageVersionEntity";

NSString *const IMAGE_URL_PATTERN = @"/rest/image";
NSString *const IMAGE_SCRIPTION_URL_PATTERN = @"/rest/imagescription/:id";
NSString *const IMAGE_VERSION_URL_PATTERN = @"/rest/imagesversion";


NSString *const IMAGE_GET_ROUTE = @"image_get_route";
NSString *const IMAGE_POST_ROUTE = @"image_post_route";
NSString *const IMAGE_SCRIPTION_DELETE_ID_ID_ROUTE = @"image_scription_delete_id_route";

@end
