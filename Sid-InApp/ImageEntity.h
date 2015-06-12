//
//  ImageEntity.h
//  Sid-InApp
//
//  Created by  on 12/06/15.
//  Copyright (c) 2015 Ehb.be. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ImageEntity : NSManagedObject

@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSNumber * priority;
@property (nonatomic, retain) NSNumber * id;

@end
