//
//  MapViewController.m
//  Sid-InApp
//
//  Created by  on 16/06/15.
//  Copyright (c) 2015 Ehb.be. All rights reserved.
//

#import "MapViewController.h"
#import "PersistentStoreManager.h"
#import "SynchronizationService.h"
#import "SidInUtils.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *storeURL = [self createStoreURL:DATABASE_NAME];
    NSURL *modelURL = [self createModelURL:DATAMODEL_NAME];
    PersistentStack *persistentStack = [[PersistentStack alloc] initWithStoreURL:storeURL modelURL:modelURL];
    PersistentStoreManager *persistentStoreManager = [[PersistentStoreManager alloc] initWithPersistentStack:persistentStack];
    
    NSUInteger fromBrussel = [persistentStoreManager countForEntity:@"SubscriptionEntity" forPredicate:[NSPredicate predicateWithFormat:@"zip >= %@ AND zip < %@", @"1000", @"1500"]];
    NSUInteger fromAntwerpen = [persistentStoreManager countForEntity:@"SubscriptionEntity" forPredicate:[NSPredicate predicateWithFormat:@"zip >= %@ AND zip < %@", @"2000", @"3000"]];
    NSUInteger fromLimburg = [persistentStoreManager countForEntity:@"SubscriptionEntity" forPredicate:[NSPredicate predicateWithFormat:@"zip >= %@ AND zip < %@", @"3500", @"4000"]];
    NSUInteger fromOostVlaanderen = [persistentStoreManager countForEntity:@"SubscriptionEntity" forPredicate:[NSPredicate predicateWithFormat:@"zip >= %@ AND zip < %@", @"9000", @"10000"]];
    NSUInteger fromVlaamsBrabant = [persistentStoreManager countForEntity:@"SubscriptionEntity" forPredicate:[NSPredicate predicateWithFormat:@"zip >= %@ AND zip < %@ OR zip >=%@ AND zip < %@", @"1500", @"2000", @"3000", @"3500"]];
    NSUInteger fromWestVlaanderen = [persistentStoreManager countForEntity:@"SubscriptionEntity" forPredicate:[NSPredicate predicateWithFormat:@"zip >= %@ AND zip < %@", @"8000", @"9000"]];
    
    MKPointAnnotation *annoBrussel = [[MKPointAnnotation alloc] init];
    MKPointAnnotation *annoAntwerpen = [[MKPointAnnotation alloc] init];
    MKPointAnnotation *annoLimburg = [[MKPointAnnotation alloc] init];
    MKPointAnnotation *annoOostVlaanderen = [[MKPointAnnotation alloc] init];
    MKPointAnnotation *annoVlaamsBrabant = [[MKPointAnnotation alloc] init];
    MKPointAnnotation *annoWestVlaanderen = [[MKPointAnnotation alloc] init];
    
    annoBrussel.coordinate = CLLocationCoordinate2DMake(50.846726, 4.351748);
    annoAntwerpen.coordinate = CLLocationCoordinate2DMake(51.217955, 4.396527);
    annoLimburg.coordinate = CLLocationCoordinate2DMake(50.930404, 5.339884);
    annoOostVlaanderen.coordinate = CLLocationCoordinate2DMake(51.056837, 3.727310);
    annoVlaamsBrabant.coordinate = CLLocationCoordinate2DMake(50.878704, 4.701493);
    annoWestVlaanderen.coordinate = CLLocationCoordinate2DMake(51.205178, 3.227656);
    
    annoBrussel.title = @"Provincie Brussel";
    annoAntwerpen.title = @"Provincie Antwerpen";
    annoLimburg.title = @"Provincie Limburg";
    annoOostVlaanderen.title = @"Provincie Oost Vlaanderen";
    annoVlaamsBrabant.title = @"Provincie Vlaams Brabant";
    annoWestVlaanderen.title = @"Provincie West Vlaanderen";
    
    annoBrussel.subtitle = [NSString stringWithFormat:@"Aantal studenten uit deze provincie: %lu", (unsigned long)fromBrussel];
    annoAntwerpen.subtitle = [NSString stringWithFormat:@"Aantal studenten uit deze provincie: %lu", (unsigned long)fromAntwerpen];
    annoLimburg.subtitle = [NSString stringWithFormat:@"Aantal studenten uit deze provincie: %lu", (unsigned long)fromLimburg];
    annoOostVlaanderen.subtitle = [NSString stringWithFormat:@"Aantal studenten uit deze provincie: %lu", (unsigned long)fromOostVlaanderen];
    annoVlaamsBrabant.subtitle = [NSString stringWithFormat:@"Aantal studenten uit deze provincie: %lu", (unsigned long)fromVlaamsBrabant];
    annoWestVlaanderen.subtitle = [NSString stringWithFormat:@"Aantal studenten uit deze provincie: %lu", (unsigned long)fromWestVlaanderen];
    
    [self.mapView addAnnotation:annoBrussel];
    [self.mapView addAnnotation:annoAntwerpen];
    [self.mapView addAnnotation:annoLimburg];
    [self.mapView addAnnotation:annoOostVlaanderen];
    [self.mapView addAnnotation:annoVlaamsBrabant];
    [self.mapView addAnnotation:annoWestVlaanderen];
    
    MKMapRect zoomRect = MKMapRectNull;
    for (id <MKAnnotation> annotation in _mapView.annotations)
    {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
        zoomRect = MKMapRectUnion(zoomRect, pointRect);
    }
    
    double inset = -zoomRect.size.width * 0.1;
    [self.mapView setVisibleMapRect:MKMapRectInset(zoomRect, inset, 0) animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/* GET COORDINATES FROM TOUCH
 
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches){
        CGPoint pt = [touch  locationInView:_mapView];
        CLLocationCoordinate2D coord= [_mapView convertPoint:pt toCoordinateFromView:_mapView];
        NSLog(@"lat: %f /n long: %f", coord.latitude,coord.longitude);
    }
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    CLLocationCoordinate2D coord= [_mapView convertPoint:point toCoordinateFromView:_mapView];
    NSLog(@"lat  %f",coord.latitude);
    NSLog(@"long %f",coord.longitude);
    
    
    return NULL;
}
*/


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSDate *dateNow = [NSDate date];
    long currentDate = (long) ([dateNow timeIntervalSince1970]*1000.0);
    NSLog(@"currentDate: %ld", currentDate);
    
    NSDate *longToDate = [SynchronizationService convertLongToDate:currentDate];
    NSLog(@"longToDate: %@", longToDate);
    
    NSDate *dateWithoutTime = [SynchronizationService convertToDateWithoutTime:longToDate];
    NSLog(@"dateWithoutTime: %@", dateWithoutTime);
    
    currentDate = (long) dateWithoutTime;
    NSLog(@"currentDate: %ld", currentDate);
    
    
    NSURL *storeURL = [self createStoreURL:DATABASE_NAME];
    NSURL *modelURL = [self createModelURL:DATAMODEL_NAME];
    PersistentStack *persistentStack = [[PersistentStack alloc] initWithStoreURL:storeURL modelURL:modelURL];
    PersistentStoreManager *persistentStoreManager = [[PersistentStoreManager alloc] initWithPersistentStack:persistentStack];
    
    NSInteger subsToday = [persistentStoreManager countForEntity:@"SubscriptionEntity" forPredicate:[NSPredicate predicateWithFormat:@"timestamp == %ld",currentDate]];
    
    NSLog(@"sub count: %lu", (unsigned long)subsToday);
    
    return subsToday;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    
    
    return cell;
}

- (NSURL*)createStoreURL:(NSString *)databaseName{
    
    NSURL* documentsDirectory = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory
                                                                       inDomain:NSUserDomainMask
                                                              appropriateForURL:nil
                                                                         create:YES
                                                                          error:NULL];
    
    return [documentsDirectory URLByAppendingPathComponent:databaseName];
}

- (NSURL*)createModelURL:(NSString *)modelName{
    
    return [[NSBundle mainBundle] URLForResource:modelName withExtension:@"momd"];
}

@end
