//
//  DepartementaleCodeEntity.h
//  Sid-InApp
//
//  Created by  on 15/06/15.
//  Copyright (c) 2015 Ehb.be. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DepartementaleCodeEntity : NSManagedObject

@property (nonatomic, retain) NSString * code;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * naam;

@end
