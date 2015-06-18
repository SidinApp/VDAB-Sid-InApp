//
//  ImageVersionEntity.h
//  Sid-InApp
//
//  Created by  on 18/06/15.
//  Copyright (c) 2015 Ehb.be. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ImageVersionEntity : NSManagedObject

@property (nonatomic, retain) NSString * version;
@property (nonatomic, retain) NSNumber * id;

@end
