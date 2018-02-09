//
//  MapViewController.m
//  AdoptAPet
//
//  Created by Fernando Zanei on 2018-02-08.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import "MapViewController.h"
#import "NetworkManager.h"
#import "Pet.h"
@import MapKit;
@import CoreLocation;

@interface MapViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
//@property (strong, nonatomic) NSArray<Pet *> *pets;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getGeoInformations];
}

- (void)getGeoInformations {
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder geocodeAddressString:@"M5V 2H8" completionHandler:^(NSArray* placemarks, NSError* error){
        
        if(error) {
            NSLog(@"Error");
            return;
        }
        
        CLPlacemark *placemark = [placemarks lastObject];
        NSString *str_latitude = [NSString stringWithFormat: @"%f", placemark.location.coordinate.latitude];
        NSString *str_longitude = [NSString stringWithFormat: @"%f", placemark.location.coordinate.longitude];
        NSLog(@"lat: %f    long: %f", [str_latitude doubleValue], [str_longitude doubleValue]);
        CLLocationCoordinate2D location = CLLocationCoordinate2DMake([str_latitude doubleValue],
                                                                     [str_longitude doubleValue]);
        
        [self.mapView setRegion:MKCoordinateRegionMake(location, MKCoordinateSpanMake(0.06, 0.06))];
    }];
    
    // #3 - Anything here will be called during view did load, but BEFORE the completion handler of the geocoding process is called.
}

@end
