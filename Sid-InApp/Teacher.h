//
//  Teacher.h
//  Sid-InApp
//
//  Created by  on 04/06/15.
//  Copyright (c) 2015 Ehb.be. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Teacher : NSManagedObject

@property (nonatomic, retain) NSNumber * acadyear;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;

@end
