//
//  RestEntity.h
//  Sid-InApp
//
//  Created by  on 18/06/15.
//  Copyright (c) 2015 Ehb.be. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface RestEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * secret;

@end
