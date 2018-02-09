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
#import "Contact.h"
@import MapKit;
@import CoreLocation;

@interface MapViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
//@property (strong, nonatomic) NSArray<Pet *> *pets;
@property (strong, nonatomic) NSArray<Contact<MKAnnotation> *> *shelters;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.locationManager = [[CLLocationManager alloc] init];

    [self.locationManager requestWhenInUseAuthorization];
    [self.mapView setShowsUserLocation:YES];
    [self.locationManager setDelegate:self];

    NSString *loc = @"M9R3N4";
    [self loadFilterLocation:loc];
    [self loadShelters:loc];

}

- (void)getGeoInformations:(NSString *)location completionHandler:(void (^)(CLLocationCoordinate2D))completion {
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder geocodeAddressString:location completionHandler:^(NSArray* placemarks, NSError* error){
        
        if(error) {
            NSLog(@"Error");
            return;
        }
        
        CLPlacemark *placemark = [placemarks lastObject];
        NSString *str_latitude = [NSString stringWithFormat: @"%f", placemark.location.coordinate.latitude];
        NSString *str_longitude = [NSString stringWithFormat: @"%f", placemark.location.coordinate.longitude];
        CLLocationCoordinate2D locationCoordinates = CLLocationCoordinate2DMake([str_latitude floatValue],
                                                                                [str_longitude floatValue]);
        completion(locationCoordinates);
    }];
    
    // #3 - Anything here will be called during view did load, but BEFORE the completion handler of the geocoding process is called.
}

- (void)loadFilterLocation:(NSString *)location {
    [self getGeoInformations:location  completionHandler:^(CLLocationCoordinate2D locationCoordinates) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.mapView setRegion:MKCoordinateRegionMake(locationCoordinates, MKCoordinateSpanMake(0.2, 0.2))];
        }];
    } ];
}

- (void)loadShelters:(NSString *)location {
    [NetworkManager fetchShelterDataFromLocation:location completionHandler:^(NSArray<Contact *> *contacts) {
        self.shelters = contacts;

        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.mapView addAnnotations:self.shelters];
            //[self.mapView showAnnotations:self.shelters animated:YES];
        }];

    }];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorizedAlways) {
        [self.locationManager requestLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *currentLocation = locations[0];
 //   [self.mapView setRegion:MKCoordinateRegionMake(currentLocation.coordinate, MKCoordinateSpanMake(0.06, 0.06))];

}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"ERROR\nERROR\nERROR\nERROR\nERROR\nERROR\nERROR\n");
}

@end
