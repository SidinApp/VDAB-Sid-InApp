//
//  SchoolEntityList.h
//  Sid-In App Data Model
//
//  Created by Bert Remmerie on 07/06/15.
//  Copyright (c) 2015 EhB.be. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SchoolEntity;

@interface SchoolEntityList : NSManagedObject

@property (nonatomic, retain) NSSet *schools;
@end

@interface SchoolEntityList (CoreDataGeneratedAccessors)

- (void)addSchoolsObject:(SchoolEntity *)value;
- (void)removeSchoolsObject:(SchoolEntity *)value;
- (void)addSchools:(NSSet *)values;
- (void)removeSchools:(NSSet *)values;

@end
