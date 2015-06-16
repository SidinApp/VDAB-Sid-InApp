//
//  MapViewController.m
//  Sid-InApp
//
//  Created by  on 16/06/15.
//  Copyright (c) 2015 Ehb.be. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
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
    
    [self.mapView addAnnotation:annoBrussel];
    [self.mapView addAnnotation:annoAntwerpen];
    [self.mapView addAnnotation:annoLimburg];
    [self.mapView addAnnotation:annoOostVlaanderen];
    [self.mapView addAnnotation:annoVlaamsBrabant];
    [self.mapView addAnnotation:annoWestVlaanderen];
    
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

- (IBAction)changeMapType:(id)sender {
    
    if (_mapView.mapType == MKMapTypeStandard){
        _mapView.mapType = MKMapTypeSatellite;
    } else {
        _mapView.mapType = MKMapTypeStandard;
    }
}
@end
