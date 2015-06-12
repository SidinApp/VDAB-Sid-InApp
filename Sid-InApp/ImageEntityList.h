//
//  ImageEntityList.h
//  Sid-In App Data Model
//
//  Created by Bert Remmerie on 07/06/15.
//  Copyright (c) 2015 EhB.be. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ImageEntity;

@interface ImageEntityList : NSManagedObject

@property (nonatomic, retain) NSSet *images;
@end

@interface ImageEntityList (CoreDataGeneratedAccessors)

- (void)addImagesObject:(ImageEntity *)value;
- (void)removeImagesObject:(ImageEntity *)value;
- (void)addImages:(NSSet *)values;
- (void)removeImages:(NSSet *)values;

@end
