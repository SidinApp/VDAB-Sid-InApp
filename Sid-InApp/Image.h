//
//  Image.h
//  Sid-In App Data Model
//
//  Created by Bert Remmerie on 07/06/15.
//  Copyright (c) 2015 EhB.be. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ModelMapping.h"

#import "ImageEntity.h"

@interface Image : NSObject <ModelMapping>

@property (nonatomic, copy) NSNumber * id;
@property (nonatomic, copy) NSString * image;
@property (nonatomic, copy) NSNumber * priority;

@end
