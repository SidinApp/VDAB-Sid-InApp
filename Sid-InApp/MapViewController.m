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
#import "Subscription.h"

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
    NSUInteger fromOostVlaanderen = [persistentStoreManager countForEntity:@"SubscriptionEntity" forPredicate:[NSPredicate predicateWithFormat:@"zip >= %@ AND zip <= %@", @"9000", @"9999"]];
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
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSTimeInterval timeinterval = ([[NSDate date] timeIntervalSince1970]*1000.0);
    
    NSNumber *test = [NSNumber numberWithDouble:timeinterval];
    long long value = [test longLongValue];
    
    NSDate *longLongToDate = [PersistentStoreManager convertLongLongToDate:value];
    NSDate *dateWithoutTime = [PersistentStoreManager convertToDateWithoutTime:longLongToDate];
    
    NSTimeInterval intervalToday = ([dateWithoutTime timeIntervalSince1970]*1000.0);
    NSNumber *nToday = [NSNumber numberWithDouble:intervalToday];
    long long llToday = [nToday longLongValue];
    
    NSURL *storeURL = [self createStoreURL:DATABASE_NAME];
    NSURL *modelURL = [self createModelURL:DATAMODEL_NAME];
    PersistentStack *persistentStack = [[PersistentStack alloc] initWithStoreURL:storeURL modelURL:modelURL];
    PersistentStoreManager *persistentStoreManager = [[PersistentStoreManager alloc] initWithPersistentStack:persistentStack];
    
    NSInteger subsToday = [persistentStoreManager countForEntity:@"SubscriptionEntity" forPredicate:[NSPredicate predicateWithFormat:@"timestamp == %lld",llToday]];
    
    return subsToday;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSTimeInterval timeinterval = ([[NSDate date] timeIntervalSince1970]*1000.0);
    
    NSNumber *test = [NSNumber numberWithDouble:timeinterval];
    long long value = [test longLongValue];
    
    NSDate *longLongToDate = [PersistentStoreManager convertLongLongToDate:value];
    NSDate *dateWithoutTime = [PersistentStoreManager convertToDateWithoutTime:longLongToDate];
    
    NSTimeInterval intervalToday = ([dateWithoutTime timeIntervalSince1970]*1000.0);
    NSNumber *nToday = [NSNumber numberWithDouble:intervalToday];
    long long llToday = [nToday longLongValue];
    
    NSURL *storeURL = [self createStoreURL:DATABASE_NAME];
    NSURL *modelURL = [self createModelURL:DATAMODEL_NAME];
    PersistentStack *persistentStack = [[PersistentStack alloc] initWithStoreURL:storeURL modelURL:modelURL];
    PersistentStoreManager *persistentStoreManager = [[PersistentStoreManager alloc] initWithPersistentStack:persistentStack];
    
    NSArray *subscriptions = [persistentStoreManager fetchByPredicate:[NSPredicate predicateWithFormat:@"timestamp == %lld", llToday] forEntity:@"SubscriptionEntity"];
    
    Subscription *currentSub = [subscriptions objectAtIndex:indexPath.row];
    NSString *fullName = [NSString stringWithFormat:@"%@ %@", currentSub.firstName, currentSub.lastName];
    NSString *interests;

    if(currentSub.interests.digx == [NSNumber numberWithInt:1]){
        if(currentSub.interests.multec == [NSNumber numberWithInt:1]){
            interests = @"Dig-x & Multec";
        } else {
            interests = @"Dig-x";
        }
    } else {
        interests = @"Multec";
    }

    cell.textLabel.text = fullName;
    cell.detailTextLabel.text = interests;
    
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
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
