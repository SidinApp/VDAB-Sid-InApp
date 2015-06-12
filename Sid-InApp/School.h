//
//  School.h
//  Sid-In App Data Model
//
//  Created by Bert Remmerie on 07/06/15.
//  Copyright (c) 2015 EhB.be. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ModelMapping.h"

#import "SchoolEntity.h"

@interface School : NSObject <ModelMapping>

@property (nonatomic, copy) NSString * gemeente;
@property (nonatomic, copy) NSNumber * id;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSNumber * postcode;

@end
