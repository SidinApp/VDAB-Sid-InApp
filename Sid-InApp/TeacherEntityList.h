//
//  TeacherEntityList.h
//  Sid-In App Data Model
//
//  Created by Bert Remmerie on 07/06/15.
//  Copyright (c) 2015 EhB.be. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TeacherEntity;

@interface TeacherEntityList : NSManagedObject

@property (nonatomic, retain) NSSet *teachers;
@end

@interface TeacherEntityList (CoreDataGeneratedAccessors)

- (void)addTeachersObject:(TeacherEntity *)value;
- (void)removeTeachersObject:(TeacherEntity *)value;
- (void)addTeachers:(NSSet *)values;
- (void)removeTeachers:(NSSet *)values;

@end
