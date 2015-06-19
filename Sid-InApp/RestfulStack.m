//
//  RestfulService.m
//  
//
//  Created by Bert Remmerie on 06/06/15.
//
//

#import "RestfulStack.h"
#import "SidInUtils.h"

@interface RestfulStack()

@property (nonatomic, readwrite) RKObjectManager *objectManager;
@property (nonatomic, readwrite) RKManagedObjectStore *managedObjectStore;

@property (nonatomic, readwrite) PersistentStack *persistentStack;

@property (nonatomic, readwrite) NSArray *responseDescriptors;
@property (nonatomic, readwrite) NSArray *requestDescriptors;

@property (nonatomic, readwrite) RKRouteSet *routeSet;

@property (nonatomic) NSURL *serviceURL;

@end

@implementation RestfulStack

-(id)initWithServiceURL:(NSURL *)serviceURL managedObjectStore:(RKManagedObjectStore *)managedObjectStore{
    
    self = [super init];
    
    if (self) {
        self.serviceURL = serviceURL;
        self.managedObjectStore = managedObjectStore;
        [self setupObjectManager];
        self.routeSet = self.objectManager.router.routeSet;
    }
    
    return self;
}

-(id)initWithServiceURL:(NSURL *)serviceURL persistentStack:(PersistentStack *)persistentStack{
    
    self = [self initWithServiceURL:serviceURL managedObjectStore:persistentStack.managedObjectStore];
    
    if (self) {
        self.persistentStack = persistentStack;
    }
    
    return self;
}


-(void)setupObjectManager{
    
    if (!self.objectManager) {
        self.objectManager = [RKObjectManager managerWithBaseURL:self.serviceURL];
        self.objectManager.managedObjectStore = self.managedObjectStore;
    }
}


-(void)addResponseDescriptor:(RKResponseDescriptor *)responseDescriptor{
    
    [self.objectManager addResponseDescriptor:responseDescriptor];
}

-(NSArray *)responseDescriptors{
    
    return [self.objectManager responseDescriptors];
}


-(void)addRequestDescriptor:(RKRequestDescriptor *)requestDescriptor{
    
    [self.objectManager addRequestDescriptor:requestDescriptor];
}

-(NSArray *)requestDescriptors{
    
    return [self.objectManager requestDescriptors];
}

-(RKRouteSet *)routeSet{
    return self.objectManager.router.routeSet;
}


-(RKResponseDescriptor *)createAndAddResponseDescriptor:(id)mapping method:(RKRequestMethod)request pathPattern:(NSString *)pathPattern{
    
    return [self createAndAddResponseDescriptor:mapping
                                         method:request
                                    pathPattern:pathPattern
                                        keyPath:nil];
}

-(RKResponseDescriptor *)createAndAddResponseDescriptor:(id)mapping method:(RKRequestMethod)request pathPattern:(NSString *)pathPattern keyPath:(NSString *)keyPath{
    
    RKResponseDescriptor *result = [self createResponseDescriptor:mapping
                                                           method:request
                                                      pathPattern:pathPattern
                                                          keyPath:keyPath];
    
    [self addResponseDescriptor:result];
    
    return result;
}

-(RKResponseDescriptor *)createResponseDescriptor:(id)mapping method:(RKRequestMethod)request pathPattern:(NSString *)pathPattern{
    
    return [self createResponseDescriptor:mapping
                                         method:request
                                    pathPattern:pathPattern
                                        keyPath:nil];
}

-(RKResponseDescriptor *)createResponseDescriptor:(id)mapping method:(RKRequestMethod)request pathPattern:(NSString *)pathPattern keyPath:(NSString *)keyPath{
    
    RKResponseDescriptor *result = [RKResponseDescriptor responseDescriptorWithMapping:mapping
                                                                                method:request
                                                                           pathPattern:pathPattern
                                                                               keyPath:keyPath
                                                                           statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    return result;
}


-(RKRequestDescriptor *)createAndAddRequestDescriptor:(id)mapping objectClass:(Class)objectClass method:(RKRequestMethod)request{
    
    RKRequestDescriptor *result = [self createAndAddRequestDescriptor:mapping objectClass:objectClass method:request rootKeyPath:nil];
    
    return result;
}

-(RKRequestDescriptor *)createAndAddRequestDescriptor:(id)mapping objectClass:(Class)objectClass method:(RKRequestMethod)request rootKeyPath:(NSString *)keyPath{
    
    RKRequestDescriptor *result = [RKRequestDescriptor requestDescriptorWithMapping:mapping objectClass:objectClass rootKeyPath:keyPath method:request];
    
    [self addRequestDescriptor:result];
    
    return result;
}

-(RKRequestDescriptor *)createRequestDescriptor:(id)mapping objectClass:(Class)objectClass method:(RKRequestMethod)request{
    
    return [self createRequestDescriptor:mapping objectClass:objectClass method:request rootKeyPath:nil];
}

-(RKRequestDescriptor *)createRequestDescriptor:(id)mapping objectClass:(Class)objectClass method:(RKRequestMethod)request rootKeyPath:(NSString *)keyPath{
    
    RKRequestDescriptor *result = [RKRequestDescriptor requestDescriptorWithMapping:mapping objectClass:objectClass rootKeyPath:keyPath method:request];
    
    return result;
}

-(RKRoute *)createRoutWithName:(NSString *)routeName pathPattern:(NSString *)pathPattern method:(RKRequestMethod)requestMethod{
    
    return [RKRoute routeWithName:routeName pathPattern:pathPattern method:requestMethod];
}

-(RKRoute *)createAndAddRoutWithName:(NSString *)routeName pathPattern:(NSString *)pathPattern method:(RKRequestMethod)requestMethod{

    RKRoute *result = [self createRoutWithName:routeName pathPattern:pathPattern method:requestMethod];
    
    [self.objectManager.router.routeSet addRoute:result];
    
    return result;
}

// http://stackoverflow.com/questions/19030513/how-to-check-for-network-reachability-in-ios
+(BOOL)isRestReachable{
    
    CFNetDiagnosticRef diagnosticReference = nil;
    diagnosticReference = CFNetDiagnosticCreateWithURL(NULL, (__bridge CFURLRef)[NSURL URLWithString:BASE_SERVICE_URL]);
    
    CFNetDiagnosticStatus status = 0;
    status = CFNetDiagnosticCopyNetworkStatusPassively(diagnosticReference, NULL);
    
    CFRelease(diagnosticReference);
    
    if (status == kCFNetDiagnosticConnectionUp) {
        
        return YES;
    } else {
        return NO;
    }
}

@end
