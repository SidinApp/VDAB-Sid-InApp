//
//  SchoolContainer.h
//  Sid-InApp
//
//  Created by  on 04/06/15.
//  Copyright (c) 2015 Ehb.be. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class School;

@interface SchoolContainer : NSManagedObject

@property (nonatomic, retain) NSSet *schools;
@end

@interface SchoolContainer (CoreDataGeneratedAccessors)

- (void)addSchoolsObject:(School *)value;
- (void)removeSchoolsObject:(School *)value;
- (void)addSchools:(NSSet *)values;
- (void)removeSchools:(NSSet *)values;

@end
