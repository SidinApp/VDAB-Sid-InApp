//
//  TeacherEntity.h
//  Sid-InApp
//
//  Created by  on 12/06/15.
//  Copyright (c) 2015 Ehb.be. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TeacherEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * acadyear;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * id;

@end
