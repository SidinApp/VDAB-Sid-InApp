//
//  Interests.h
//  Sid-In App Data Model
//
//  Created by Bert Remmerie on 07/06/15.
//  Copyright (c) 2015 EhB.be. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ModelMapping.h"

#import "InterestsEntity.h"

@interface Interests : NSObject <ModelMapping>

@property (nonatomic, copy) NSNumber * digx;
@property (nonatomic, copy) NSNumber * multec;
@property (nonatomic, copy) NSNumber * werkstudent;

@end
