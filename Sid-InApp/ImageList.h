//
//  ImageList.h
//  Sid-In App Data Model
//
//  Created by Bert Remmerie on 07/06/15.
//  Copyright (c) 2015 EhB.be. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ModelMapping.h"

#import "ImageEntityList.h"
#import "Image.h"

@interface ImageList : NSObject <ModelMapping>

@property (nonatomic, retain) NSSet *images;

@end
