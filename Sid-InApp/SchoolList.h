//
//  SchoolList.h
//  Sid-In App Data Model
//
//  Created by Bert Remmerie on 07/06/15.
//  Copyright (c) 2015 EhB.be. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ModelMapping.h"

#import "SchoolEntityList.h"
#import "School.h"

@interface SchoolList : NSObject <ModelMapping>

// copy ipv retain

@property (nonatomic, copy) NSSet *schools;

@end
