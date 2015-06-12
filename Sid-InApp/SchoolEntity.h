//
//  SchoolEntity.h
//  Sid-InApp
//
//  Created by  on 12/06/15.
//  Copyright (c) 2015 Ehb.be. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SchoolEntity : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * gemeente;
@property (nonatomic, retain) NSString * postcode;

@end
