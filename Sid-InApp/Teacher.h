//
//  Teacher.h
//  Sid-In App Data Model
//
//  Created by Bert Remmerie on 07/06/15.
//  Copyright (c) 2015 EhB.be. All rights reserved.
//

#import "ModelMapping.h"

#import "TeacherEntity.h"

@interface Teacher : NSObject <ModelMapping>

// copy ipv retain

@property (nonatomic, copy) NSNumber * acadyear;
@property (nonatomic, copy) NSNumber * id;
@property (nonatomic, copy) NSString * name;

@end
