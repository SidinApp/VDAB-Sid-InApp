//
//  RestfulService.h
//  
//
//  Created by Bert Remmerie on 06/06/15.
//
//

#import <RestKit/CoreData.h>
#import <RestKit/RestKit.h>

#import "PersistentStack.h"

@interface RestfulStack : NSObject

@property (nonatomic, readonly) RKObjectManager *objectManager;
@property (nonatomic, readonly) RKManagedObjectStore *managedObjectStore;

@property (nonatomic, readonly) PersistentStack *persistentStack;

@property (nonatomic, readonly) NSArray *responseDescriptors;
@property (nonatomic, readonly) NSArray *requestDescriptors;

@property (nonatomic, strong, readonly) RKRouteSet *routeSet;
-(id)initWithServiceURL:(NSURL *)serviceURL persistentStack:(PersistentStack *)persistentStack;

-(void)addResponseDescriptor:(RKResponseDescriptor *)responseDescriptor;
-(void)addRequestDescriptor:(RKRequestDescriptor *)requestDescriptor;
-(RKResponseDescriptor *)createAndAddResponseDescriptor:(id)mapping method:(RKRequestMethod)request pathPattern:(NSString *)pathPattern;
-(RKResponseDescriptor *)createAndAddResponseDescriptor:(id)mapping method:(RKRequestMethod)request pathPattern:(NSString *)pathPattern keyPath:(NSString *)keyPath;

-(RKResponseDescriptor *)createResponseDescriptor:(id)mapping method:(RKRequestMethod)request pathPattern:(NSString *)pathPattern;
-(RKResponseDescriptor *)createResponseDescriptor:(id)mapping method:(RKRequestMethod)request pathPattern:(NSString *)pathPattern keyPath:(NSString *)keyPath;

-(RKRequestDescriptor *)createAndAddRequestDescriptor:(id)mapping objectClass:(Class)objectClass method:(RKRequestMethod)request;
-(RKRequestDescriptor *)createAndAddRequestDescriptor:(id)mapping objectClass:(Class)objectClass method:(RKRequestMethod)request rootKeyPath:(NSString *)keyPath;

-(RKRequestDescriptor *)createRequestDescriptor:(id)mapping objectClass:(Class)objectClass method:(RKRequestMethod)request;
-(RKRequestDescriptor *)createRequestDescriptor:(id)mapping objectClass:(Class)objectClass method:(RKRequestMethod)request rootKeyPath:(NSString *)keyPath;

-(RKRoute *)createRoutWithName:(NSString *)routeName pathPattern:(NSString *)
pathPattern method:(RKRequestMethod)requestMethod;

-(RKRoute *)createAndAddRoutWithName:(NSString *)routeName pathPattern:(NSString *)
pathPattern method:(RKRequestMethod)requestMethod;

+(BOOL)isRestReachable;

@end
